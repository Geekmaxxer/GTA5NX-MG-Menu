using System.Security.Cryptography;
using NscCore;
using Xunit;

namespace NscTests;

/// <summary>
/// End-to-end tests against the real shipped build.
///
/// These are the strongest gate in the suite: they prove the new shared decoder
/// reproduces the published bytes of a build that already runs on hardware. They
/// return early (passing) when the artifacts are absent, so the suite still runs
/// on a machine without the workspace.
/// </summary>
public class NscRealBuildTests
{
    private const string BuildDir = "out-lscc-v099e-20260928";

    /// <summary>SHA256 of the shipped payload, measured 2026-10-04.</summary>
    private const string PayloadSha256 = "1E00104C50D2867878B5394DD50A44CD3E4B9A6B8E33BB68610C388A7C78178F";

    /// <summary>SHA256 of the Win64 intermediate, measured 2026-10-04.</summary>
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
        // scriptrc_x64.exe -uncompressedresources leaves the region raw, so the
        // decoder must recognise it without attempting (or trusting) an inflate.
        Assert.Equal(NscDecodeKind.Rsc7Uncompressed, payload.Kind);
        // IntermediateSha256 is the hash of the whole 245776-byte file, envelope
        // included; the payload inside it hashes differently.
        Assert.Equal(IntermediateSha256, Sha256Hex(payload.FileBytes));
        // The intermediate still carries the Win64 page base, not the stock one.
        Assert.NotEqual(NscProfiles.Stock.PageBase, payload.PageBase);
        Assert.Null(payload.Profile);
        Assert.Equal("ragemenu", NscHeader.InternalName(payload.Bytes));
    }

    /// <summary>
    /// The whole point of the adapter: take the Win64 intermediate plus a stock
    /// reference and reproduce the shipped payload byte for byte. This can only
    /// pass if no code, native table or name bytes are touched.
    /// </summary>
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
        // The real diff set: only 6 byte values change, because 6 of the 12
        // copied header bytes were already equal.
        Assert.Equal(new[] { 0x02, 0x03, 0x18, 0x19, 0x1A, 0x1B }, result.ChangedOffsets.ToArray());
        Assert.Equal("0x02-0x03,0x18-0x1B", NscAdaptResult.DescribeOffsets(result.ChangedOffsets));
    }

    /// <summary>
    /// Adapting the shipped payload onto its own profile must be a no-op, which
    /// proves the adapter is safe to re-run and will not slowly corrupt a build.
    /// </summary>
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
