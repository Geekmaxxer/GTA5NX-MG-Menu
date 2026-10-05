namespace NscCore;
public static partial class NscAdapt
{
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
        }
        catch (UnauthorizedAccessException)
        {
        }
    }
}
