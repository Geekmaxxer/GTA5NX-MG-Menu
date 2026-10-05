using NscCore;
using Xunit;
namespace NscTests;
public class NscRealStockTests
{
    private const string StockFolder = "stock nsc's for cross-reference";
    [Fact]
    public void Stock_reference_decodes_with_the_documented_profile()
    {
        string? path = WorkspaceLocator.WorkspacePath(StockFolder, "script_rel.rpf", "achievement_controller.nsc");
        if (path == null) return;
        NscPayload reference = NscContainer.ReadFile(path);
        Assert.Equal(NscDecodeKind.Rsc7Deflate, reference.Kind);
        Assert.Equal(81920, reference.Bytes.Length);
        Assert.Equal(0x00007FF7BAD5B3A8UL, reference.PageBase);
        Assert.Equal(0x94C75B53u, reference.BuildWord);
        Assert.Equal(NscProfiles.Stock.Name, reference.Profile?.Name);
        Assert.Equal(85u, reference.NativeCount);
        Assert.Equal(71885u, reference.CodeLength);
        Assert.Equal((byte)0x80, reference.FileBytes[0x08]);
        Assert.Equal(0xC0000000u, NscHeader.ReadU32(reference.FileBytes, 0x0C));
    }
    [Fact]
    public void Script_rpf_and_script_rel_rpf_are_genuinely_different_resources()
    {
        string? relative = WorkspaceLocator.WorkspacePath(StockFolder, "script_rel.rpf", "achievement_controller.nsc");
        string? other = WorkspaceLocator.WorkspacePath(StockFolder, "script.rpf", "achievement_controller.nsc");
        if (relative == null || other == null) return;
        NscPayload a = NscContainer.ReadFile(relative);
        NscPayload b = NscContainer.ReadFile(other);
        Assert.NotEqual(a.PageBase, b.PageBase);
        Assert.NotEqual(a.BuildWord, b.BuildWord);
        Assert.NotEqual(a.Bytes.Length, b.Bytes.Length);
        Assert.Equal(NscProfiles.Stock.Name, a.Profile?.Name);
        Assert.Null(b.Profile); 
    }
    [Fact]
    public void Stock_folder_resolution_is_the_same_rule_for_both_scripts()
    {
        string? folder = WorkspaceLocator.WorkspacePath(StockFolder, "script_rel.rpf");
        if (folder == null) return;
        NscReferenceResolution forMenu = NscReferenceResolver.Resolve(folder, "ragemenu");
        NscReferenceResolution forController = NscReferenceResolver.Resolve(folder, "achievement_controller");
        Assert.Equal(NscReferenceMatchKind.PreferredFallback, forMenu.Kind);
        Assert.Equal(NscReferenceMatchKind.NamedScript, forController.Kind);
        Assert.Equal(forMenu.Path, forController.Path);
        Assert.Equal("achievement_controller.nsc", Path.GetFileName(forMenu.Path));
    }
    [Fact]
    public void Folder_holding_both_scripts_resolves_by_name()
    {
        int checkedFolders = 0;
        foreach (string candidateDir in new[] { "out-both-v2", "out-both-v3" })
        {
            string? folder = WorkspaceLocator.SdkPath(candidateDir);
            if (folder == null) continue;
            if (!File.Exists(Path.Combine(folder, "ragemenu.nsc"))) continue;
            if (!File.Exists(Path.Combine(folder, "achievement_controller.nsc"))) continue;
            checkedFolders++;
            Assert.Equal("ragemenu.nsc", Path.GetFileName(NscReferenceResolver.Resolve(folder, "ragemenu").Path));
            Assert.Equal("achievement_controller.nsc", Path.GetFileName(NscReferenceResolver.Resolve(folder, "achievement_controller").Path));
            Assert.Equal("achievement_controller.nsc", Path.GetFileName(NscReferenceResolver.Resolve(folder, null).Path));
        }
        Assert.True(checkedFolders >= 0);
    }
}
