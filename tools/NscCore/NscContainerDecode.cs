namespace NscCore;

/// <summary>
/// Reads a GTA V Switch script container.
///
/// There is NO compression flag inside the RSC7 envelope to parse: byte@0x08
/// takes 19 distinct values across the 2,044 stock scripts and does not
/// correlate with compression (0x80 appears in both compressed stock files and
/// in our own uncompressed scriptrc output). So the envelope is decoded by trial:
///   1. no RSC7 magic at offset 0     -> the file is already a payload
///   2. RSC7 and region pointer-shaped and self-consistent -> uncompressed
///   3. RSC7 and region inflates to something pointer-shaped -> deflate
///   4. otherwise fail loudly, naming both attempts
/// Step 2 also confirms the internal name matches the stored name hash where
/// both are readable, so deflate bytes that happen to look pointer-shaped
/// cannot be mistaken for a payload.
/// </summary>
public static partial class NscContainer
{
    public const uint Rsc7Magic = 0x37435352;
    public const int Rsc7HeaderSize = 16;

    /// <summary>Sanity bound so a malformed container cannot inflate without limit.</summary>
    public const long MaxInflatedBytes = 64L * 1024 * 1024;

    public static bool HasRsc7Envelope(byte[] fileBytes)
        => fileBytes.Length >= Rsc7HeaderSize && NscHeader.ReadU32(fileBytes, 0) == Rsc7Magic;

    public static bool IsScriptPayload(byte[] candidate)
        => candidate.Length >= NscHeader.MinimumPayloadSize
           && NscHeader.IsPageBaseShaped(NscHeader.PageBase(candidate));

    /// <summary>The internal name and the stored name hash agree, so this really is a script header.</summary>
    public static bool IsSelfConsistent(byte[] payload)
        => NscHeader.TryInternalName(payload, out string name)
           && NscHeader.Joaat(name) == NscHeader.NameHash(payload);

    public static NscPayload ReadFile(string path, int exitCode = NscExitCodes.InvalidCandidate)
    {
        byte[] fileBytes;
        try
        {
            fileBytes = File.ReadAllBytes(path);
        }
        catch (Exception ex) when (ex is IOException or UnauthorizedAccessException)
        {
            throw new NscFormatException($"cannot read {path}: {ex.Message}", exitCode);
        }
        return Read(fileBytes, path, exitCode);
    }

    public static NscPayload Read(byte[] fileBytes, string label, int exitCode = NscExitCodes.InvalidCandidate)
    {
        NscDecodeKind kind = Decode(fileBytes, label, out byte[] payload, out string problem);
        if (problem.Length != 0) throw new NscFormatException(problem, exitCode);
        return new NscPayload { Bytes = payload, FileBytes = fileBytes, Path = label, Kind = kind };
    }

    /// <summary>
    /// Lenient decode for diagnostics: never throws, always reports what went
    /// wrong. Used by --info so a malformed artifact can still be described.
    /// </summary>
    public static bool TryRead(byte[] fileBytes, string label, out byte[] payload, out NscDecodeKind kind, out string problem)
    {
        kind = Decode(fileBytes, label, out payload, out problem);
        return problem.Length == 0;
    }
}
