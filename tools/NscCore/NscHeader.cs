using System.Text;
namespace NscCore;
public static class NscHeader
{
    public const int PageBaseOffset = 0x00;
    public const int CodeBlocksPtrOffset = 0x10;
    public const int BuildWordOffset = 0x18;
    public const int CodeLengthOffset = 0x1C;
    public const int ParamsCountOffset = 0x20;
    public const int StaticsCountOffset = 0x24;
    public const int GlobalsCountOffset = 0x28;
    public const int NativeCountOffset = 0x2C;
    public const int NativeTablePtrOffset = 0x40;
    public const int NameHashOffset = 0x58;
    public const int NamePtrOffset = 0x60;
    public const int StringsPtrOffset = 0x68;
    public const int StringsSizeOffset = 0x70;
    public const int MinimumPayloadSize = 0x78;
    public const int AdaptedHeaderBytes = 12;
    public const ulong ResourcePointerMask = 0x00FFFFFFUL;
    public const ulong ResourcePointerTag = 0x50000000UL;
    public const ulong PageBaseMinimum = 0x0000700000000000UL;
    public const ulong PageBaseMaximum = 0x0000800000000000UL;
    public static uint ReadU32(byte[] data, int offset) => BitConverter.ToUInt32(data, offset);
    public static ulong ReadU64(byte[] data, int offset) => BitConverter.ToUInt64(data, offset);
    public static void WriteU32(byte[] data, int offset, uint value)
        => Buffer.BlockCopy(BitConverter.GetBytes(value), 0, data, offset, 4);
    public static void WriteU64(byte[] data, int offset, ulong value)
        => Buffer.BlockCopy(BitConverter.GetBytes(value), 0, data, offset, 8);
    public static ulong PageBase(byte[] payload) => ReadU64(payload, PageBaseOffset);
    public static uint BuildWord(byte[] payload) => ReadU32(payload, BuildWordOffset);
    public static uint CodeLength(byte[] payload) => ReadU32(payload, CodeLengthOffset);
    public static uint ParamsCount(byte[] payload) => ReadU32(payload, ParamsCountOffset);
    public static uint StaticsCount(byte[] payload) => ReadU32(payload, StaticsCountOffset);
    public static uint GlobalsCount(byte[] payload) => ReadU32(payload, GlobalsCountOffset);
    public static uint NativeCount(byte[] payload) => ReadU32(payload, NativeCountOffset);
    public static uint NameHash(byte[] payload) => ReadU32(payload, NameHashOffset);
    public static ulong NamePointer(byte[] payload) => ReadU64(payload, NamePtrOffset);
    public static ulong NativeTablePointer(byte[] payload) => ReadU64(payload, NativeTablePtrOffset);
    public static bool IsPageBaseShaped(ulong value) => value >= PageBaseMinimum && value < PageBaseMaximum;
    public static int ResourceOffset(ulong pointer)
    {
        long offset = (long)(pointer & ResourcePointerMask);
        if (offset > int.MaxValue)
            throw new NscFormatException($"resource pointer 0x{pointer:X16} has an out-of-range offset");
        return (int)offset;
    }

    public static string ReadNullTerminated(byte[] data, int offset)
    {
        if (offset < 0 || offset >= data.Length) return "<invalid>";
        int end = offset;
        while (end < data.Length && data[end] != 0) end++;
        return Encoding.UTF8.GetString(data, offset, end - offset);
    }

    public static string InternalName(byte[] payload) => ReadNullTerminated(payload, ResourceOffset(NamePointer(payload)));
    public static bool TryInternalName(byte[] payload, out string name)
    {
        name = string.Empty;
        if (payload.Length < MinimumPayloadSize) return false;
        try
        {
            name = InternalName(payload);
        }
        catch (NscFormatException)
        {
            return false;
        }
        catch (ArgumentOutOfRangeException)
        {
            return false;
        }
        return name.Length > 0 && name != "<invalid>";
    }

    public static uint Joaat(string value)
    {
        uint hash = 0;
        foreach (byte b in Encoding.ASCII.GetBytes(value.ToLowerInvariant()))
        {
            hash += b;
            hash += hash << 10;
            hash ^= hash >> 6;
        }
        hash += hash << 3;
        hash ^= hash >> 11;
        hash += hash << 15;
        return hash;
    }
}
