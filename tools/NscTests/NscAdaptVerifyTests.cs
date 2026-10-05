using NscCore;
using Xunit;
namespace NscTests;
public class NscAdaptVerifyTests
{
    private static byte[] Adapted()
    {
        byte[] payload = SyntheticNsc.Payload("ragemenu", SyntheticNsc.CandidatePageBase, SyntheticNsc.CandidateBuildWord);
        NscHeader.WriteU64(payload, NscHeader.PageBaseOffset, SyntheticNsc.StockPageBase);
        NscHeader.WriteU32(payload, NscHeader.BuildWordOffset, SyntheticNsc.StockBuildWord);
        return payload;
    }
    [Fact]
    public void Verify_accepts_a_clean_adaptation_and_reports_the_changed_offsets()
    {
        byte[] original = SyntheticNsc.Payload("ragemenu", SyntheticNsc.CandidatePageBase, SyntheticNsc.CandidateBuildWord);
        byte[] reference = SyntheticNsc.Payload("achievement_controller");
        IReadOnlyList<int> changed = NscAdapt.Verify(original, Adapted(), reference, SyntheticNsc.StockPageBase, SyntheticNsc.StockBuildWord);
        Assert.Equal(new[] { 0x02, 0x03, 0x18, 0x19, 0x1A, 0x1B }, changed.ToArray());
    }
    [Fact]
    public void Verify_rejects_a_change_outside_the_adaptable_regions()
    {
        byte[] original = SyntheticNsc.Payload("ragemenu", SyntheticNsc.CandidatePageBase, SyntheticNsc.CandidateBuildWord);
        byte[] reference = SyntheticNsc.Payload("achievement_controller");
        byte[] adapted = Adapted();
        adapted[0x30] ^= 0xFF;
        NscFormatException ex = Assert.Throws<NscFormatException>(
            () => NscAdapt.Verify(original, adapted, reference, SyntheticNsc.StockPageBase, SyntheticNsc.StockBuildWord));
        Assert.Equal(NscExitCodes.VerifyFailed, ex.ExitCode);
        Assert.Contains("0x30", ex.Message);
    }
    [Fact]
    public void Verify_rejects_a_code_byte_smuggled_just_after_the_build_word()
    {
        byte[] original = SyntheticNsc.Payload("ragemenu", SyntheticNsc.CandidatePageBase, SyntheticNsc.CandidateBuildWord);
        byte[] reference = SyntheticNsc.Payload("achievement_controller");
        byte[] adapted = Adapted();
        adapted[NscHeader.CodeLengthOffset] ^= 0x01;
        NscFormatException ex = Assert.Throws<NscFormatException>(
            () => NscAdapt.Verify(original, adapted, reference, SyntheticNsc.StockPageBase, SyntheticNsc.StockBuildWord));
        Assert.Equal(NscExitCodes.VerifyFailed, ex.ExitCode);
        Assert.Contains("0x1C", ex.Message);
    }
    [Fact]
    public void Verify_rejects_a_page_base_that_does_not_match_the_reference()
    {
        byte[] original = SyntheticNsc.Payload("ragemenu", SyntheticNsc.CandidatePageBase, SyntheticNsc.CandidateBuildWord);
        byte[] reference = SyntheticNsc.Payload("achievement_controller");
        byte[] adapted = Adapted();
        NscHeader.WriteU64(adapted, NscHeader.PageBaseOffset, 0x00007FF7DEADBEEFUL);
        NscFormatException ex = Assert.Throws<NscFormatException>(
            () => NscAdapt.Verify(original, adapted, reference, 0x00007FF7DEADBEEFUL, SyntheticNsc.StockBuildWord));
        Assert.Equal(NscExitCodes.VerifyFailed, ex.ExitCode);
        Assert.Contains("does not match the reference", ex.Message);
    }
    [Fact]
    public void Verify_rejects_a_length_change()
    {
        byte[] original = SyntheticNsc.Payload("ragemenu", SyntheticNsc.CandidatePageBase, SyntheticNsc.CandidateBuildWord);
        byte[] reference = SyntheticNsc.Payload("achievement_controller");
        var adapted = new byte[original.Length + 16];
        Buffer.BlockCopy(original, 0, adapted, 0, original.Length);
        NscFormatException ex = Assert.Throws<NscFormatException>(
            () => NscAdapt.Verify(original, adapted, reference, SyntheticNsc.StockPageBase, SyntheticNsc.StockBuildWord));
        Assert.Equal(NscExitCodes.VerifyFailed, ex.ExitCode);
        Assert.Contains("length changed", ex.Message);
    }
    [Fact]
    public void Verify_rejects_a_reference_too_small_to_hold_a_header()
    {
        byte[] original = SyntheticNsc.Payload("ragemenu", SyntheticNsc.CandidatePageBase, SyntheticNsc.CandidateBuildWord);
        var tinyReference = new byte[0x20];
        NscFormatException ex = Assert.Throws<NscFormatException>(
            () => NscAdapt.Verify(original, Adapted(), tinyReference, SyntheticNsc.StockPageBase, SyntheticNsc.StockBuildWord));
        Assert.Equal(NscExitCodes.VerifyFailed, ex.ExitCode);
        Assert.Contains("too small to hold a header", ex.Message);
    }
    [Fact]
    public void Adaptable_offset_set_is_exactly_the_twelve_documented_bytes()
    {
        for (int offset = 0; offset < 0x20; offset++)
        {
            bool expected = offset <= 7 || (offset >= 0x18 && offset <= 0x1B);
            Assert.Equal(expected, NscAdapt.IsAdaptableOffset(offset));
        }
        Assert.False(NscAdapt.IsAdaptableOffset(0x1C));
        Assert.False(NscAdapt.IsAdaptableOffset(0x08));
    }
}
