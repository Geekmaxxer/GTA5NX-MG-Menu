namespace NscCore;
public enum NscDecodeKind
{
    BarePayload,
    Rsc7Uncompressed,
    Rsc7Deflate,
}

public sealed class NscPayload
{
    public required byte[] Bytes { get; init; }
    public required byte[] FileBytes { get; init; }
    public required string Path { get; init; }
    public required NscDecodeKind Kind { get; init; }
    public bool HadRsc7Envelope => Kind != NscDecodeKind.BarePayload;
    public ulong PageBase => NscHeader.PageBase(Bytes);
    public uint BuildWord => NscHeader.BuildWord(Bytes);
    public uint CodeLength => NscHeader.CodeLength(Bytes);
    public uint StaticsCount => NscHeader.StaticsCount(Bytes);
    public uint NativeCount => NscHeader.NativeCount(Bytes);
    public uint NameHash => NscHeader.NameHash(Bytes);
    public NscProfile? Profile => NscProfiles.Match(Bytes);
    public string InternalName => NscHeader.InternalName(Bytes);
    public bool TryInternalName(out string name) => NscHeader.TryInternalName(Bytes, out name);
    public string KindLabel => Kind switch
    {
        NscDecodeKind.BarePayload => "raw payload (no RSC7 envelope)",
        NscDecodeKind.Rsc7Uncompressed => "RSC7 envelope, uncompressed payload",
        NscDecodeKind.Rsc7Deflate => "RSC7 envelope, deflate payload",
        _ => "unknown",
    };
}
