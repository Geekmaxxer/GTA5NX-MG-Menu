namespace NscCore;

/// <summary>How a reference path was chosen.</summary>
public enum NscReferenceMatchKind
{
    /// <summary>The caller named a file directly.</summary>
    ExplicitFile,
    /// <summary>Folder contained a script with the requested name.</summary>
    NamedScript,
    /// <summary>Folder had no script with the requested name; achievement_controller.nsc used.</summary>
    PreferredFallback,
    /// <summary>Folder had neither; the ordinal-first .nsc was used.</summary>
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

/// <summary>
/// The single reference-resolution rule, shared by NscAdapter and the build
/// scripts so they can never disagree about which stock script supplied the
/// header bytes.
///
/// Order inside a folder:
///   1. &lt;folder&gt;\&lt;preferredName&gt;.nsc   (only when a name is supplied)
///   2. &lt;folder&gt;\achievement_controller.nsc
///   3. ordinal-first *.nsc in the folder
/// The stock extractions have no ragemenu.nsc, so step 1 misses and step 2 is
/// the one that fires; that is safe because every verified stock
/// script_rel.rpf script shares the same page-base / build-word profile.
/// </summary>
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
