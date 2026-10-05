namespace NscCore;
public sealed record NscProfile(string Name, ulong PageBase, uint BuildWord, string Note);
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
    public static bool IsEnvelopeMagicReadAsPageBase(ulong pageBase) => (uint)pageBase == NscContainer.Rsc7Magic;
}
