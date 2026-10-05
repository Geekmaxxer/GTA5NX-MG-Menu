namespace NscCore;
public enum NscReferenceMatchKind
{
    ExplicitFile,
    NamedScript,
    PreferredFallback,
    FirstInFolder,
}

public sealed record NscReferenceResolution(string Path, NscReferenceMatchKind Kind, string? RequestedName)
{
    public string Describe() => Kind switch
    {
        NscReferenceMatchKind.ExplicitFile => $"explicit file: {Path}",
        NscReferenceMatchKind.NamedScript => $"folder match: {Path}",
        NscReferenceMatchKind.PreferredFallback => $"folder fallback (no {RequestedName}.nsc in folder): {Path}",
        NscReferenceMatchKind.FirstInFolder => $"folder fallback (no {RequestedName}.nsc and no {NscReferenceResolver.PreferredFallbackName}): {Path}",
        _ => $"{Path}",
    };
}

public static class NscReferenceResolver
{
    public const string PreferredFallbackName = "achievement_controller";
    public static NscReferenceResolution Resolve(string input, string? preferredName)
    {
        if (string.IsNullOrWhiteSpace(input))
            throw new NscFormatException("no header reference was supplied", NscExitCodes.InvalidReference);
        if (File.Exists(input))
        {
            if (Directory.Exists(input))
                throw new NscFormatException($"header reference '{input}' is both a file and a directory name; pass the full path to the .nsc file", NscExitCodes.InvalidReference);
            return new NscReferenceResolution(Path.GetFullPath(input), NscReferenceMatchKind.ExplicitFile, preferredName);
        }
        if (!Directory.Exists(input))
            throw new NscFormatException($"header reference not found: {input}", NscExitCodes.InvalidReference);
        string directory = Path.GetFullPath(input);
        if (!string.IsNullOrWhiteSpace(preferredName))
        {
            string named = Path.Combine(directory, preferredName + ".nsc");
            if (File.Exists(named))
                return new NscReferenceResolution(named, NscReferenceMatchKind.NamedScript, preferredName);
        }
        string preferred = Path.Combine(directory, PreferredFallbackName + ".nsc");
        if (File.Exists(preferred))
            return new NscReferenceResolution(preferred, NscReferenceMatchKind.PreferredFallback, preferredName);
        string? first = Directory.EnumerateFiles(directory, "*.nsc", SearchOption.TopDirectoryOnly)
                                 .OrderBy(p => p, StringComparer.OrdinalIgnoreCase)
                                 .FirstOrDefault();
        if (first != null)
            return new NscReferenceResolution(first, NscReferenceMatchKind.FirstInFolder, preferredName);
        throw new NscFormatException($"no .nsc reference found in folder {directory}", NscExitCodes.InvalidReference);
    }
}
