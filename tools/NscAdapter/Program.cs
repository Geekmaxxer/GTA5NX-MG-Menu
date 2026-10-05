namespace NscAdapter;
public static class Program
{
    public static int Main(string[] args) => NscAdapterCli.Run(args, Console.Out, Console.Error);
}
