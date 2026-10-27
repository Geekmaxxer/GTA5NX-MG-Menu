using NscAdapter;
using NscCore;
using Xunit;

namespace NscTests;

public class NscNativeBindingTests
{
    private static byte[] Script(uint code = 64, uint index = 1, ulong hash = 0x4d4547414c4f4144)
    {
        var payload = new byte[512];
        NscHeader.WriteU64(payload, 0, SyntheticNsc.StockPageBase);
        NscHeader.WriteU64(payload, 0x10, 0x50000080);
        NscHeader.WriteU32(payload, 0x1c, code);
        NscHeader.WriteU32(payload, 0x2c, 3);
        NscHeader.WriteU64(payload, 0x40, 0x500000a0);
        NscHeader.WriteU32(payload, 0x58, 0x4bd26eef);
        NscHeader.WriteU64(payload, 0x80, 0x50000100);
        for (int i = 0; i < 32; i++) payload[0x100 + i] = (byte)i;
        int shift = (int)((code + index) & 63);
        NscHeader.WriteU64(payload, 0xa0 + (int)index * 8, (hash >> shift) | (hash << ((64 - shift) & 63)));
        return payload;
    }

    [Theory]
    [InlineData(64u, 0u)]
    [InlineData(64u, 1u)]
    [InlineData(63u, 1u)]
    [InlineData(327603u, 2u)]
    public void Metadata_tracks_decoded_slot_and_compiled_identity(uint code, uint index)
    {
        var binding = NscNativeBindings.Generate(Script(code, index));
        Assert.Equal(80, binding.Length);
        Assert.Equal(0x424e4853u, BitConverter.ToUInt32(binding, 0));
        Assert.Equal(1u, BitConverter.ToUInt32(binding, 8));
        Assert.Equal(code, BitConverter.ToUInt32(binding, 20));
        Assert.Equal(index, BitConverter.ToUInt32(binding, 64));
        Assert.Equal(0x4d4547414c4f4144ul, BitConverter.ToUInt64(binding, 72));
        Assert.Equal(Script(code, index)[0x100..0x120], binding[32..64]);
    }

    [Fact]
    public void Timing_native_is_included_in_runtime_binding_metadata()
    {
        var binding = NscNativeBindings.Generate(Script(hash: 0x5348564e58504d31));
        Assert.Equal(80, binding.Length);
        Assert.Equal(1u, BitConverter.ToUInt32(binding, 8));
        Assert.Equal(0x5348564e58504d31ul, BitConverter.ToUInt64(binding, 72));
    }

    [Fact]
    public void Cli_rejects_previous_build_binding_without_replacing_it()
    {
        string folder = Path.Combine(Path.GetTempPath(), "nsc-binding-" + Guid.NewGuid().ToString("N"));
        Directory.CreateDirectory(folder);
        try
        {
            string script = Path.Combine(folder, "ragemenu.nsc"), snb = Path.Combine(folder, "ragemenu.snb");
            File.WriteAllBytes(script, Script());
            using var output = new StringWriter(); using var error = new StringWriter();
            Assert.Equal(0, NscAdapterCli.Run(new[] { "--write-bindings", script, snb }, output, error));
            byte[] before = File.ReadAllBytes(snb);
            File.WriteAllBytes(script, Script(65));
            Assert.Equal(NscExitCodes.VerifyFailed, NscAdapterCli.Run(new[] { "--verify-bindings", script, snb }, output, error));
            Assert.Equal(before, File.ReadAllBytes(snb));
            Assert.Equal(0, NscAdapterCli.Run(new[] { "--write-bindings", script, snb }, output, error));
            Assert.Equal(0, NscAdapterCli.Run(new[] { "--verify-bindings", script, snb }, output, error));
            Assert.NotEqual(before, File.ReadAllBytes(snb));
        }
        finally { Directory.Delete(folder, true); }
    }

    [Fact]
    public void Script_without_natives_does_not_need_a_binding_record()
    {
        var script = Script(12); NscHeader.WriteU32(script, 0x2c, 0); NscHeader.WriteU64(script, 0x40, 0);
        byte[] binding = NscNativeBindings.Generate(script);
        Assert.Equal(16, binding.Length); Assert.Equal(0u, BitConverter.ToUInt32(binding, 8));
    }

    [Fact]
    public void Truncated_native_table_and_entry_code_are_rejected()
    {
        var script = Script(); NscHeader.WriteU64(script, 0x40, 0x500001ff);
        Assert.Throws<NscFormatException>(() => NscNativeBindings.Generate(script));
        script = Script(); NscHeader.WriteU64(script, 0x80, 0x500001ff);
        Assert.Throws<NscFormatException>(() => NscNativeBindings.Generate(script));
    }
}
