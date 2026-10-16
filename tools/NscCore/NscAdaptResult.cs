namespace NscCore;

/// <summary>What an adaptation did, for reporting and for the build manifest.</summary>
public sealed class NscAdaptResult
{
    public required byte[] Payload { get; init; }
    public required ulong CandidatePageBase { get; init; }
    public required uint CandidateBuildWord { get; init; }
    public required ulong ReferencePageBase { get; init; }
    public required uint ReferenceBuildWord { get; init; }

    /// <summary>Every payload offset whose byte value actually changed, ascending.</summary>
    public required IReadOnlyList<int> ChangedOffsets { get; init; }

    /// <summary>Full path written, or null for a dry run.</summary>
    public string? WrittenPath { get; init; }

    /// <summary>True when the candidate already carried the reference profile, so nothing changed.</summary>
    public bool AlreadyMatched => ChangedOffsets.Count == 0;

    /// <summary>Renders "0x02-0x03,0x18-0x1B" style ranges for reporting.</summary>
    public static string DescribeOffsets(IReadOnlyList<int> offsets)
    {
        if (offsets.Count == 0) return "none";
        var parts = new List<string>();
        int start = offsets[0];
        int previous = offsets[0];
        for (int i = 1; i <= offsets.Count; i++)
        {
            if (i < offsets.Count && offsets[i] == previous + 1)
            {
                previous = offsets[i];
                continue;
            }
            parts.Add(start == previous ? $"0x{start:X2}" : $"0x{start:X2}-0x{previous:X2}");
            if (i < offsets.Count)
            {
                start = offsets[i];
                previous = offsets[i];
            }
        }
        return string.Join(",", parts);
    }
}
