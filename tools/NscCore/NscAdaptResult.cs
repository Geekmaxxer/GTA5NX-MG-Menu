namespace NscCore;
public sealed class NscAdaptResult
{
    public required byte[] Payload { get; init; }
    public required ulong CandidatePageBase { get; init; }
    public required uint CandidateBuildWord { get; init; }
    public required ulong ReferencePageBase { get; init; }
    public required uint ReferenceBuildWord { get; init; }
    public required IReadOnlyList<int> ChangedOffsets { get; init; }
    public string? WrittenPath { get; init; }
    public bool AlreadyMatched => ChangedOffsets.Count == 0;
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
