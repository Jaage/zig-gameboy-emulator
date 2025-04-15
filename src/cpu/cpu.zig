const std = @import("std");
const print = std.debug.print;
const assert = std.debug.assert;
const testing = std.testing;
const registers = @import("registers.zig");
const Registers = registers.Registers;
const FlagsRegister = registers.FlagsRegister;
const instructions = @import("instructions.zig");
const Instruction = instructions.Instruction;
const PrefixInstruction = instructions.PrefixInstruction;
const instFromByte = instructions.instFromByte;
const prefixInstFromByte = instructions.prefixInstFromByte;

const CPU = struct {
    regs: Registers,
    pc: u16,
    sp: u16,
    bus: MemoryBus,

    pub fn executeInst(self: *CPU, inst: Instruction) u16 {
        return switch (inst) {
            Instruction.ADD_A => self.add(self.regs.a),
            Instruction.ADD_B => self.add(self.regs.b),
            Instruction.ADD_C => self.add(self.regs.c),
            Instruction.ADD_D => self.add(self.regs.d),
            Instruction.ADD_E => self.add(self.regs.e),
            Instruction.ADD_H => self.add(self.regs.h),
            Instruction.ADD_L => self.add(self.regs.l),

            Instruction.JP_NZ_a16 => self.jumpAbsolute(self.regs.f.zero == 0),
            Instruction.JP_Z_a16 => self.jumpAbsolute(self.regs.f.zero == 1),
            Instruction.JP_NC_a16 => self.jumpAbsolute(self.regs.f.carry == 0),
            Instruction.JP_C_a16 => self.jumpAbsolute(self.regs.f.carry == 1),
            Instruction.JP_a16 => self.jumpAbsolute(true),
            Instruction.JR_NZ_e8 => self.jumpRelative(self.regs.f.zero == 0),
            Instruction.JR_Z_e8 => self.jumpRelative(self.regs.f.zero == 1),
            Instruction.JR_NC_e8 => self.jumpRelative(self.regs.f.carry == 0),
            Instruction.JR_C_e8 => self.jumpRelative(self.regs.f.carry == 1),
            Instruction.JR_e8 => self.jumpRelative(true),

            // Instruction.LD_BC_n16 => self.regs.set_bc(),
            // Instruction.LD_BCA_A => self.load,
            // Instruction.LD_B_n8 => self.load,
            // Instruction.LD_a16_SP => self.load,
            // Instruction.LD_A_BC => self.load,
            // Instruction.LD_C_n8 => self.load,
            // Instruction.LD_DE_n16 => self.load,
            // Instruction.LD_DEA_A => self.load,
            // Instruction.LD_D_n8 => self.load,
            // Instruction.LD_A_DE => self.load,
            // Instruction.LD_E_n8 => self.load,
            // Instruction.LD_HL_n16 => self.load,
            // Instruction.LD_HLI_A => self.load,
            // Instruction.LD_H_n8 => self.load,
            // Instruction.LD_A_HLI => self.load,
            // Instruction.LD_L_n8 => self.load,
            // Instruction.LD_SP_n16 => self.load,
            // Instruction.LD_HLD_A => self.load,
            // Instruction.LD_HLA_n8 => self.load,
            // Instruction.LD_A_HLD => self.load,
            // Instruction.LD_A_n8 => self.load,
            Instruction.LD_B_B => self.loadR8N8(&self.regs.b, self.regs.b),
            Instruction.LD_B_C => self.loadR8N8(&self.regs.b, self.regs.c),
            Instruction.LD_B_D => self.loadR8N8(&self.regs.b, self.regs.d),
            Instruction.LD_B_E => self.loadR8N8(&self.regs.b, self.regs.e),
            Instruction.LD_B_H => self.loadR8N8(&self.regs.b, self.regs.h),
            Instruction.LD_B_L => self.loadR8N8(&self.regs.b, self.regs.l),
            Instruction.LD_B_HLA => self.loadR8N8(&self.regs.b, self.bus.readByte(self.regs.get_hl())),
            Instruction.LD_B_A => self.loadR8N8(&self.regs.b, self.regs.a),
            Instruction.LD_C_B => self.loadR8N8(&self.regs.c, self.regs.b),
            Instruction.LD_C_C => self.loadR8N8(&self.regs.c, self.regs.c),
            Instruction.LD_C_D => self.loadR8N8(&self.regs.c, self.regs.d),
            Instruction.LD_C_E => self.loadR8N8(&self.regs.c, self.regs.e),
            Instruction.LD_C_H => self.loadR8N8(&self.regs.c, self.regs.h),
            Instruction.LD_C_L => self.loadR8N8(&self.regs.c, self.regs.l),
            Instruction.LD_C_HLA => self.loadR8N8(&self.regs.c, self.bus.readByte(self.regs.get_hl())),
            Instruction.LD_C_A => self.loadR8N8(&self.regs.c, self.regs.a),
            Instruction.LD_D_B => self.loadR8N8(&self.regs.d, self.regs.b),
            Instruction.LD_D_C => self.loadR8N8(&self.regs.d, self.regs.c),
            Instruction.LD_D_D => self.loadR8N8(&self.regs.d, self.regs.d),
            Instruction.LD_D_E => self.loadR8N8(&self.regs.d, self.regs.e),
            Instruction.LD_D_H => self.loadR8N8(&self.regs.d, self.regs.h),
            Instruction.LD_D_L => self.loadR8N8(&self.regs.d, self.regs.l),
            Instruction.LD_D_HLA => self.loadR8N8(&self.regs.d, self.bus.readByte(self.regs.get_hl())),
            Instruction.LD_D_A => self.loadR8N8(&self.regs.d, self.regs.a),
            Instruction.LD_E_B => self.loadR8N8(&self.regs.e, self.regs.b),
            Instruction.LD_E_C => self.loadR8N8(&self.regs.e, self.regs.c),
            Instruction.LD_E_D => self.loadR8N8(&self.regs.e, self.regs.d),
            Instruction.LD_E_E => self.loadR8N8(&self.regs.e, self.regs.e),
            Instruction.LD_E_H => self.loadR8N8(&self.regs.e, self.regs.h),
            Instruction.LD_E_L => self.loadR8N8(&self.regs.e, self.regs.l),
            Instruction.LD_E_HLA => self.loadR8N8(&self.regs.e, self.bus.readByte(self.regs.get_hl())),
            Instruction.LD_E_A => self.loadR8N8(&self.regs.e, self.regs.a),
            Instruction.LD_H_B => self.loadR8N8(&self.regs.h, self.regs.b),
            Instruction.LD_H_C => self.loadR8N8(&self.regs.h, self.regs.c),
            Instruction.LD_H_D => self.loadR8N8(&self.regs.h, self.regs.d),
            Instruction.LD_H_E => self.loadR8N8(&self.regs.h, self.regs.e),
            Instruction.LD_H_H => self.loadR8N8(&self.regs.h, self.regs.h),
            Instruction.LD_H_L => self.loadR8N8(&self.regs.h, self.regs.l),
            Instruction.LD_H_HLA => self.loadR8N8(&self.regs.h, self.bus.readByte(self.regs.get_hl())),
            Instruction.LD_H_A => self.loadR8N8(&self.regs.h, self.regs.a),
            Instruction.LD_L_B => self.loadR8N8(&self.regs.l, self.regs.b),
            Instruction.LD_L_C => self.loadR8N8(&self.regs.l, self.regs.c),
            Instruction.LD_L_D => self.loadR8N8(&self.regs.l, self.regs.d),
            Instruction.LD_L_E => self.loadR8N8(&self.regs.l, self.regs.e),
            Instruction.LD_L_H => self.loadR8N8(&self.regs.l, self.regs.h),
            Instruction.LD_L_L => self.loadR8N8(&self.regs.l, self.regs.l),
            Instruction.LD_L_HLA => self.loadR8N8(&self.regs.l, self.bus.readByte(self.regs.get_hl())),
            Instruction.LD_L_A => self.loadR8N8(&self.regs.l, self.regs.a),
            Instruction.LD_HLA_B => self.loadR8N8(&self.bus.memory[self.regs.get_hl()], self.regs.b),
            Instruction.LD_HLA_C => self.loadR8N8(&self.bus.memory[self.regs.get_hl()], self.regs.c),
            Instruction.LD_HLA_D => self.loadR8N8(&self.bus.memory[self.regs.get_hl()], self.regs.d),
            Instruction.LD_HLA_E => self.loadR8N8(&self.bus.memory[self.regs.get_hl()], self.regs.e),
            Instruction.LD_HLA_H => self.loadR8N8(&self.bus.memory[self.regs.get_hl()], self.regs.h),
            Instruction.LD_HLA_L => self.loadR8N8(&self.bus.memory[self.regs.get_hl()], self.regs.l),
            Instruction.LD_HLA_A => self.loadR8N8(&self.bus.memory[self.regs.get_hl()], self.regs.a),
            Instruction.LD_A_B => self.loadR8N8(&self.regs.a, self.regs.b),
            Instruction.LD_A_C => self.loadR8N8(&self.regs.a, self.regs.c),
            Instruction.LD_A_D => self.loadR8N8(&self.regs.a, self.regs.d),
            Instruction.LD_A_E => self.loadR8N8(&self.regs.a, self.regs.e),
            Instruction.LD_A_H => self.loadR8N8(&self.regs.a, self.regs.h),
            Instruction.LD_A_L => self.loadR8N8(&self.regs.a, self.regs.l),
            Instruction.LD_A_HLA => self.loadR8N8(&self.regs.a, self.bus.readByte(self.regs.get_hl())),
            Instruction.LD_A_A => self.loadR8N8(&self.regs.a, self.regs.a),
            // Instruction.LDH_a8p_A => self.load,
            // Instruction.LDH_CP_A => self.load,
            // Instruction.LD_a16p_A => self.load,
            // Instruction.LDH_A_a8p => self.load,
            // Instruction.LDH_A_CP => self.load,
            // Instruction.LD_HL_SPPLUSe8 => self.load,
            // Instruction.LD_SP_HL => self.load,
            // Instruction.LD_A_a16p => self.load,

            Instruction.PUSH_BC => self.push(self.regs.get_bc()),
            Instruction.PUSH_DE => self.push(self.regs.get_de()),
            Instruction.PUSH_HL => self.push(self.regs.get_hl()),
            Instruction.PUSH_AF => self.push(self.regs.get_af()),

            Instruction.POP_BC => blk: {
                const popped_value = self.pop();
                self.regs.set_bc(popped_value);
                break :blk self.pc +% 1;
            },
            Instruction.POP_DE => blk: {
                const popped_value = self.pop();
                self.regs.set_de(popped_value);
                break :blk self.pc +% 1;
            },
            Instruction.POP_HL => blk: {
                const popped_value = self.pop();
                self.regs.set_hl(popped_value);
                break :blk self.pc +% 1;
            },
            Instruction.POP_AF => blk: {
                const popped_value = self.pop();
                self.regs.set_af(popped_value);
                break :blk self.pc +% 1;
            },
            else => 0,
        };
    }

    pub fn executePrefixInst(self: *CPU, inst: PrefixInstruction) u16 {
        std.debug.print("{}", .{inst});
        return self.pc;
    }

    pub fn step(self: *CPU) void {
        const inst_byte = self.bus.readByte(self.pc);
        if (inst_byte == 0xCB) {
            const inst = prefixInstFromByte(self.bus.readByte(self.pc + 1));
            self.pc = self.executePrefixInst(inst);
        } else {
            const inst = instFromByte(inst_byte);
            self.pc = self.executeInst(inst);
        }
    }

    pub fn loadR8N8(self: *CPU, l: *u8, r: u8) u16 {
        l.* = r;
        return self.pc +% 1;
    }

    // pub fn loadR16N16(l: []u8, r: u16) void {
    //     @typ
    // }

    // pub fn loadAddrVal(self: *CPU, addr: *u16, val: u16) void {
    //     // const blah = &self.regs.get_af();
    //     blah.* = ;
    // }

    pub fn push(self: *CPU, value: u16) u16 {
        self.sp -%= 1;
        self.bus.memory[self.sp] = @truncate(value & 0x00FF);
        self.sp -%= 1;
        self.bus.memory[self.sp] = @truncate((value & 0xFF00) >> 8);
        return self.pc +% 1;
    }

    pub fn pop(self: *CPU) u16 {
        const lsb = self.bus.readByte(self.sp);
        self.sp +%= 1;
        const msb = self.bus.readByte(self.sp);
        self.sp +%= 1;
        return (@as(u16, lsb) << 8) | msb;
    }

    pub fn add(self: *CPU, value: u8) u16 {
        const sum, self.regs.f.carry = @addWithOverflow(self.regs.a, value);
        self.regs.f.zero = @intFromBool(sum == 0);
        self.regs.f.subtract = 0;
        self.regs.f.half_carry = @intFromBool((self.regs.a & 0xF) + (value & 0xF) > 0xF);
        self.regs.a = sum;
        return self.pc +% 1;
    }

    pub fn jumpAbsolute(self: *CPU, jump_cond: bool) u16 {
        if (jump_cond) {
            const least_significant_byte: u16 = @as(u16, self.bus.readByte(self.pc + 1));
            const most_significant_byte: u16 = @as(u16, self.bus.readByte(self.pc + 2));
            return (most_significant_byte << 8) | (least_significant_byte);
        } else {
            return self.pc +% 3;
        }
    }

    pub fn jumpRelative(self: *CPU, jump_cond: bool) u16 {
        if (jump_cond) {
            const offset: u8 = self.bus.readByte(self.pc + 1);
            if (offset >> 7 == 1) return self.pc + 1 - @as(u16, offset & 0b01111111) else return self.pc + 1 + @as(u16, offset);
        } else {
            return self.pc +% 2;
        }
    }
};

