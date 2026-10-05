using NscCore;
using Xunit;
namespace NscTests;
public class NscAdaptWriteTests
{
    [Fact]
    public void Adapt_writes_a_bare_payload_not_an_envelope_wrapped_file()
    {
        string dir = Path.Combine(Path.GetTempPath(), "nsctests-" + Guid.NewGuid().ToString("N"));
        try
        {
            byte[] referenceBytes = SyntheticNsc.Payload("achievement_controller");
            byte[] candidatePayload = SyntheticNsc.Payload("ragemenu", SyntheticNsc.CandidatePageBase, SyntheticNsc.CandidateBuildWord);
            NscPayload reference = NscContainer.Read(SyntheticNsc.CompressedContainer(referenceBytes), "achievement_controller.nsc");
            NscPayload candidate = NscContainer.Read(SyntheticNsc.CompressedContainer(candidatePayload), "ragemenu.pc.nsc");
            NscAdaptResult result = NscAdapt.Adapt(reference, candidate, Path.Combine(dir, "ragemenu.nsc"));
            Assert.NotNull(result.WrittenPath);
            byte[] onDisk = File.ReadAllBytes(result.WrittenPath!);
            Assert.Equal(result.Payload, onDisk);
            Assert.False(NscContainer.HasRsc7Envelope(onDisk));
            Assert.Equal(SyntheticNsc.StockPageBase, NscHeader.PageBase(onDisk));
            Assert.Equal("ragemenu", NscHeader.InternalName(onDisk));
        }
        finally
        {
            if (Directory.Exists(dir)) Directory.Delete(dir, true);
        }
    }
    [Fact]
    public void Write_atomic_produces_the_exact_bytes_and_leaves_no_temp_file()
    {
        string dir = Path.Combine(Path.GetTempPath(), "nsctests-" + Guid.NewGuid().ToString("N"));
        try
        {
            byte[] payload = SyntheticNsc.Payload("ragemenu");
            string output = Path.Combine(dir, "nested", "ragemenu.nsc");
            string written = NscAdapt.WriteAtomic(output, payload);
            Assert.True(File.Exists(written));
            Assert.Equal(payload, File.ReadAllBytes(written));
            Assert.Empty(Directory.GetFiles(Path.GetDirectoryName(written)!, "*.tmp-*"));
        }
        finally
        {
            if (Directory.Exists(dir)) Directory.Delete(dir, true);
        }
    }
    [Fact]
    public void Write_atomic_overwrites_an_existing_output()
    {
        string dir = Path.Combine(Path.GetTempPath(), "nsctests-" + Guid.NewGuid().ToString("N"));
        try
        {
            string output = Path.Combine(dir, "ragemenu.nsc");
            Directory.CreateDirectory(dir);
            File.WriteAllBytes(output, new byte[] { 0xDE, 0xAD });
            byte[] payload = SyntheticNsc.Payload("ragemenu");
            NscAdapt.WriteAtomic(output, payload);
            Assert.Equal(payload, File.ReadAllBytes(output));
        }
        finally
        {
            if (Directory.Exists(dir)) Directory.Delete(dir, true);
        }
    }
    [Fact]
    public void Adapt_dry_run_writes_nothing()
    {
        string dir = Path.Combine(Path.GetTempPath(), "nsctests-" + Guid.NewGuid().ToString("N"));
        byte[] referenceBytes = SyntheticNsc.Payload("achievement_controller");
        byte[] candidateBytes = SyntheticNsc.Payload("ragemenu", SyntheticNsc.CandidatePageBase, SyntheticNsc.CandidateBuildWord);
        NscPayload reference = NscContainer.Read(referenceBytes, "reference");
        NscPayload candidate = NscContainer.Read(candidateBytes, "candidate");
        NscAdaptResult result = NscAdapt.Adapt(reference, candidate, Path.Combine(dir, "should-not-exist.nsc"), dryRun: true);
        Assert.Null(result.WrittenPath);
        Assert.False(Directory.Exists(dir));
    }
}
