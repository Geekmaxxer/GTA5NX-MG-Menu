using NscCore;
namespace NscAdapter;
public static class NscAdapterCli
{
    public static int Run(string[] args, TextWriter output, TextWriter error)
    {
        bool verbose = Array.Exists(args, a => string.Equals(a, "--verbose", StringComparison.OrdinalIgnoreCase));
        try
        {
            return Dispatch(args, output, error);
        }
        catch (NscFormatException ex)
        {
            error.WriteLine($"ERROR {ex.Message}");
            if (verbose) error.WriteLine(ex.ToString());
            return ex.ExitCode;
        }
        catch (Exception ex)
        {
            error.WriteLine($"UNEXPECTED {ex.GetType().Name}: {ex.Message}");
            if (verbose) error.WriteLine(ex.ToString());
            return 1;
        }
    }

    private static int Dispatch(string[] args, TextWriter output, TextWriter error)
    {
        if (args.Length == 0)
        {
            NscAdapterUsage.Write(error);
            return NscExitCodes.Usage;
        }
        string first = args[0];
        if (Is(first, "--help") || Is(first, "-h") || Is(first, "/?"))
        {
            NscAdapterUsage.Write(output);
            return NscExitCodes.Ok;
        }
        if (Is(first, "--version"))
        {
            output.WriteLine($"NscAdapter {typeof(NscAdapterCli).Assembly.GetName().Version}");
            output.WriteLine("Writes only the 8-byte page base at 0x00 and the 4-byte build word at 0x18, copied from a verified reference script.");
            return NscExitCodes.Ok;
        }
        if (!NscAdapterOptions.TryParse(args, out NscAdapterOptions options, out string problem))
        {
            error.WriteLine($"ERROR {problem}");
            NscAdapterUsage.Write(error);
            return NscExitCodes.Usage;
        }
        string mode = options.Mode.ToLowerInvariant();
        if (mode == NscAdapterOptions.AdaptHeader) return AdaptHeader(options, output, error);
        if (mode == NscAdapterOptions.Info) return NscAdapterInfo.Info(options, output, error);
        if (mode == NscAdapterOptions.ValidateNames) return NscAdapterInfo.ValidateNames(options, output, error);
        error.WriteLine($"ERROR unknown mode '{options.Mode}'");
        NscAdapterUsage.Write(error);
        return NscExitCodes.Usage;
    }

    private static int AdaptHeader(NscAdapterOptions options, TextWriter output, TextWriter error)
    {
        if (options.Positional.Count != 3)
        {
            error.WriteLine("ERROR --adapt-header needs a reference, a candidate and an output path");
            NscAdapterUsage.Write(error);
            return NscExitCodes.Usage;
        }
        string referenceInput = options.Positional[0];
        string candidatePath = options.Positional[1];
        string outputPath = options.Positional[2];
        NscReferenceResolution resolution = NscReferenceResolver.Resolve(referenceInput, options.PreferredName);
        NscAdapterReport.WriteReferenceLine(output, resolution);
        NscPayload reference = NscContainer.ReadFile(resolution.Path, NscExitCodes.InvalidReference);
        NscPayload candidate = NscContainer.ReadFile(candidatePath, NscExitCodes.InvalidCandidate);
        output.WriteLine($"REFERENCE_PAYLOAD {reference.Bytes.Length} bytes, {reference.KindLabel}");
        output.WriteLine($"CANDIDATE_PAYLOAD {candidate.Bytes.Length} bytes, {candidate.KindLabel}");
        NscAdapterReport.CheckReference(reference, candidate, error);
        if (string.Equals(Path.GetFullPath(resolution.Path), Path.GetFullPath(candidatePath), StringComparison.OrdinalIgnoreCase))
        {
            error.WriteLine("WARNING the same file is being used as both the reference and the candidate; the header will not really be adapted");
        }
        NscAdaptResult result = NscAdapt.Adapt(reference, candidate, outputPath, options.DryRun);
        NscAdapterReport.WriteTrace(output, result, outputPath, options.DryRun);
        if (options.Validate && !options.DryRun && result.WrittenPath != null)
        {
            NscNameValidationResult validation = NscNameValidation.ValidateFile(result.WrittenPath);
            foreach (NscNameProblem problem in validation.Problems)
            {
                error.WriteLine($"WARNING output failed name validation: {problem.Reason} (file={problem.FileName} internal={problem.InternalName})");
            }
            output.WriteLine($"VALIDATED {validation.FilesChecked} files; mismatches={validation.Problems.Count}");
            if (validation.Problems.Count > 0)
            {
                throw new NscFormatException("the adapted output does not satisfy the script name invariants", NscExitCodes.VerifyFailed);
            }
        }
        return NscExitCodes.Ok;
    }

    private static bool Is(string arg, string expected) => string.Equals(arg, expected, StringComparison.OrdinalIgnoreCase);
}