const MemoryBus = struct {
    memory: [65536]u8,

    pub fn readByte(self: *MemoryBus, address: u16) u8 {
        return self.memory[address];
    }
};

const test_register = Registers{
    .a = 0b10101010,
    .b = 0b10101011,
    .c = 0b10100010,
    .d = 0b10001010,
    .e = 0b11101010,
    .f = FlagsRegister{ .zero = 1, .subtract = 0, .half_carry = 1, .carry = 0 },
    .h = 0b10111010,
    .l = 0b10101000,
};
var cpu = CPU{
    .regs = test_register,
    .pc = 0,
    .sp = 65535,
    .bus = MemoryBus{ .memory = [_]u8{ 0xCA, 0x05, 0x00, 0x05 } ** 0x4000 },
};

test "CPU.add register a value" {
    _ = cpu.add(0b00000001);
    try testing.expect(cpu.regs.a == 0b10101011);
}
test "CPU.add zero flag = 1" {
    cpu.regs = test_register;
    _ = cpu.add(0b01010110);
    try testing.expect(cpu.regs.f.zero == 1);
}
test "CPU.add zero flag = 0" {
    cpu.regs = test_register;
    _ = cpu.add(0b00000001);
    try testing.expect(cpu.regs.f.zero == 0);
}
test "CPU.add subtract flag = 0" {
    cpu.regs = test_register;
    _ = cpu.add(0b00000001);
    try testing.expect(cpu.regs.f.subtract == 0);
}
test "CPU.add carry flag = 1" {
    cpu.regs = test_register;
    _ = cpu.add(0b01010111);
    try testing.expect(cpu.regs.f.carry == 1);
}
test "CPU.add carry flag = 0" {
    cpu.regs = test_register;
    _ = cpu.add(0b00000001);
    try testing.expect(cpu.regs.f.carry == 0);
}
test "CPU.add half carry flag = 1" {
    cpu.regs = test_register;
    _ = cpu.add(0b00000110);
    try testing.expect(cpu.regs.f.half_carry == 1);
}
test "CPU.add half carry flag = 0" {
    cpu.regs = test_register;
    _ = cpu.add(0b00000001);
    try testing.expect(cpu.regs.f.half_carry == 0);
}

