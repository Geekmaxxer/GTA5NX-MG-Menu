namespace NscCore;
public static partial class NscAdapt
{
    public static bool IsAdaptableOffset(int offset)
        => offset is >= NscHeader.PageBaseOffset and < NscHeader.PageBaseOffset + 8
                or >= NscHeader.BuildWordOffset and < NscHeader.BuildWordOffset + 4;
    public static NscAdaptResult Adapt(NscPayload reference, NscPayload candidate, string? outputPath, bool dryRun = false)
    {
        byte[] original = candidate.Bytes;
        byte[] payload = (byte[])original.Clone();
        ulong referencePageBase = NscHeader.PageBase(reference.Bytes);
        uint referenceBuildWord = NscHeader.BuildWord(reference.Bytes);
        ulong candidatePageBase = NscHeader.PageBase(original);
        uint candidateBuildWord = NscHeader.BuildWord(original);
        NscHeader.WriteU64(payload, NscHeader.PageBaseOffset, referencePageBase);
        NscHeader.WriteU32(payload, NscHeader.BuildWordOffset, referenceBuildWord);
        IReadOnlyList<int> changed = Verify(original, payload, reference.Bytes, referencePageBase, referenceBuildWord);
        string? written = null;
        if (!dryRun && outputPath != null) written = WriteAtomic(outputPath, payload);
        return new NscAdaptResult
        {
            Payload = payload,
            CandidatePageBase = candidatePageBase,
            CandidateBuildWord = candidateBuildWord,
            ReferencePageBase = referencePageBase,
            ReferenceBuildWord = referenceBuildWord,
            ChangedOffsets = changed,
            WrittenPath = written,
        };
    }

    public static IReadOnlyList<int> Verify(byte[] original, byte[] adapted, byte[] referenceBytes, ulong expectedPageBase, uint expectedBuildWord)
    {
        if (original.Length != adapted.Length)
            throw new NscFormatException($"round-trip length changed ({original.Length} -> {adapted.Length})", NscExitCodes.VerifyFailed);
        if (referenceBytes.Length < NscHeader.MinimumPayloadSize)
            throw new NscFormatException($"reference payload is only {referenceBytes.Length} bytes, too small to hold a header", NscExitCodes.VerifyFailed);
        var changed = new List<int>();
        for (int i = 0; i < adapted.Length; i++)
        {
            if (adapted[i] == original[i]) continue;
            changed.Add(i);
            if (!IsAdaptableOffset(i))
                throw new NscFormatException(
                    $"round-trip check failed: byte 0x{i:X} outside the adaptable regions changed; the adapter may only write 0x00-0x07 and 0x18-0x1B",
                    NscExitCodes.VerifyFailed);
        }
        if (!adapted.AsSpan(NscHeader.PageBaseOffset, 8).SequenceEqual(referenceBytes.AsSpan(NscHeader.PageBaseOffset, 8)))
            throw new NscFormatException("round-trip check failed: the written page base does not match the reference", NscExitCodes.VerifyFailed);
        if (!adapted.AsSpan(NscHeader.BuildWordOffset, 4).SequenceEqual(referenceBytes.AsSpan(NscHeader.BuildWordOffset, 4)))
            throw new NscFormatException("round-trip check failed: the written build word does not match the reference", NscExitCodes.VerifyFailed);
        if (NscHeader.PageBase(adapted) != expectedPageBase)
            throw new NscFormatException($"round-trip check failed: page base reads back as 0x{NscHeader.PageBase(adapted):X16}, expected 0x{expectedPageBase:X16}", NscExitCodes.VerifyFailed);
        if (NscHeader.BuildWord(adapted) != expectedBuildWord)
            throw new NscFormatException($"round-trip check failed: build word reads back as 0x{NscHeader.BuildWord(adapted):X8}, expected 0x{expectedBuildWord:X8}", NscExitCodes.VerifyFailed);
        return changed;
    }
}
