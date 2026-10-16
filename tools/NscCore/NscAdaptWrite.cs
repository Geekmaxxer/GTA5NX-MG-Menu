namespace NscCore;

public static partial class NscAdapt
{
    /// <summary>
    /// Writes to a sibling temp file, reads it back to confirm the bytes that
    /// actually landed are the bytes we meant to write, then moves it into
    /// place. A reader can never observe a half-written output, and a failed
    /// write never leaves a truncated file where a valid one used to be.
    /// </summary>
    public static string WriteAtomic(string outputPath, byte[] payload)
    {
        string full = Path.GetFullPath(outputPath);
        string? parent = Path.GetDirectoryName(full);
        if (!string.IsNullOrEmpty(parent))
        {
            try
            {
                Directory.CreateDirectory(parent);
            }
            catch (Exception ex) when (ex is IOException or UnauthorizedAccessException)
            {
                throw new NscFormatException($"cannot create output directory {parent}: {ex.Message}", NscExitCodes.WriteFailed);
            }
        }

        string temp = full + ".tmp-" + Guid.NewGuid().ToString("N")[..8];
        try
        {
            File.WriteAllBytes(temp, payload);
            byte[] readBack = File.ReadAllBytes(temp);
            if (!readBack.AsSpan().SequenceEqual(payload))
                throw new NscFormatException($"wrote {payload.Length} bytes to {temp} but read back {readBack.Length}; output is not intact", NscExitCodes.WriteFailed);
            File.Move(temp, full, overwrite: true);
            return full;
        }
        catch (NscFormatException)
        {
            TryDelete(temp);
            throw;
        }
        catch (Exception ex) when (ex is IOException or UnauthorizedAccessException)
        {
            TryDelete(temp);
            throw new NscFormatException($"cannot write {full}: {ex.Message}", NscExitCodes.WriteFailed);
        }
    }

    private static void TryDelete(string path)
    {
        try
        {
            if (File.Exists(path)) File.Delete(path);
        }
        catch (IOException)
        {
            // Best effort only: a leftover temp file must not mask the real error.
        }
        catch (UnauthorizedAccessException)
        {
        }
    }
}
