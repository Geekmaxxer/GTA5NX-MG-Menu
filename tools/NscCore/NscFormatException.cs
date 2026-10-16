using System.IO;

namespace NscCore;

/// <summary>
/// Process exit codes shared by every tool that touches a .nsc resource. The
/// build scripts switch on these, so a caller can tell a bad reference apart
/// from a bad candidate, a failed round-trip verification, and a failed write
/// without parsing English text.
/// </summary>
public static class NscExitCodes
{
    public const int Ok = 0;
    public const int Usage = 2;
    public const int InvalidReference = 3;
    public const int InvalidCandidate = 4;
    public const int VerifyFailed = 5;
    public const int WriteFailed = 6;
}

/// <summary>
/// Raised when a file is not a usable Switch script resource, or when an
/// adapter round-trip check fails. Carries the exit code the tool should
/// return so the failure is machine-readable.
///
/// Note InvalidDataException is sealed in .NET, so this cannot derive from it.
/// Call sites that previously caught InvalidDataException must catch this type
/// too; the shared decoder is strict where the old heuristic silently returned
/// garbage for an undecodable file.
/// </summary>
public sealed class NscFormatException : Exception
{
    public NscFormatException(string message, int exitCode = NscExitCodes.InvalidCandidate)
        : base(message)
    {
        ExitCode = exitCode;
    }

    public int ExitCode { get; }
}
