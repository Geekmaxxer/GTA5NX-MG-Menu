namespace NscAdapter;
internal static class NscAdapterUsage
{
    public static void Write(TextWriter writer)
    {
        writer.WriteLine("NscAdapter - adapt a Win64 GTA V script to the Switch header profile");
        writer.WriteLine();
        writer.WriteLine("  NscAdapter --adapt-header <reference.nsc|folder> <candidate.nsc> <output.nsc>");
        writer.WriteLine("             [--name <Name>] [--dry-run] [--validate] [--verbose]");
        writer.WriteLine("  NscAdapter --info <reference.nsc|folder> [candidate.nsc] [--name <Name>]");
        writer.WriteLine("  NscAdapter --validate-names <file|folder>");
        writer.WriteLine("  NscAdapter --help | --version");
        writer.WriteLine();
        writer.WriteLine("Only the 8-byte page base at 0x00 and the 4-byte build word at 0x18 are copied.");
        writer.WriteLine("The result is verified byte-for-byte before it is written, and written atomically.");
        writer.WriteLine();
        writer.WriteLine("Options:");
        writer.WriteLine("  --name <Name>   Folder references resolve <folder>\\<Name>.nsc first, then");
        writer.WriteLine("                  achievement_controller.nsc, then the first .nsc found.");
        writer.WriteLine("  --dry-run       Verify and report, but write nothing.");
        writer.WriteLine("  --validate      Run the script name checks against the file just written.");
        writer.WriteLine("  --verbose       Include a stack trace on failure.");
        writer.WriteLine();
        writer.WriteLine("Exit codes: 0 ok, 2 usage, 3 bad reference, 4 bad candidate, 5 verification failed, 6 write failed");
    }
}
