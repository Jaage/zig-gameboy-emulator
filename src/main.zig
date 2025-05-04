//! By convention, main.zig is where your main function lives in the case that
//! you are building an executable. If you are making a library, the convention
//! is to delete this file and start with root.zig instead.

const std = @import("std");
/// This imports the separate module containing `root.zig`. Take a look in `build.zig` for details.
const lib = @import("zigboy");
// const registers = @import("cpu/registers.zig");
// const cpu = @import("cpu/cpu.zig");
const cartridge = @import("cartridge.zig");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{ .thread_safe = true }){};
    const allocator = gpa.allocator();
    const cc = try cartridge.loadCartridge(allocator, "pokemon-red-rom.gb");
    defer (allocator.free(cc.rom_data));
    // std.debug.print("{s}", .{cc.filename});
    // std.debug.print("af register:{b}", .{reg.get_af()});
}
