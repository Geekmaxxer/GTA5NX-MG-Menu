namespace NscCore;
public static partial class NscContainer
{
    public const uint Rsc7Magic = 0x37435352;
    public const int Rsc7HeaderSize = 16;
    public const long MaxInflatedBytes = 64L * 1024 * 1024;
    public static bool HasRsc7Envelope(byte[] fileBytes)
        => fileBytes.Length >= Rsc7HeaderSize && NscHeader.ReadU32(fileBytes, 0) == Rsc7Magic;
    public static bool IsScriptPayload(byte[] candidate)
        => candidate.Length >= NscHeader.MinimumPayloadSize
           && NscHeader.IsPageBaseShaped(NscHeader.PageBase(candidate));
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

    public static bool TryRead(byte[] fileBytes, string label, out byte[] payload, out NscDecodeKind kind, out string problem)
    {
        kind = Decode(fileBytes, label, out payload, out problem);
        return problem.Length == 0;
    }
}