test "CPU.jumpAbsolute 0xCA=JP_Z_a16 jumps when zero flag = 1" {
    cpu.regs.f.zero = 1;
    cpu.step();
    try testing.expect(cpu.pc == 5);
}
test "CPU.jumpAbsolute 0xCA=JP_Z_a16 does not jump when zero flag = 0" {
    cpu.regs.f.zero = 0;
    cpu.pc = 0;
    cpu.step();
    try testing.expect(cpu.pc == 3);
}
test "CPU.jumpAbsolute 0xC2=JP_NZ_a16 jumps when zero flag = 0" {
    cpu.regs.f.zero = 0;
    cpu.pc = 0;
    cpu.bus.memory[0] = 0xC2;
    cpu.step();
    try testing.expect(cpu.pc == 5);
}
test "CPU.jumpAbsolute 0xC2=JP_NZ_a16 does not jump when zero flag = 1" {
    cpu.regs.f.zero = 1;
    cpu.pc = 0;
    cpu.bus.memory[0] = 0xC2;
    cpu.step();
    try testing.expect(cpu.pc == 3);
}
test "CPU.jumpAbsolute 0xDA=JP_C_a16 jumps when carry flag = 1" {
    cpu.regs.f.carry = 1;
    cpu.pc = 0;
    cpu.bus.memory[0] = 0xDA;
    cpu.step();
    try testing.expect(cpu.pc == 5);
}
test "CPU.jumpAbsolute 0xDA=JP_C_a16 does not jump when carry flag = 0" {
    cpu.regs.f.carry = 0;
    cpu.pc = 0;
    cpu.bus.memory[0] = 0xDA;
    cpu.step();
    try testing.expect(cpu.pc == 3);
}
test "CPU.jumpAbsolute 0xD2=JP_NC_a16 jumps when carry flag = 0" {
    cpu.regs.f.carry = 0;
    cpu.pc = 0;
    cpu.bus.memory[0] = 0xD2;
    cpu.step();
    try testing.expect(cpu.pc == 5);
}
test "CPU.jumpAbsolute 0xD2=JP_NC_a16 does not jump when carry flag = 1" {
    cpu.regs.f.carry = 1;
    cpu.pc = 0;
    cpu.bus.memory[0] = 0xD2;
    cpu.step();
    try testing.expect(cpu.pc == 3);
}
test "CPU.jumpAbsolute 0xC3=JP_a16 jumps when all flags are 0" {
    cpu.regs.f.zero, cpu.regs.f.subtract, cpu.regs.f.carry, cpu.regs.f.half_carry = .{ 0, 0, 0, 0 };
    cpu.pc = 0;
    cpu.bus.memory[0] = 0xC3;
    cpu.step();
    try testing.expect(cpu.pc == 5);
}
test "CPU.jumpAbsolute 0xC3=JP_a16 always jumps when all flags are 1" {
    cpu.regs.f.zero, cpu.regs.f.subtract, cpu.regs.f.carry, cpu.regs.f.half_carry = .{ 1, 1, 1, 1 };
    cpu.pc = 0;
    cpu.bus.memory[0] = 0xC3;
    cpu.step();
    try testing.expect(cpu.pc == 5);
}
test "CPU.jumpRelative 0x18=JR_e8 always jumps when all flags are 1" {
    cpu.regs.f.zero, cpu.regs.f.subtract, cpu.regs.f.carry, cpu.regs.f.half_carry = .{ 1, 1, 1, 1 };
    cpu.pc = 0;
    cpu.bus.memory[0] = 0x18;
    cpu.bus.memory[1] = 0x01;
    cpu.step();
    try testing.expect(cpu.pc == 2);
}
test "CPU.jumpRelative 0x18=JR_e8 always jumps when all flags are 0" {
    cpu.regs.f.zero, cpu.regs.f.subtract, cpu.regs.f.carry, cpu.regs.f.half_carry = .{ 0, 0, 0, 0 };
    cpu.pc = 0;
    cpu.bus.memory[0] = 0x18;
    cpu.bus.memory[1] = 0b10000001;
    cpu.step();
    try testing.expect(cpu.pc == 0);
}
test "CPU.jumpRelative 0x20=JR_NZ_e8 jumps when zero flag = 0" {
    cpu.regs.f.zero = 0;
    cpu.pc = 0;
    cpu.bus.memory[0] = 0x20;
    cpu.bus.memory[1] = 0b00000010;
    cpu.step();
    try testing.expect(cpu.pc == 3);
}
test "CPU.jumpRelative 0x20=JR_NZ_e8 does not jump zero flag = 1" {
    cpu.regs.f.zero = 1;
    cpu.pc = 0;
    cpu.bus.memory[0] = 0x20;
    cpu.bus.memory[1] = 0b10000001;
    cpu.step();
    try testing.expect(cpu.pc == 2);
}
test "CPU.jumpRelative 0x28=JR_Z_e8 jumps when zero flag = 1" {
    cpu.regs.f.zero = 1;
    cpu.pc = 0;
    cpu.bus.memory[0] = 0x28;
    cpu.bus.memory[1] = 0b00000010;
    cpu.step();
    try testing.expect(cpu.pc == 3);
}
test "CPU.jumpRelative 0x28=JR_Z_e8 does not jump zero flag = 0" {
    cpu.regs.f.zero = 0;
    cpu.pc = 0;
    cpu.bus.memory[0] = 0x28;
    cpu.bus.memory[1] = 0b10000001;
    cpu.step();
    try testing.expect(cpu.pc == 2);
}
test "CPU.jumpRelative 0x30=JR_NC_e8 jumps when carry flag = 0" {
    cpu.regs.f.carry = 0;
    cpu.pc = 0;
    cpu.bus.memory[0] = 0x30;
    cpu.bus.memory[1] = 0b00000010;
    cpu.step();
    try testing.expect(cpu.pc == 3);
    // print("{}", .{@typeInfo()});
}
test "CPU.jumpRelative 0x30=JR_NC_e8 does not jump carry flag = 1" {
    cpu.regs.f.carry = 1;
    cpu.pc = 0;
    cpu.bus.memory[0] = 0x30;
    cpu.bus.memory[1] = 0b10000001;
    cpu.step();
    try testing.expect(cpu.pc == 2);
}
test "CPU.jumpRelative 0x38=JR_C_e8 jumps when carry flag = 1" {
    cpu.regs.f.carry = 1;
    cpu.pc = 0;
    cpu.bus.memory[0] = 0x38;
    cpu.bus.memory[1] = 0b10000001;
    cpu.step();
    try testing.expect(cpu.pc == 0);
}
test "CPU.jumpRelative 0x38=JR_C_e8 does not jump carry flag = 0" {
    cpu.regs.f.carry = 0;
    cpu.pc = 0;
    cpu.bus.memory[0] = 0x38;
    cpu.bus.memory[1] = 0b10000001;
    cpu.step();
    try testing.expect(cpu.pc == 2);
}

