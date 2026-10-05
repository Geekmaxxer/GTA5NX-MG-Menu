using NscCore;
using Xunit;
namespace NscTests;
public class NscAdaptTests
{
    [Fact]
    public void Adapt_changes_only_the_adaptable_bytes_and_only_where_they_differ()
    {
        byte[] referenceBytes = SyntheticNsc.Payload("achievement_controller");
        byte[] candidateBytes = SyntheticNsc.Payload("ragemenu", SyntheticNsc.CandidatePageBase, SyntheticNsc.CandidateBuildWord);
        NscPayload reference = NscContainer.Read(referenceBytes, "reference");
        NscPayload candidate = NscContainer.Read(candidateBytes, "candidate");
        NscAdaptResult result = NscAdapt.Adapt(reference, candidate, null, dryRun: true);
        Assert.Equal(new[] { 0x02, 0x03, 0x18, 0x19, 0x1A, 0x1B }, result.ChangedOffsets.ToArray());
        Assert.False(result.AlreadyMatched);
        Assert.Equal(candidateBytes.Length, result.Payload.Length);
        Assert.Equal(SyntheticNsc.StockPageBase, NscHeader.PageBase(result.Payload));
        Assert.Equal(SyntheticNsc.StockBuildWord, NscHeader.BuildWord(result.Payload));
        Assert.Equal(SyntheticNsc.CandidatePageBase, result.CandidatePageBase);
        Assert.Equal(SyntheticNsc.CandidateBuildWord, result.CandidateBuildWord);
    }
    [Fact]
    public void Adapt_leaves_code_native_table_and_internal_name_untouched()
    {
        byte[] referenceBytes = SyntheticNsc.Payload("achievement_controller");
        byte[] candidateBytes = SyntheticNsc.Payload(
            "ragemenu", SyntheticNsc.CandidatePageBase, SyntheticNsc.CandidateBuildWord, codeLength: 0x1234, nativeCount: 377);
        NscPayload reference = NscContainer.Read(referenceBytes, "reference");
        NscPayload candidate = NscContainer.Read(candidateBytes, "candidate");
        NscAdaptResult result = NscAdapt.Adapt(reference, candidate, null, dryRun: true);
        for (int i = 0; i < candidateBytes.Length; i++)
        {
            if (result.ChangedOffsets.Contains(i)) continue;
            Assert.Equal(candidateBytes[i], result.Payload[i]);
        }
        for (int i = SyntheticNsc.CodeMarkerStart; i <= SyntheticNsc.CodeMarkerEnd; i++)
        {
            Assert.Equal(candidateBytes[i], result.Payload[i]);
        }
        Assert.Equal(0x1234u, NscHeader.CodeLength(result.Payload));
        Assert.Equal(377u, NscHeader.NativeCount(result.Payload));
        Assert.Equal("ragemenu", NscHeader.InternalName(result.Payload));
        Assert.Equal(NscHeader.Joaat("ragemenu"), NscHeader.NameHash(result.Payload));
    }
    [Fact]
    public void Adapt_is_idempotent_when_the_candidate_already_matches_the_reference()
    {
        byte[] payload = SyntheticNsc.Payload("ragemenu", SyntheticNsc.StockPageBase, SyntheticNsc.StockBuildWord);
        NscPayload reference = NscContainer.Read(payload, "reference");
        NscPayload candidate = NscContainer.Read(payload, "candidate");
        NscAdaptResult result = NscAdapt.Adapt(reference, candidate, null, dryRun: true);
        Assert.True(result.AlreadyMatched);
        Assert.Empty(result.ChangedOffsets);
        Assert.Equal(payload, result.Payload);
    }
    [Fact]
    public void Describe_offsets_renders_ranges_and_singles()
    {
        Assert.Equal("none", NscAdaptResult.DescribeOffsets(Array.Empty<int>()));
        Assert.Equal("0x02-0x03,0x18-0x1B", NscAdaptResult.DescribeOffsets(new[] { 0x02, 0x03, 0x18, 0x19, 0x1A, 0x1B }));
        Assert.Equal("0x05", NscAdaptResult.DescribeOffsets(new[] { 0x05 }));
        Assert.Equal("0x00-0x07", NscAdaptResult.DescribeOffsets(new[] { 0, 1, 2, 3, 4, 5, 6, 7 }));
    }
}
