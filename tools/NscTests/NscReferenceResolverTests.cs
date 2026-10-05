using NscCore;
using Xunit;
namespace NscTests;
public class NscReferenceResolverTests
{
    private static string NewTempDir()
    {
        string dir = Path.Combine(Path.GetTempPath(), "nsctests-" + Guid.NewGuid().ToString("N"));
        Directory.CreateDirectory(dir);
        return dir;
    }
    [Fact]
    public void Explicit_file_is_used_as_given()
    {
        string dir = NewTempDir();
        try
        {
            string path = SyntheticNsc.WriteTempFile(dir, "some.nsc", SyntheticNsc.Payload("ragemenu"));
            NscReferenceResolution resolution = NscReferenceResolver.Resolve(path, "ragemenu");
            Assert.Equal(NscReferenceMatchKind.ExplicitFile, resolution.Kind);
            Assert.Equal(Path.GetFullPath(path), resolution.Path);
        }
        finally
        {
            Directory.Delete(dir, true);
        }
    }
    [Fact]
    public void Folder_prefers_the_requested_script_name_over_the_generic_fallback()
    {
        string dir = NewTempDir();
        try
        {
            SyntheticNsc.WriteTempFile(dir, "ragemenu.nsc", SyntheticNsc.Payload("ragemenu"));
            SyntheticNsc.WriteTempFile(dir, "achievement_controller.nsc", SyntheticNsc.Payload("achievement_controller"));
            NscReferenceResolution resolution = NscReferenceResolver.Resolve(dir, "ragemenu");
            Assert.Equal(NscReferenceMatchKind.NamedScript, resolution.Kind);
            Assert.Equal("ragemenu.nsc", Path.GetFileName(resolution.Path));
        }
        finally
        {
            Directory.Delete(dir, true);
        }
    }
    [Fact]
    public void Without_a_name_the_generic_fallback_is_used()
    {
        string dir = NewTempDir();
        try
        {
            SyntheticNsc.WriteTempFile(dir, "ragemenu.nsc", SyntheticNsc.Payload("ragemenu"));
            SyntheticNsc.WriteTempFile(dir, "achievement_controller.nsc", SyntheticNsc.Payload("achievement_controller"));
            NscReferenceResolution resolution = NscReferenceResolver.Resolve(dir, null);
            Assert.Equal(NscReferenceMatchKind.PreferredFallback, resolution.Kind);
            Assert.Equal("achievement_controller.nsc", Path.GetFileName(resolution.Path));
        }
        finally
        {
            Directory.Delete(dir, true);
        }
    }
    [Fact]
    public void Folder_falls_back_to_achievement_controller_for_an_unrelated_script()
    {
        string dir = NewTempDir();
        try
        {
            SyntheticNsc.WriteTempFile(dir, "achievement_controller.nsc", SyntheticNsc.Payload("achievement_controller"));
            SyntheticNsc.WriteTempFile(dir, "shop_controller.nsc", SyntheticNsc.Payload("shop_controller"));
            NscReferenceResolution resolution = NscReferenceResolver.Resolve(dir, "ragemenu");
            Assert.Equal(NscReferenceMatchKind.PreferredFallback, resolution.Kind);
            Assert.Equal("achievement_controller.nsc", Path.GetFileName(resolution.Path));
        }
        finally
        {
            Directory.Delete(dir, true);
        }
    }
    [Fact]
    public void Folder_falls_back_to_the_ordinal_first_nsc_when_nothing_else_matches()
    {
        string dir = NewTempDir();
        try
        {
            SyntheticNsc.WriteTempFile(dir, "zulu.nsc", SyntheticNsc.Payload("zulu"));
            SyntheticNsc.WriteTempFile(dir, "alpha.nsc", SyntheticNsc.Payload("alpha"));
            NscReferenceResolution resolution = NscReferenceResolver.Resolve(dir, "ragemenu");
            Assert.Equal(NscReferenceMatchKind.FirstInFolder, resolution.Kind);
            Assert.Equal("alpha.nsc", Path.GetFileName(resolution.Path));
        }
        finally
        {
            Directory.Delete(dir, true);
        }
    }
    [Fact]
    public void Empty_folder_is_an_invalid_reference()
    {
        string dir = NewTempDir();
        try
        {
            NscFormatException ex = Assert.Throws<NscFormatException>(() => NscReferenceResolver.Resolve(dir, "ragemenu"));
            Assert.Equal(NscExitCodes.InvalidReference, ex.ExitCode);
            Assert.Contains("no .nsc reference found", ex.Message);
        }
        finally
        {
            Directory.Delete(dir, true);
        }
    }
    [Fact]
    public void Missing_path_is_an_invalid_reference()
    {
        string missing = Path.Combine(Path.GetTempPath(), "nsctests-missing-" + Guid.NewGuid().ToString("N"));
        NscFormatException ex = Assert.Throws<NscFormatException>(() => NscReferenceResolver.Resolve(missing, "ragemenu"));
        Assert.Equal(NscExitCodes.InvalidReference, ex.ExitCode);
        Assert.Contains("header reference not found", ex.Message);
    }
    [Fact]
    public void Empty_input_is_an_invalid_reference()
    {
        NscFormatException ex = Assert.Throws<NscFormatException>(() => NscReferenceResolver.Resolve("   ", "ragemenu"));
        Assert.Equal(NscExitCodes.InvalidReference, ex.ExitCode);
    }
    [Fact]
    public void Describe_explains_which_rule_fired()
    {
        string dir = NewTempDir();
        try
        {
            SyntheticNsc.WriteTempFile(dir, "achievement_controller.nsc", SyntheticNsc.Payload("achievement_controller"));
            NscReferenceResolution resolution = NscReferenceResolver.Resolve(dir, "ragemenu");
            Assert.Contains("no ragemenu.nsc in folder", resolution.Describe());
        }
        finally
        {
            Directory.Delete(dir, true);
        }
    }
}
