using NscCore;
namespace NscAdapter;
internal static class NscAdapterReport
{
    public static List<string> CheckReference(NscPayload reference, NscPayload? candidate, TextWriter error)
    {
        var warnings = new List<string>();
        NscProfile? profile = reference.Profile;
        if (profile == null)
        {
            string known = string.Join("; ", Array.ConvertAll(NscProfiles.Known, p => $"{p.Name} = 0x{p.PageBase:X16}/0x{p.BuildWord:X8}"));
            warnings.Add($"reference profile 0x{reference.PageBase:X16}/0x{reference.BuildWord:X8} is not a known profile ({known}). "
                       + "Confirm the reference came from the same switch build as the game you will install into.");
        }
        if (reference.BuildWord == 0)
        {
            warnings.Add("reference build word is 0x00000000. That is the legacy adapted-ragemenu profile, not a stock script; "
                       + "prefer a stock reference for new builds.");
        }
        if (NscProfiles.IsEnvelopeMagicReadAsPageBase(reference.PageBase))
        {
            warnings.Add("reference page base is the RSC7 magic, which means the file was read as a payload when it is really a container. "
                       + "Do not use it as a reference.");
        }
        if (candidate != null && candidate.TryInternalName(out string candidateName)
            && reference.TryInternalName(out string referenceName)
            && string.Equals(candidateName, referenceName, StringComparison.OrdinalIgnoreCase)
            && !reference.HadRsc7Envelope)
        {
            warnings.Add($"reference internal name is '{referenceName}', the same as the candidate, and it has no RSC7 envelope. "
                       + "The reference looks like an earlier output rather than a stock script.");
        }
        foreach (string warning in warnings) error.WriteLine($"WARNING {warning}");
        return warnings;
    }

    public static void WriteTrace(TextWriter output, NscAdaptResult result, string outputPath, bool dryRun)
    {
        string prefix = dryRun ? "DRY_RUN" : "WROTE_ADAPTED_HEADER";
        output.WriteLine($"{prefix} {(dryRun ? "(not written)" : result.WrittenPath ?? outputPath)}");
        output.WriteLine($"PAGE_BASE 0x{result.CandidatePageBase:X16} -> 0x{result.ReferencePageBase:X16}");
        output.WriteLine($"BUILD_WORD 0x{result.CandidateBuildWord:X8} -> 0x{result.ReferenceBuildWord:X8}");
        output.WriteLine($"ADAPTED_BYTES changed={result.ChangedOffsets.Count} offsets={NscAdaptResult.DescribeOffsets(result.ChangedOffsets)}");
        if (result.AlreadyMatched)
        {
            output.WriteLine("NOTE the candidate already carried the reference profile, so the output is byte-identical to the input");
        }
    }

    public static void WriteReferenceLine(TextWriter output, NscReferenceResolution resolution) => output.WriteLine(
        resolution.Kind switch
        {
            NscReferenceMatchKind.NamedScript => $"HEADER_REFERENCE_FOLDER match: {resolution.Path}",
            NscReferenceMatchKind.PreferredFallback => $"HEADER_REFERENCE_FOLDER fallback: {resolution.Path}",
            NscReferenceMatchKind.FirstInFolder => $"HEADER_REFERENCE_FOLDER fallback (first .nsc in folder): {resolution.Path}",
            _ => $"HEADER_REFERENCE file: {resolution.Path}",
        });
}
