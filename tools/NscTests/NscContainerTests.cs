using NscCore;
using Xunit;
namespace NscTests;
public class NscContainerTests
{
    [Fact]
    public void Bare_payload_is_returned_unchanged()
    {
        byte[] payload = SyntheticNsc.Payload("ragemenu");
        Assert.False(NscContainer.HasRsc7Envelope(payload));
        NscPayload decoded = NscContainer.Read(payload, "bare");
        Assert.Equal(NscDecodeKind.BarePayload, decoded.Kind);
        Assert.Equal(payload, decoded.Bytes);
        Assert.False(decoded.HadRsc7Envelope);
    }
    [Fact]
    public void Compressed_container_is_inflated()
    {
        byte[] payload = SyntheticNsc.Payload("achievement_controller");
        byte[] file = SyntheticNsc.CompressedContainer(payload);
        NscPayload decoded = NscContainer.Read(file, "compressed");
        Assert.Equal(NscDecodeKind.Rsc7Deflate, decoded.Kind);
        Assert.Equal(payload, decoded.Bytes);
        Assert.True(decoded.HadRsc7Envelope);
    }
    [Fact]
    public void Uncompressed_container_is_not_inflated()
    {
        byte[] payload = SyntheticNsc.Payload("ragemenu", SyntheticNsc.CandidatePageBase, SyntheticNsc.CandidateBuildWord);
        byte[] file = SyntheticNsc.UncompressedContainer(payload);
        NscPayload decoded = NscContainer.Read(file, "uncompressed");
        Assert.Equal(NscDecodeKind.Rsc7Uncompressed, decoded.Kind);
        Assert.Equal(payload, decoded.Bytes);
    }
    [Fact]
    public void Envelope_flag_byte_does_not_decide_compression()
    {
        byte[] payload = SyntheticNsc.Payload("ragemenu");
        const uint flag = 0x80;
        NscPayload compressed = NscContainer.Read(SyntheticNsc.CompressedContainer(payload, flag), "flag-raw");
        NscPayload uncompressed = NscContainer.Read(SyntheticNsc.UncompressedContainer(payload, flag), "flag-deflate");
        Assert.Equal(NscDecodeKind.Rsc7Deflate, compressed.Kind);
        Assert.Equal(NscDecodeKind.Rsc7Uncompressed, uncompressed.Kind);
        Assert.Equal(payload, compressed.Bytes);
        Assert.Equal(payload, uncompressed.Bytes);
    }
    [Fact]
    public void Payload_below_minimum_size_is_rejected()
    {
        var tiny = new byte[0x40];
        NscHeader.WriteU64(tiny, NscHeader.PageBaseOffset, SyntheticNsc.StockPageBase);
        NscFormatException ex = Assert.Throws<NscFormatException>(() => NscContainer.Read(tiny, "tiny"));
        Assert.Contains("not a Switch script payload", ex.Message);
        Assert.Equal(NscExitCodes.InvalidCandidate, ex.ExitCode);
    }
    [Fact]
    public void Garbage_without_envelope_is_rejected_with_a_readable_reason()
    {
        var garbage = new byte[0x100];
        for (int i = 0; i < garbage.Length; i++) garbage[i] = 0xAB;
        NscFormatException ex = Assert.Throws<NscFormatException>(() => NscContainer.Read(garbage, "garbage"));
        Assert.Contains("no RSC7 envelope to unwrap", ex.Message);
        Assert.Contains("garbage", ex.Message);
    }
    [Fact]
    public void Truncated_envelope_reports_rather_than_throws_when_probing()
    {
        byte[] truncated = SyntheticNsc.Envelope(0x80, new byte[] { 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08 });
        bool ok = NscContainer.TryRead(truncated, "truncated", out _, out _, out string problem);
        Assert.False(ok);
        Assert.Contains("truncated", problem);
        Assert.NotNull(problem);
    }
    [Fact]
    public void Container_wrapped_in_a_container_is_not_mistaken_for_a_payload()
    {
        byte[] inner = SyntheticNsc.Payload("ragemenu");
        byte[] outer = SyntheticNsc.UncompressedContainer(SyntheticNsc.UncompressedContainer(inner));
        NscFormatException ex = Assert.Throws<NscFormatException>(() => NscContainer.Read(outer, "wrapped"));
        Assert.Contains("has an RSC7 envelope", ex.Message);
    }
    [Fact]
    public void Missing_file_reports_InvalidCandidate_exit_code()
    {
        NscFormatException ex = Assert.Throws<NscFormatException>(
            () => NscContainer.ReadFile(Path.Combine(Path.GetTempPath(), "does-not-exist-" + Guid.NewGuid().ToString("N") + ".nsc")));
        Assert.Equal(NscExitCodes.InvalidCandidate, ex.ExitCode);
    }
    [Fact]
    public void Envelope_inflating_to_a_tiny_body_reports_rather_than_crashes()
    {
        byte[] file = SyntheticNsc.Envelope(0x80, SyntheticNsc.Deflate(new byte[] { 0x01, 0x02, 0x03 }));
        bool ok = NscContainer.TryRead(file, "tiny-inflate", out _, out _, out string problem);
        Assert.False(ok);
        Assert.Contains("inflates to 3 bytes", problem);
    }
    [Fact]
    public void Envelope_inflating_to_a_tiny_body_throws_a_format_error_not_an_index_error()
    {
        byte[] file = SyntheticNsc.Envelope(0x80, SyntheticNsc.Deflate(new byte[] { 0x01, 0x02, 0x03 }));
        Assert.Throws<NscFormatException>(() => NscContainer.Read(file, "tiny-inflate"));
    }
    [Fact]
    public void Envelope_with_an_empty_body_reports_rather_than_crashes()
    {
        byte[] file = SyntheticNsc.Envelope(0x80, Array.Empty<byte>());
        bool ok = NscContainer.TryRead(file, "empty-body", out _, out _, out string problem);
        Assert.False(ok);
        Assert.Contains("empty-body", problem);
    }
    [Fact]
    public void Envelope_magic_read_as_page_base_is_detected()
    {
        const ulong rsc7MagicAsBase = 0x0000000C37435352UL;
        Assert.True(NscProfiles.IsEnvelopeMagicReadAsPageBase(rsc7MagicAsBase));
        Assert.False(NscProfiles.IsEnvelopeMagicReadAsPageBase(SyntheticNsc.StockPageBase));
    }
    [Fact]
    public void Stock_profile_is_recognised_and_unknown_profiles_are_not()
    {
        byte[] stock = SyntheticNsc.Payload("ragemenu", SyntheticNsc.StockPageBase, SyntheticNsc.StockBuildWord);
        byte[] unknown = SyntheticNsc.Payload("ragemenu", SyntheticNsc.CandidatePageBase, SyntheticNsc.CandidateBuildWord);
        Assert.NotNull(NscProfiles.Match(stock));
        Assert.Equal(NscProfiles.Stock.Name, NscProfiles.Match(stock)!.Name);
        Assert.Null(NscProfiles.Match(unknown));
    }
    [Fact]
    public void Name_pointer_and_hash_round_trip()
    {
        byte[] payload = SyntheticNsc.Payload("achievement_controller");
        Assert.True(NscHeader.TryInternalName(payload, out string name));
        Assert.Equal("achievement_controller", name);
        Assert.Equal(NscHeader.Joaat("achievement_controller"), NscHeader.NameHash(payload));
        Assert.True(NscContainer.IsSelfConsistent(payload));
    }
}
