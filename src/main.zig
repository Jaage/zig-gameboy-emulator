//! By convention, main.zig is where your main function lives in the case that
//! you are building an executable. If you are making a library, the convention
//! is to delete this file and start with root.zig instead.

const std = @import("std");
/// This imports the separate module containing `root.zig`. Take a look in `build.zig` for details.
const lib = @import("gameboyzig_lib");
const registers = @import("cpu/registers.zig");

pub fn main() !void {
    const reg = registers.Registers{
        .a = 0b10101010,
        .b = 0b10101011,
        .c = 0b10100010,
        .d = 0b10001010,
        .e = 0b11101010,
        .f = registers.FlagsRegister{ .zero = 1, .subtract = 0, .half_carry = 1, .carry = 0 },
        .h = 0b10111010,
        .l = 0b10101000,
    };
    std.debug.print("af register:{b}", .{reg.get_af()});
}