test "CPU.loadR8N8 r8r8" {
    cpu.regs.a = 0;
    cpu.regs.b = 29;
    _ = cpu.loadR8N8(&cpu.regs.a, cpu.regs.b);
    try testing.expect(cpu.regs.a == cpu.regs.b);
}
test "CPU.loadR8N8 r8n8" {
    cpu.regs.a = 0;
    _ = cpu.loadR8N8(&cpu.regs.a, 13);
    try testing.expect(cpu.regs.a == 13);
}
test "CPU.loadR8N8 r8HLA" {
    cpu.regs.a = 0;
    cpu.regs.set_hl(0x001D);
    cpu.bus.memory[0x001D] = 23;
    _ = cpu.loadR8N8(&cpu.regs.a, cpu.bus.readByte(cpu.regs.get_hl()));
    try testing.expect(cpu.regs.a == 23);
}
test "CPU.loadR8N8 HLAr8" {
    cpu.regs.set_hl(0x2B);
    _ = cpu.loadR8N8(&cpu.bus.memory[cpu.regs.get_hl()], 15);
    try testing.expect(cpu.bus.readByte(0x2B) == 15);
}

test "CPU.push AF" {
    cpu.pc = 0;
    cpu.sp = 65535;
    cpu.regs.set_af(0x1234);
    cpu.bus.memory[0] = 0xF5;
    cpu.step();
    try testing.expect(cpu.bus.readByte(cpu.sp + 1) == 0x34);
    try testing.expect(cpu.bus.readByte(cpu.sp) == 0x10); // tricky, this is 10 because f register drops lower 4 bits
}
test "CPU.push AF no lower 4 bits set in f" {
    cpu.pc = 0;
    cpu.sp = 65535;
    cpu.regs.set_af(0xD034);
    cpu.bus.memory[0] = 0xF5;
    cpu.step();
    try testing.expect(cpu.bus.readByte(cpu.sp + 1) == 0x34);
    try testing.expect(cpu.bus.readByte(cpu.sp) == 0xD0); // tricky, this is 10 because f register drops lower 4 bits
}

