using NscCore;
namespace NscAdapter;
internal static class NscAdapterInfo
{
    public static int Info(NscAdapterOptions options, TextWriter output, TextWriter error)
    {
        if (options.Positional.Count is < 1 or > 2)
        {
            error.WriteLine("ERROR --info needs a reference, and optionally a candidate to compare against");
            NscAdapterUsage.Write(error);
            return NscExitCodes.Usage;
        }
        NscReferenceResolution resolution = NscReferenceResolver.Resolve(options.Positional[0], options.PreferredName);
        NscAdapterReport.WriteReferenceLine(output, resolution);
        NscPayload? reference = NscAdapterDescribe.Write(output, resolution.Path, "reference");
        if (options.Positional.Count == 2)
        {
            NscPayload? candidate = NscAdapterDescribe.Write(output, options.Positional[1], "candidate");
            if (reference != null && candidate != null) Compare(output, reference, candidate);
        }
        return NscExitCodes.Ok;
    }

    private static void Compare(TextWriter output, NscPayload reference, NscPayload candidate)
    {
        output.WriteLine("--- adaptation preview");
        try
        {
            NscAdaptResult result = NscAdapt.Adapt(reference, candidate, null, dryRun: true);
            output.WriteLine($"WOULD_CHANGE changed={result.ChangedOffsets.Count} offsets={NscAdaptResult.DescribeOffsets(result.ChangedOffsets)}");
            output.WriteLine($"PAGE_BASE 0x{result.CandidatePageBase:X16} -> 0x{result.ReferencePageBase:X16}");
            output.WriteLine($"BUILD_WORD 0x{result.CandidateBuildWord:X8} -> 0x{result.ReferenceBuildWord:X8}");
            if (result.AlreadyMatched) output.WriteLine("NOTE the candidate already matches the reference profile");
        }
        catch (NscFormatException ex)
        {
            output.WriteLine($"WOULD_FAIL {ex.Message}");
        }
    }

    public static int ValidateNames(NscAdapterOptions options, TextWriter output, TextWriter error)
    {
        if (options.Positional.Count != 1)
        {
            error.WriteLine("ERROR --validate-names needs a single file or directory");
            NscAdapterUsage.Write(error);
            return NscExitCodes.Usage;
        }
        string target = options.Positional[0];
        bool isDirectory = Directory.Exists(target);
        if (!isDirectory && !File.Exists(target))
        {
            error.WriteLine($"ERROR not found: {target}");
            return NscExitCodes.InvalidReference;
        }
        NscNameValidationResult result = isDirectory
            ? NscNameValidation.ValidateDirectory(target)
            : NscNameValidation.ValidateFile(target);
        foreach (NscNameProblem problem in result.Problems)
        {
            string label = isDirectory ? Path.GetRelativePath(target, problem.File).Replace('\\', '/') : problem.File;
            output.WriteLine($"MISMATCH\t{label}\tinternal={problem.InternalName}\tfile={problem.FileName}"
                           + $"\theaderHash=0x{problem.HeaderHash:X8}\texpected=0x{problem.ExpectedHash:X8}\t{problem.Reason}");
        }
        output.WriteLine($"VALIDATED {result.FilesChecked} files; mismatches={result.Problems.Count} skipped={result.Skipped}");
        return NscExitCodes.Ok;
    }
}
