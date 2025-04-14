const std = @import("std");
const testing = std.testing;

const ZERO_FLAG_BYTE_POSITION: u3 = 7;
const SUBTRACT_FLAG_BYTE_POSITION: u3 = 6;
const HALF_CARRY_FLAG_BYTE_POSITION: u3 = 5;
const CARRY_FLAG_BYTE_POSITION: u3 = 4;

pub const Registers = struct {
    a: u8,
    b: u8,
    c: u8,
    d: u8,
    e: u8,
    f: FlagsRegister,
    h: u8,
    l: u8,

    pub fn get_af(self: Registers) u16 {
        return @as(u16, self.a) << 8 | @as(u16, self.f.toU8());
    }

    pub fn set_af(self: *Registers, value: u16) void {
        self.a = @truncate(value & 0x00FF);
        self.f = flagsFromU8(@truncate((value & 0xFF00) >> 8));
    }
    pub fn get_bc(self: Registers) u16 {
        return @as(u16, self.b) << 8 | @as(u16, self.c);
    }

    pub fn set_bc(self: *Registers, value: u16) void {
        self.b = @truncate(value & 0x00FF);
        self.c = @truncate((value & 0xFF00) >> 8);
    }
    pub fn get_de(self: Registers) u16 {
        return @as(u16, self.d) << 8 | @as(u16, self.e);
    }

    pub fn set_de(self: *Registers, value: u16) void {
        self.d = @truncate(value & 0x00FF);
        self.e = @truncate((value & 0xFF00) >> 8);
    }

    pub fn get_hl(self: Registers) u16 {
        return @as(u16, self.h) << 8 | @as(u16, self.l);
    }

    pub fn set_hl(self: *Registers, value: u16) void {
        self.h = @truncate(value & 0x00FF);
        self.l = @truncate((value & 0xFF00) >> 8);
    }
};

pub const FlagsRegister = struct {
    zero: u1,
    subtract: u1,
    half_carry: u1,
    carry: u1,

    pub fn toU8(self: FlagsRegister) u8 {
        const zero: u8 = @as(u8, if (self.zero == 1) 1 else 0) << ZERO_FLAG_BYTE_POSITION;
        const subtract: u8 = @as(u8, if (self.subtract == 1) 1 else 0) << SUBTRACT_FLAG_BYTE_POSITION;
        const half_carry: u8 = @as(u8, if (self.half_carry == 1) 1 else 0) << HALF_CARRY_FLAG_BYTE_POSITION;
        const carry: u8 = @as(u8, if (self.carry == 1) 1 else 0) << CARRY_FLAG_BYTE_POSITION;
        return zero | subtract | half_carry | carry;
    }
};

pub fn flagsFromU8(byte: u8) FlagsRegister {
    return .{
        .zero = @truncate(((byte >> ZERO_FLAG_BYTE_POSITION) & 0b1)),
        .subtract = @truncate(((byte >> SUBTRACT_FLAG_BYTE_POSITION) & 0b1)),
        .half_carry = @truncate(((byte >> HALF_CARRY_FLAG_BYTE_POSITION) & 0b1)),
        .carry = @truncate(((byte >> CARRY_FLAG_BYTE_POSITION) & 0b1)),
    };
}

var test_register = Registers{
    .a = 0b10101010,
    .b = 0b10101011,
    .c = 0b10100010,
    .d = 0b10001010,
    .e = 0b11101010,
    .f = FlagsRegister{ .zero = 1, .subtract = 0, .half_carry = 1, .carry = 0 },
    .h = 0b10111010,
    .l = 0b10101000,
};
test "Registers.get_af" {
    try testing.expect(test_register.get_af() == 0b1010101010100000);
}

test "Registers.get_bc" {
    try testing.expect(test_register.get_bc() == 0b1010101110100010);
}

test "Registers.get_de" {
    try testing.expect(test_register.get_de() == 0b1000101011101010);
}

test "Registers.get_hl" {
    try testing.expect(test_register.get_hl() == 0b1011101010101000);
}

test "Registers.set_af" {
    try testing.expect(test_register.get_af() != 0b1100000011010000);
    test_register.set_af(0b1100000011010000);
    try testing.expect(test_register.get_af() == 0b1101000011000000);
}
test "Registers.set_af_non_zero_lower_4" {
    try testing.expect(test_register.get_af() != 0b1100110011000000);
    test_register.set_af(0b1100110011000011);
    try testing.expect(test_register.get_af() == 0b1100001111000000);
}

test "Registers.set_bc" {
    try testing.expect(test_register.get_bc() != 0b1100001111001100);
    test_register.set_bc(0b1100001111001100);
    try testing.expect(test_register.get_bc() == 0b1100110011000011);
}

test "Registers.set_de" {
    try testing.expect(test_register.get_de() != 0b1100001111001100);
    test_register.set_de(0b1100001111001100);
    try testing.expect(test_register.get_de() == 0b1100110011000011);
}

test "Registers.set_hl" {
    try testing.expect(test_register.get_hl() != 0b1100001111001100);
    test_register.set_hl(0b1100001111001100);
    try testing.expect(test_register.get_hl() == 0b1100110011000011);
}
