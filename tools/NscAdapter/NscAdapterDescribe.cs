using NscCore;
namespace NscAdapter;
internal static class NscAdapterDescribe
{
    public static NscPayload? Write(TextWriter output, string path, string role)
    {
        output.WriteLine($"--- {role}: {Path.GetFullPath(path)}");
        byte[] fileBytes;
        try
        {
            fileBytes = File.ReadAllBytes(path);
        }
        catch (Exception ex) when (ex is IOException or UnauthorizedAccessException)
        {
            output.WriteLine($"READ_FAILED {ex.Message}");
            return null;
        }
        bool envelope = NscContainer.HasRsc7Envelope(fileBytes);
        output.WriteLine($"FILE_BYTES {fileBytes.Length}");
        output.WriteLine($"RSC7_ENVELOPE {(envelope ? "yes" : "no")}");
        output.WriteLine($"BARE_PAYLOAD {(envelope ? "no" : "yes")}");
        if (!NscContainer.TryRead(fileBytes, path, out byte[] payload, out NscDecodeKind kind, out string problem))
        {
            output.WriteLine($"DECODE_FAILED {problem}");
            return null;
        }
        output.WriteLine($"DECODE {kind}");
        output.WriteLine($"PAYLOAD_BYTES {payload.Length}");
        ulong pageBase = NscHeader.PageBase(payload);
        output.WriteLine($"PAGE_BASE 0x{pageBase:X16} shaped={(NscHeader.IsPageBaseShaped(pageBase) ? "yes" : "no")}");
        output.WriteLine($"BUILD_WORD 0x{NscHeader.BuildWord(payload):X8}");
        output.WriteLine($"CODE_LENGTH {NscHeader.CodeLength(payload)}");
        output.WriteLine($"STATICS {NscHeader.StaticsCount(payload)}");
        output.WriteLine($"NATIVES {NscHeader.NativeCount(payload)}");
        bool nameReadable = NscHeader.TryInternalName(payload, out string internalName);
        uint storedHash = NscHeader.NameHash(payload);
        bool hashOk = nameReadable && NscHeader.Joaat(internalName) == storedHash;
        output.WriteLine($"INTERNAL_NAME {(nameReadable ? internalName : "<unreadable>")}");
        output.WriteLine($"NAME_HASH 0x{storedHash:X8} joaat_match={(hashOk ? "yes" : "no")}");
        NscProfile? profile = NscProfiles.Match(payload);
        output.WriteLine($"PROFILE {(profile == null ? "unknown" : profile.Name)}");
        if (envelope)
        {
            output.WriteLine("NOTE has an RSC7 envelope; script_rel.rpf expects a raw payload file entry, so this file must not be installed as-is");
        }
        if (NscProfiles.IsEnvelopeMagicReadAsPageBase(pageBase))
        {
            output.WriteLine("NOTE page base is the RSC7 magic: this looks like a container whose header was never adapted");
        }
        return new NscPayload { Bytes = payload, FileBytes = fileBytes, Path = path, Kind = kind };
    }
}
