pub const cpu = @import("cpu/cpu.zig");
pub const instructions = @import("cpu/instructions.zig");
pub const registers = @import("cpu/registers.zig");
pub const cartridge = @import("cartridge.zig");

test {
    @import("std").testing.refAllDecls(@This());
}
