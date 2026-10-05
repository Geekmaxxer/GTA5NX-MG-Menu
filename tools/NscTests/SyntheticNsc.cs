using System.IO.Compression;
using System.Text;
using NscCore;
namespace NscTests;
internal static class SyntheticNsc
{
    public const ulong StockPageBase = 0x00007FF7BAD5B3A8UL;
    public const uint StockBuildWord = 0x94C75B53u;
    public const ulong CandidatePageBase = 0x00007FF748C9B3A8UL;
    public const uint CandidateBuildWord = 0x00000000u;
    public const int NameOffset = 0xC0;
    public const int CodeMarkerStart = 0x80;
    public const int CodeMarkerEnd = 0xBF;
    public static byte[] Payload(
        string name,
        ulong pageBase = StockPageBase,
        uint buildWord = StockBuildWord,
        uint codeLength = 0x40,
        uint nativeCount = 2)
    {
        byte[] nameBytes = Encoding.ASCII.GetBytes(name);
        int size = Math.Max(0x100, NameOffset + nameBytes.Length + 1 + 0x10);
        var payload = new byte[size];
        NscHeader.WriteU64(payload, NscHeader.PageBaseOffset, pageBase);
        NscHeader.WriteU64(payload, NscHeader.CodeBlocksPtrOffset, 0x50000040UL);
        NscHeader.WriteU32(payload, NscHeader.BuildWordOffset, buildWord);
        NscHeader.WriteU32(payload, NscHeader.CodeLengthOffset, codeLength);
        NscHeader.WriteU32(payload, NscHeader.NativeCountOffset, nativeCount);
        NscHeader.WriteU64(payload, NscHeader.NativeTablePtrOffset, 0x50000060UL);
        NscHeader.WriteU32(payload, NscHeader.NameHashOffset, NscHeader.Joaat(name));
        NscHeader.WriteU64(payload, NscHeader.NamePtrOffset, 0x50000000UL | NameOffset);
        for (int i = CodeMarkerStart; i <= CodeMarkerEnd; i++) payload[i] = (byte)((i * 7) & 0xFF);
        Buffer.BlockCopy(nameBytes, 0, payload, NameOffset, nameBytes.Length);
        payload[NameOffset + nameBytes.Length] = 0;
        return payload;
    }

    public static byte[] Deflate(byte[] data)
    {
        using var output = new MemoryStream();
        using (var deflate = new DeflateStream(output, CompressionLevel.Optimal, leaveOpen: true))
        {
            deflate.Write(data, 0, data.Length);
        }
        return output.ToArray();
    }

    public static byte[] CompressedContainer(byte[] payload, uint flag = 0x80) => Envelope(flag, Deflate(payload));
    public static byte[] UncompressedContainer(byte[] payload, uint flag = 0x80) => Envelope(flag, payload);
    public static byte[] Envelope(uint flag, byte[] body)
    {
        var file = new byte[NscContainer.Rsc7HeaderSize + body.Length];
        NscHeader.WriteU32(file, 0x00, NscContainer.Rsc7Magic);
        NscHeader.WriteU32(file, 0x04, 0x0000000C);
        NscHeader.WriteU32(file, 0x08, flag);
        NscHeader.WriteU32(file, 0x0C, 0xC0000000u);
        Buffer.BlockCopy(body, 0, file, NscContainer.Rsc7HeaderSize, body.Length);
        return file;
    }

    public static string WriteTempFile(string directory, string fileName, byte[] bytes)
    {
        Directory.CreateDirectory(directory);
        string path = Path.Combine(directory, fileName);
        File.WriteAllBytes(path, bytes);
        return path;
    }
}
