using System.IO.Compression;
namespace NscCore;
public static partial class NscContainer
{
    private static NscDecodeKind Decode(byte[] fileBytes, string label, out byte[] payload, out string problem)
    {
        payload = Array.Empty<byte>();
        problem = string.Empty;
        if (fileBytes.Length == 0)
        {
            problem = $"{label}: file is empty";
            return NscDecodeKind.BarePayload;
        }
        if (!HasRsc7Envelope(fileBytes))
        {
            if (!IsScriptPayload(fileBytes))
            {
                ulong first = fileBytes.Length >= 8 ? NscHeader.ReadU64(fileBytes, 0) : 0;
                problem = NscProfiles.IsEnvelopeMagicReadAsPageBase(first)
                    ? $"{label}: contains the RSC7 magic but not at offset 0, so it cannot be decoded as a container"
                    : $"{label}: not a Switch script payload (u64@0 = 0x{first:X16} is outside "
                      + $"0x{NscHeader.PageBaseMinimum:X16}..0x{NscHeader.PageBaseMaximum:X16}) and there is no RSC7 envelope to unwrap";
                return NscDecodeKind.BarePayload;
            }
            payload = fileBytes;
            return NscDecodeKind.BarePayload;
        }
        byte[] region = new byte[fileBytes.Length - Rsc7HeaderSize];
        Buffer.BlockCopy(fileBytes, Rsc7HeaderSize, region, 0, region.Length);
        bool regionLooksRaw = IsScriptPayload(region);
        if (regionLooksRaw && IsSelfConsistent(region))
        {
            payload = region;
            return NscDecodeKind.Rsc7Uncompressed;
        }
        byte[]? inflated = TryInflate(region);
        if (inflated != null && IsScriptPayload(inflated))
        {
            payload = inflated;
            return NscDecodeKind.Rsc7Deflate;
        }
        if (regionLooksRaw)
        {
            payload = region;
            return NscDecodeKind.Rsc7Uncompressed;
        }
        ulong regionFirst = region.Length >= 8 ? NscHeader.ReadU64(region, 0) : 0;
        if (inflated == null)
        {
            problem = $"{label}: has an RSC7 envelope but the payload is neither pointer-shaped (u64@0 = 0x{regionFirst:X16}) nor valid deflate data";
        }
        else
        {
            ulong inflatedFirst = inflated.Length >= 8 ? NscHeader.ReadU64(inflated, 0) : 0;
            problem = $"{label}: has an RSC7 envelope and inflates to {inflated.Length} bytes, but that is still not a switch script payload "
                    + $"(u64@0 = 0x{inflatedFirst:X16})";
        }
        return NscDecodeKind.Rsc7Deflate;
    }

    private static byte[]? TryInflate(byte[] region)
    {
        if (region.Length == 0) return null;
        var output = new MemoryStream();
        bool oversized = false;
        try
        {
            using var input = new MemoryStream(region, writable: false);
            using var deflate = new DeflateStream(input, CompressionMode.Decompress);
            byte[] buffer = new byte[81920];
            int read;
            while ((read = deflate.Read(buffer, 0, buffer.Length)) > 0)
            {
                if (output.Length + read > MaxInflatedBytes)
                {
                    oversized = true;
                    break;
                }
                output.Write(buffer, 0, read);
            }
        }
        catch (InvalidDataException)
        {
            output.Dispose();
            return null;
        }
        if (oversized)
        {
            output.Dispose();
            throw new NscFormatException($"deflate payload exceeds the {MaxInflatedBytes / (1024 * 1024)} MiB sanity limit");
        }
        return output.ToArray();
    }
}
