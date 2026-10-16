namespace NscCore;

/// <summary>One script whose filename or stored name hash disagrees with its internal name.</summary>
public sealed record NscNameProblem(string File, string InternalName, string FileName, uint HeaderHash, uint ExpectedHash, string Reason);

public sealed record NscNameValidationResult(int FilesChecked, int Skipped, IReadOnlyList<NscNameProblem> Problems)
{
    public bool Ok => Problems.Count == 0 && FilesChecked > 0;
}

/// <summary>
/// Checks the script name invariants: the file name must match the internal
/// name baked into the payload, and the stored name hash at 0x58 must equal
/// Joaat(internal name). Both matter because the RPF entry name and the header
/// hash must agree with the compiled internal name.
///
/// Note this deliberately uses the full file name minus only the last
/// extension, so "ragemenu.pc.nsc" reports internal "ragemenu" against file
/// name "ragemenu.pc" and is flagged. That is intended: a .pc.nsc must never
/// be installed, and this is how it gets caught.
/// </summary>
public static class NscNameValidation
{
    public static NscNameValidationResult ValidateFile(string path)
    {
        NscNameProblem? problem = Validate(path, out bool counted);
        return new NscNameValidationResult(counted ? 1 : 0, counted ? 0 : 1, problem == null ? Array.Empty<NscNameProblem>() : new[] { problem });
    }

    public static NscNameValidationResult ValidateDirectory(string directory)
    {
        var problems = new List<NscNameProblem>();
        int files = 0;
        int skipped = 0;
        foreach (string path in Directory.EnumerateFiles(directory, "*.nsc", SearchOption.AllDirectories)
                                        .OrderBy(p => p, StringComparer.OrdinalIgnoreCase))
        {
            NscNameProblem? problem = Validate(path, out bool counted);
            if (counted) files++;
            else skipped++;
            if (problem != null) problems.Add(problem);
        }
        return new NscNameValidationResult(files, skipped, problems);
    }

    private static NscNameProblem? Validate(string path, out bool counted)
    {
        counted = false;
        byte[] fileBytes;
        try
        {
            fileBytes = File.ReadAllBytes(path);
        }
        catch (Exception ex) when (ex is IOException or UnauthorizedAccessException)
        {
            return new NscNameProblem(path, string.Empty, string.Empty, 0, 0, $"unreadable: {ex.Message}");
        }

        string fileName = Path.GetFileNameWithoutExtension(path);

        if (!NscContainer.TryRead(fileBytes, path, out byte[] payload, out _, out string decodeProblem))
            return new NscNameProblem(path, string.Empty, fileName, 0, 0, decodeProblem);

        if (payload.Length < NscHeader.MinimumPayloadSize)
            return new NscNameProblem(path, string.Empty, fileName, 0, 0, $"payload is only {payload.Length} bytes, too small for a script header");

        // A decodable payload of adequate size always counts as checked, even
        // when its name is wrong: FilesChecked answers "how many scripts did we
        // look at", and Problems answers "how many are wrong".
        counted = true;

        string internalName = NscHeader.InternalName(payload);
        uint storedHash = NscHeader.NameHash(payload);
        uint expectedHash = NscHeader.Joaat(internalName);
        bool nameOk = string.Equals(fileName, internalName, StringComparison.OrdinalIgnoreCase);
        bool hashOk = storedHash == expectedHash;

        if (nameOk && hashOk) return null;

        string reason = !nameOk && !hashOk
            ? "file name and header name hash both mismatch the internal name"
            : !nameOk
                ? "file name does not match the internal name"
                : "header name hash does not match Joaat(internal name)";
        return new NscNameProblem(path, internalName, fileName, storedHash, expectedHash, reason);
    }
}
