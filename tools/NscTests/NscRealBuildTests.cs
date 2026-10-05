using System.Security.Cryptography;
using NscCore;
using Xunit;
namespace NscTests;
public class NscRealBuildTests
{
    private const string BuildDir = "out-lscc-v099e-20260928";
    private const string PayloadSha256 = "1E00104C50D2867878B5394DD50A44CD3E4B9A6B8E33BB68610C388A7C78178F";
    private const string IntermediateSha256 = "5B9E1F6B3C0857086898E0193B34984399D3E7EF6FD17CA9E0E22E09634D354C";
    private const int PayloadLength = 245760;
    private const int IntermediateLength = 245776;
    private static string Sha256Hex(byte[] bytes) => Convert.ToHexString(SHA256.HashData(bytes));
    [Fact]
    public void Shipped_nsc_is_a_bare_payload_matching_the_published_hash()
    {
        string? path = WorkspaceLocator.SdkPath(BuildDir, "ragemenu.nsc");
        if (path == null) return;
        NscPayload payload = NscContainer.ReadFile(path);
        Assert.False(payload.HadRsc7Envelope);
        Assert.Equal(NscDecodeKind.BarePayload, payload.Kind);
        Assert.Equal(PayloadLength, payload.Bytes.Length);
        Assert.Equal(PayloadSha256, Sha256Hex(payload.Bytes));
        Assert.Equal(NscProfiles.Stock.PageBase, payload.PageBase);
        Assert.Equal(NscProfiles.Stock.BuildWord, payload.BuildWord);
        Assert.Equal(NscProfiles.Stock.Name, payload.Profile?.Name);
    }
    [Fact]
    public void Win64_intermediate_is_enveloped_and_decodes_to_the_candidate_payload()
    {
        string? path = WorkspaceLocator.SdkPath(BuildDir, "ragemenu.pc.nsc");
        if (path == null) return;
        NscPayload payload = NscContainer.ReadFile(path);
        Assert.True(payload.HadRsc7Envelope);
        Assert.Equal(IntermediateLength, payload.FileBytes.Length);
        Assert.Equal(PayloadLength, payload.Bytes.Length);
        Assert.Equal(NscDecodeKind.Rsc7Uncompressed, payload.Kind);
        Assert.Equal(IntermediateSha256, Sha256Hex(payload.FileBytes));
        Assert.NotEqual(NscProfiles.Stock.PageBase, payload.PageBase);
        Assert.Null(payload.Profile);
        Assert.Equal("ragemenu", NscHeader.InternalName(payload.Bytes));
    }
    [Fact]
    public void Intermediate_adapts_back_to_the_shipped_payload_byte_for_byte()
    {
        string? intermediatePath = WorkspaceLocator.SdkPath(BuildDir, "ragemenu.pc.nsc");
        string? referencePath = WorkspaceLocator.WorkspacePath(
            "stock nsc's for cross-reference", "script_rel.rpf", "achievement_controller.nsc");
        if (intermediatePath == null || referencePath == null) return;
        NscPayload reference = NscContainer.ReadFile(referencePath);
        NscPayload candidate = NscContainer.ReadFile(intermediatePath);
        NscAdaptResult result = NscAdapt.Adapt(reference, candidate, null, dryRun: true);
        Assert.Equal(PayloadSha256, Sha256Hex(result.Payload));
        Assert.Equal(PayloadLength, result.Payload.Length);
        Assert.Equal(SyntheticNsc.StockPageBase, NscHeader.PageBase(result.Payload));
        Assert.Equal(SyntheticNsc.StockBuildWord, NscHeader.BuildWord(result.Payload));
        Assert.Equal(new[] { 0x02, 0x03, 0x18, 0x19, 0x1A, 0x1B }, result.ChangedOffsets.ToArray());
        Assert.Equal("0x02-0x03,0x18-0x1B", NscAdaptResult.DescribeOffsets(result.ChangedOffsets));
    }
    [Fact]
    public void Adapting_an_already_adapted_build_changes_nothing()
    {
        string? path = WorkspaceLocator.SdkPath(BuildDir, "ragemenu.nsc");
        if (path == null) return;
        NscPayload payload = NscContainer.ReadFile(path);
        NscAdaptResult result = NscAdapt.Adapt(payload, payload, null, dryRun: true);
        Assert.True(result.AlreadyMatched);
        Assert.Empty(result.ChangedOffsets);
        Assert.Equal(PayloadSha256, Sha256Hex(result.Payload));
    }
}
