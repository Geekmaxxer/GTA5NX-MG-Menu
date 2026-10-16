namespace NscCore;

/// <summary>
/// A page-base / build-word pair known to appear in real Switch scripts.
/// </summary>
public sealed record NscProfile(string Name, ulong PageBase, uint BuildWord, string Note);

/// <summary>
/// Known Switch header profiles. The adapter warns when a reference does not
/// match one of these, because that means we are about to copy header bytes
/// from a file whose provenance is not understood.
///
/// Measured across 199 ragemenu.nsc builds in this workspace:
///   115  pageBase=0x00007FF7BAD5B3A8  word18=0x94C75B53   stock profile
///    74  pageBase=0x00007FF6619AB3A8  word18=0x00000000   legacy adapted
///    10  pageBase=0x0000000C37435352  word18=0x50003F50   RSC7 magic read as a base
/// </summary>
public static class NscProfiles
{
    public static readonly NscProfile Stock = new(
        "stock/script_rel",
        0x00007FF7BAD5B3A8UL,
        0x94C75B53u,
        "every sampled stock script_rel.rpf and script.rpf script shares this page base and build word");

    public static readonly NscProfile Legacy = new(
        "legacy-adapted",
        0x00007FF6619AB3A8UL,
        0x00000000u,
        "earlier ragemenu builds that carried an all-zero build word; loads on hardware but is not the stock profile");

    public static readonly NscProfile[] Known = { Stock, Legacy };

    public static NscProfile? Match(ulong pageBase, uint buildWord)
    {
        foreach (NscProfile profile in Known)
        {
            if (profile.PageBase == pageBase && profile.BuildWord == buildWord) return profile;
        }
        return null;
    }

    public static NscProfile? Match(byte[] payload) => Match(NscHeader.PageBase(payload), NscHeader.BuildWord(payload));

    /// <summary>
    /// True when the low 32 bits of a page base are the RSC7 magic, which is
    /// what you get if you read a .nsc container's own first 8 bytes as if they
    /// were a payload header (u64@0 of "RSC7" + version 0x0000000C).
    /// </summary>
    public static bool IsEnvelopeMagicReadAsPageBase(ulong pageBase) => (uint)pageBase == NscContainer.Rsc7Magic;
}
