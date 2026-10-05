using NscCore;
using Xunit;
namespace NscTests;
public class NscNameValidationTests
{
    private static string NewTempDir()
    {
        string dir = Path.Combine(Path.GetTempPath(), "nsctests-" + Guid.NewGuid().ToString("N"));
        Directory.CreateDirectory(dir);
        return dir;
    }
    [Fact]
    public void Matching_file_name_and_hash_pass()
    {
        string dir = NewTempDir();
        try
        {
            SyntheticNsc.WriteTempFile(dir, "ragemenu.nsc", SyntheticNsc.Payload("ragemenu"));
            NscNameValidationResult result = NscNameValidation.ValidateDirectory(dir);
            Assert.True(result.Ok);
            Assert.Equal(1, result.FilesChecked);
            Assert.Equal(0, result.Skipped);
            Assert.Empty(result.Problems);
        }
        finally
        {
            Directory.Delete(dir, true);
        }
    }
    [Fact]
    public void Pc_suffix_is_flagged_because_the_entry_name_must_be_ragemenu_nsc()
    {
        string dir = NewTempDir();
        try
        {
            SyntheticNsc.WriteTempFile(dir, "ragemenu.pc.nsc", SyntheticNsc.Payload("ragemenu"));
            NscNameValidationResult result = NscNameValidation.ValidateDirectory(dir);
            Assert.False(result.Ok);
            NscNameProblem problem = Assert.Single(result.Problems);
            Assert.Equal("ragemenu.pc", problem.FileName);
            Assert.Equal("ragemenu", problem.InternalName);
            Assert.Contains("file name does not match the internal name", problem.Reason);
        }
        finally
        {
            Directory.Delete(dir, true);
        }
    }
    [Fact]
    public void Wrong_stored_name_hash_is_flagged_even_when_the_file_name_matches()
    {
        string dir = NewTempDir();
        try
        {
            byte[] payload = SyntheticNsc.Payload("ragemenu");
            NscHeader.WriteU32(payload, NscHeader.NameHashOffset, 0);
            SyntheticNsc.WriteTempFile(dir, "ragemenu.nsc", payload);
            NscNameValidationResult result = NscNameValidation.ValidateDirectory(dir);
            NscNameProblem problem = Assert.Single(result.Problems);
            Assert.Contains("header name hash does not match", problem.Reason);
            Assert.Equal(0u, problem.HeaderHash);
            Assert.Equal(NscHeader.Joaat("ragemenu"), problem.ExpectedHash);
        }
        finally
        {
            Directory.Delete(dir, true);
        }
    }
    [Fact]
    public void Validate_single_file_is_supported()
    {
        string dir = NewTempDir();
        try
        {
            string path = SyntheticNsc.WriteTempFile(dir, "ragemenu.nsc", SyntheticNsc.Payload("ragemenu"));
            NscNameValidationResult result = NscNameValidation.ValidateFile(path);
            Assert.True(result.Ok);
            Assert.Equal(1, result.FilesChecked);
        }
        finally
        {
            Directory.Delete(dir, true);
        }
    }
    [Fact]
    public void Undecodable_file_is_reported_rather_than_thrown()
    {
        string dir = NewTempDir();
        try
        {
            var garbage = new byte[0x100];
            for (int i = 0; i < garbage.Length; i++) garbage[i] = 0xAB;
            SyntheticNsc.WriteTempFile(dir, "broken.nsc", garbage);
            NscNameValidationResult result = NscNameValidation.ValidateDirectory(dir);
            Assert.Equal(0, result.FilesChecked);
            Assert.Equal(1, result.Skipped);
            NscNameProblem problem = Assert.Single(result.Problems);
            Assert.Contains("broken.nsc", problem.File);
        }
        finally
        {
            Directory.Delete(dir, true);
        }
    }
    [Fact]
    public void Directory_validation_counts_each_file_and_flags_only_the_bad_one()
    {
        string dir = NewTempDir();
        try
        {
            SyntheticNsc.WriteTempFile(dir, "ragemenu.nsc", SyntheticNsc.Payload("ragemenu"));
            SyntheticNsc.WriteTempFile(dir, "achievement_controller.nsc", SyntheticNsc.Payload("achievement_controller"));
            SyntheticNsc.WriteTempFile(dir, "wrongname.nsc", SyntheticNsc.Payload("shop_controller"));
            NscNameValidationResult result = NscNameValidation.ValidateDirectory(dir);
            Assert.Equal(3, result.FilesChecked);
            Assert.Single(result.Problems);
            Assert.Equal("wrongname", result.Problems[0].FileName);
            Assert.Equal("shop_controller", result.Problems[0].InternalName);
        }
        finally
        {
            Directory.Delete(dir, true);
        }
    }
    [Fact]
    public void Envelope_wrapped_payload_still_validates()
    {
        string dir = NewTempDir();
        try
        {
            byte[] payload = SyntheticNsc.Payload("ragemenu");
            SyntheticNsc.WriteTempFile(dir, "ragemenu.nsc", SyntheticNsc.CompressedContainer(payload));
            NscNameValidationResult result = NscNameValidation.ValidateDirectory(dir);
            Assert.True(result.Ok);
        }
        finally
        {
            Directory.Delete(dir, true);
        }
    }
}
