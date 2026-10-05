using System.IO;
namespace NscCore;
public static class NscExitCodes
{
    public const int Ok = 0;
    public const int Usage = 2;
    public const int InvalidReference = 3;
    public const int InvalidCandidate = 4;
    public const int VerifyFailed = 5;
    public const int WriteFailed = 6;
}

public sealed class NscFormatException : Exception
{
    public NscFormatException(string message, int exitCode = NscExitCodes.InvalidCandidate)
        : base(message)
    {
        ExitCode = exitCode;
    }

    public int ExitCode { get; }
}
