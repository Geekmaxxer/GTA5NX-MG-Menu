namespace NscAdapter;
internal sealed class NscAdapterOptions
{
    public const string AdaptHeader = "--adapt-header";
    public const string Info = "--info";
    public const string ValidateNames = "--validate-names";
    public string Mode { get; private init; } = string.Empty;
    public List<string> Positional { get; } = new();
    public string? PreferredName { get; private set; }
    public bool DryRun { get; private set; }
    public bool Validate { get; private set; }
    public bool Verbose { get; private set; }
    public static bool TryParse(string[] args, out NscAdapterOptions options, out string problem)
    {
        options = new NscAdapterOptions { Mode = args.Length > 0 ? args[0] : string.Empty };
        problem = string.Empty;
        for (int i = 1; i < args.Length; i++)
        {
            string arg = args[i];
            switch (arg)
            {
                case "--name":
                    if (i + 1 >= args.Length)
                    {
                        problem = "--name requires a script name, e.g. --name ragemenu";
                        return false;
                    }
                    options.PreferredName = args[++i];
                    break;
                case "--dry-run":
                    options.DryRun = true;
                    break;
                case "--validate":
                    options.Validate = true;
                    break;
                case "--verbose":
                    options.Verbose = true;
                    break;
                default:
                    if (arg.StartsWith('-'))
                    {
                        problem = $"unknown option {arg}";
                        return false;
                    }
                    options.Positional.Add(arg);
                    break;
            }
        }
        return true;
    }
}
