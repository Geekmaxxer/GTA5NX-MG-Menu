namespace NscCore;

/// <summary>ScriptHookV-NX ABI 1 binding metadata for the exact compiled payload.</summary>
public static class NscNativeBindings
{
    private static readonly HashSet<ulong> Builtins = new()
    {
        0x4d45474153415645, 0x4d4547414c4f4144, 0x5348564e58535631, 0x5348564e584c4431,
        0x5348564e58415631, 0x5348564e58504331, 0x5348564e58504e31, 0x5348564e58504931,
        0x5348564e58505331, 0x5348564e58505431, 0x5348564e58505447, 0x5348564e5850524c,
        0x5348564e58504c31, 0x5348564e58505031, 0x5348564e58505032, 0x5348564e58504531,
        0x5348564e58505631, 0x5348564e58504b31, 0x5348564e58505231, 0x5348564e58504d31,
    };

    public static byte[] Generate(byte[] payload)
    {
        if (payload.Length < NscHeader.MinimumPayloadSize)
            throw new NscFormatException("Binding input is shorter than a script header.");
        uint code = NscHeader.CodeLength(payload), count = NscHeader.NativeCount(payload), name = NscHeader.NameHash(payload);
        int table = NscHeader.ResourceOffset(NscHeader.NativeTablePointer(payload));
        int blocks = NscHeader.ResourceOffset(NscHeader.ReadU64(payload, NscHeader.CodeBlocksPtrOffset));
        if (name == 0 || count > 65535 || (count > 0 && (table < 0x78 || table + 8L * count > payload.Length)))
            throw new NscFormatException("Invalid binding input layout.");
        var entries = new List<(uint Index, ulong Hash)>();
        for (uint index = 0; index < count; index++)
        {
            ulong stored = NscHeader.ReadU64(payload, table + (int)index * 8);
            int shift = (int)((code + index) & 63);
            ulong hash = (stored << shift) | (stored >> ((64 - shift) & 63));
            if (Builtins.Contains(hash)) entries.Add((index, hash));
        }
        if (entries.Count > 256) throw new NscFormatException("Too many custom-native binding entries.");
        int first = 0;
        if (entries.Count > 0)
        {
            if (code < 32 || blocks < 0x78 || blocks > payload.Length - 8)
                throw new NscFormatException("Missing script entry block.");
            first = NscHeader.ResourceOffset(NscHeader.ReadU64(payload, blocks));
            if (first < 0x78 || first > payload.Length - 32)
                throw new NscFormatException("Missing script entry fingerprint.");
        }
        using var body = new MemoryStream();
        using (var writer = new BinaryWriter(body, System.Text.Encoding.UTF8, true))
        {
            if (entries.Count > 0)
            {
                writer.Write(name); writer.Write(code); writer.Write(count); writer.Write((uint)entries.Count);
                writer.Write(payload, first, 32);
                foreach (var entry in entries) { writer.Write(entry.Index); writer.Write(0u); writer.Write(entry.Hash); }
            }
        }
        byte[] record = body.ToArray();
        uint crc = uint.MaxValue;
        foreach (byte value in record)
        {
            crc ^= value;
            for (int bit = 0; bit < 8; bit++) crc = (crc >> 1) ^ ((crc & 1) != 0 ? 0xedb88320u : 0);
        }
        using var output = new MemoryStream();
        using (var writer = new BinaryWriter(output, System.Text.Encoding.UTF8, true))
        {
            writer.Write(0x424e4853u); writer.Write(1u); writer.Write(entries.Count > 0 ? 1u : 0u); writer.Write(~crc);
            writer.Write(record);
        }
        return output.ToArray();
    }
}