test "CPU.POP_BC" {
    cpu.pc = 0;
    cpu.sp = 65533;
    cpu.bus.memory[65534] = 0xF2;
    cpu.bus.memory[65533] = 0x53;
    cpu.bus.memory[0] = 0xC1;
    cpu.step();
    try testing.expect(cpu.regs.get_bc() == 0x53F2);
}
test "CPU.POP_DE" {
    cpu.pc = 0;
    cpu.sp = 65533;
    cpu.bus.memory[65534] = 0x5D;
    cpu.bus.memory[65533] = 0x6C;
    cpu.bus.memory[0] = 0xD1;
    cpu.step();
    try testing.expect(cpu.regs.get_de() == 0x6C5D);
}
test "CPU.POP_HL" {
    cpu.pc = 0;
    cpu.sp = 65533;
    cpu.bus.memory[65534] = 0x27;
    cpu.bus.memory[65533] = 0xCD;
    cpu.bus.memory[0] = 0xE1;
    cpu.step();
    try testing.expect(cpu.regs.get_hl() == 0xCD27);
}
test "CPU.POP_AF" {
    cpu.pc = 0;
    cpu.sp = 65533;
    cpu.bus.memory[65534] = 0xF2;
    cpu.bus.memory[65533] = 0x53;
    cpu.bus.memory[0] = 0xF1;
    cpu.step();
    try testing.expect(cpu.regs.get_af() == 0x50F2);
}
