namespace NscTests;
internal static class WorkspaceLocator
{
    public static string? ToolsRoot { get; } = FindToolsRoot();
    public static string? SdkRoot => ToolsRoot == null ? null : Path.GetDirectoryName(ToolsRoot);
    public static string? WorkspaceRoot => SdkRoot == null ? null : Path.GetDirectoryName(SdkRoot);
    private static string? FindToolsRoot()
    {
        var dir = new DirectoryInfo(AppContext.BaseDirectory);
        while (dir != null)
        {
            if (dir.Name.Equals("tools", StringComparison.OrdinalIgnoreCase)
                && Directory.Exists(Path.Combine(dir.FullName, "NscCore")))
            {
                return dir.FullName;
            }
            dir = dir.Parent;
        }
        return null;
    }

    public static string? SdkPath(params string[] parts) => Resolve(SdkRoot, parts);
    public static string? WorkspacePath(params string[] parts) => Resolve(WorkspaceRoot, parts);
    private static string? Resolve(string? root, string[] parts)
    {
        if (root == null) return null;
        string combined = root;
        foreach (string part in parts) combined = Path.Combine(combined, part);
        return File.Exists(combined) || Directory.Exists(combined) ? combined : null;
    }
}
