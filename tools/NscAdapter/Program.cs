using System.IO.Compression;

if (args.Length != 4 || !string.Equals(args[0], "--adapt-header", StringComparison.OrdinalIgnoreCase))
{
    Console.Error.WriteLine("Usage: NscAdapter --adapt-header <switch-reference.nsc|folder> <candidate.nsc> <output.nsc>");
    Environment.Exit(2);
}

var reference = ReadPayloadFromPath(ResolveReferencePath(args[1]));
var candidateContainer = File.ReadAllBytes(args[2]);
var candidate = ReadPayloadFromBytes(candidateContainer);

if (reference.Length < 0x20 || candidate.Length < 0x78)
    throw new InvalidDataException("A valid Switch reference and candidate script are required.");

// Only copy values proven by the Switch reference script header. This does not
// invent native hashes, edit bytecode, or convert an arbitrary PC script.
Buffer.BlockCopy(reference, 0, candidate, 0, 8);
Buffer.BlockCopy(reference, 0x18, candidate, 0x18, 4);

Directory.CreateDirectory(Path.GetDirectoryName(Path.GetFullPath(args[3]))!);
File.WriteAllBytes(args[3], candidate);
Console.WriteLine($"WROTE_ADAPTED_HEADER {Path.GetFullPath(args[3])}");

static byte[] ReadPayloadFromPath(string path) => ReadPayloadFromBytes(File.ReadAllBytes(path));

static string ResolveReferencePath(string input)
{
    if (Directory.Exists(input))
    {
        string preferred = Path.Combine(input, "achievement_controller.nsc");
        if (File.Exists(preferred))
        {
            Console.WriteLine($"HEADER_REFERENCE_FOLDER fallback: {Path.GetFullPath(preferred)}");
            return preferred;
        }
        string first = Directory.EnumerateFiles(input, "*.nsc", SearchOption.TopDirectoryOnly).OrderBy(p => p, StringComparer.OrdinalIgnoreCase).FirstOrDefault() ?? string.Empty;
        if (!string.IsNullOrEmpty(first))
        {
            Console.WriteLine($"HEADER_REFERENCE_FOLDER fallback: {Path.GetFullPath(first)}");
            return first;
        }
        throw new InvalidDataException($"No .nsc reference found in folder {input}");
    }
    return input;
}

static byte[] ReadPayloadFromBytes(byte[] data)
{
    if (data.Length >= 18 && U32(data, 0) == 0x37435352)
    {
        if (IsUncompressed(data)) return data[16..];
        using var input = new MemoryStream(data, 16, data.Length - 16, false);
        using var deflate = new DeflateStream(input, CompressionMode.Decompress);
        using var output = new MemoryStream();
        deflate.CopyTo(output);
        return output.ToArray();
    }
    return data;
}

static bool IsUncompressed(byte[] data) => data.Length >= 24 && U64(data, 16) >= 0x0000700000000000UL && U64(data, 16) < 0x0000800000000000UL;
static uint U32(byte[] data, int offset) => BitConverter.ToUInt32(data, offset);
static ulong U64(byte[] data, int offset) => BitConverter.ToUInt64(data, offset);
