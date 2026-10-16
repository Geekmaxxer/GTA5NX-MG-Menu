namespace NscTests;

/// <summary>Finds the workspace on disk so tests can use the real build artifacts when present.</summary>
internal static class WorkspaceLocator
{
    public static string? ToolsRoot { get; } = FindToolsRoot();

    public static string? SdkRoot => ToolsRoot == null ? null : Path.GetDirectoryName(ToolsRoot);

    /// <summary>
    /// The workspace root that contains both the SDK and the stock extractions.
    /// The stock .nsc folders live beside the SDK, not inside it.
    /// </summary>
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

    /// <summary>Resolves a path relative to the SDK root, or null when the SDK is not on disk.</summary>
    public static string? SdkPath(params string[] parts) => Resolve(SdkRoot, parts);

    /// <summary>Resolves a path relative to the workspace root, or null when it is not on disk.</summary>
    public static string? WorkspacePath(params string[] parts) => Resolve(WorkspaceRoot, parts);

    private static string? Resolve(string? root, string[] parts)
    {
        if (root == null) return null;
        string combined = root;
        foreach (string part in parts) combined = Path.Combine(combined, part);
        return File.Exists(combined) || Directory.Exists(combined) ? combined : null;
    }
}
