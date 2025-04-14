pub const Instruction = enum {
    NOP,
    LD_BC_n16,
    LD_BCA_A,
    INC_BC,
    INC_B,
    DEC_B,
    LD_B_n8,
    RLCA,
    LD_a16_SP,
    ADD_HL_BC,
    DEC_BC,
    LD_A_BC,
    INC_C,
    DEC_C,
    LD_C_n8,
    RRCA,
    STOP_n8,
    LD_DE_n16,
    LD_DEA_A,
    INC_DE,
    INC_D,
    DEC_D,
    LD_D_n8,
    RLA,
    JR_e8,
    ADD_HL_DE,
    LD_A_DE,
    DEC_DE,
    INC_E,
    DEC_E,
    LD_E_n8,
    RRA,
    JR_NZ_e8,
    LD_HL_n16,
    LD_HLI_A,
    INC_HL,
    INC_H,
    DEC_H,
    LD_H_n8,
    DAA,
    JR_Z_e8,
    ADD_HL_HL,
    LD_A_HLI,
    DEC_HL,
    INC_L,
    DEC_L,
    LD_L_n8,
    CPL,
    JR_NC_e8,
    LD_SP_n16,
    LD_HLD_A,
    INC_SP,
    INC_HLA,
    DEC_HLA,
    LD_HLA_n8,
    SCF,
    JR_C_e8,
    ADD_HL_SP,
    LD_A_HLD,
    DEC_SP,
    INC_A,
    DEC_A,
    LD_A_n8,
    CCF,
    LD_B_B,
    LD_B_C,
    LD_B_D,
    LD_B_E,
    LD_B_H,
    LD_B_L,
    LD_B_HLA,
    LD_B_A,
    LD_C_B,
    LD_C_C,
    LD_C_D,
    LD_C_E,
    LD_C_H,
    LD_C_L,
    LD_C_HLA,
    LD_C_A,
    LD_D_B,
    LD_D_C,
    LD_D_D,
    LD_D_E,
    LD_D_H,
    LD_D_L,
    LD_D_HLA,
    LD_D_A,
    LD_E_B,
    LD_E_C,
    LD_E_D,
    LD_E_E,
    LD_E_H,
    LD_E_L,
    LD_E_HLA,
    LD_E_A,
    LD_H_B,
    LD_H_C,
    LD_H_D,
    LD_H_E,
    LD_H_H,
    LD_H_L,
    LD_H_HLA,
    LD_H_A,
    LD_L_B,
    LD_L_C,
    LD_L_D,
    LD_L_E,
    LD_L_H,
    LD_L_L,
    LD_L_HLA,
    LD_L_A,
    LD_HLA_B,
    LD_HLA_C,
    LD_HLA_D,
    LD_HLA_E,
    LD_HLA_H,
    LD_HLA_L,
    HALT,
    LD_HLA_A,
    LD_A_B,
    LD_A_C,
    LD_A_D,
    LD_A_E,
    LD_A_H,
    LD_A_L,
    LD_A_HLA,
    LD_A_A,
    ADD_B,
    ADD_C,
    ADD_D,
    ADD_E,
    ADD_H,
    ADD_L,
    ADD_HLA,
    ADD_A,
    ADC_B,
    ADC_C,
    ADC_D,
    ADC_E,
    ADC_H,
    ADC_L,
    ADC_HLA,
    ADC_A,
    SUB_B,
    SUB_C,
    SUB_D,
    SUB_E,
    SUB_H,
    SUB_L,
    SUB_HLA,
    SUB_A,
    SBC_B,
    SBC_C,
    SBC_D,
    SBC_E,
    SBC_H,
    SBC_L,
    SBC_HLA,
    SBC_A,
    AND_B,
    AND_C,
    AND_D,
    AND_E,
    AND_H,
    AND_L,
    AND_HLA,
    AND_A,
    XOR_B,
    XOR_C,
    XOR_D,
    XOR_E,
    XOR_H,
    XOR_L,
    XOR_HLA,
    XOR_A,
    OR_B,
    OR_C,
    OR_D,
    OR_E,
    OR_H,
    OR_L,
    OR_HLA,
    OR_A,
    CP_B,
    CP_C,
    CP_D,
    CP_E,
    CP_H,
    CP_L,
    CP_HLA,
    CP_A,
    RET_NZ,
    POP_BC,
    JP_NZ_a16,
    JP_a16,
    CALL_NZ_a16,
    PUSH_BC,
    ADD_A_n8,
    RST_00,
    RET_Z,
    RET,
    JP_Z_a16,
    PREFIX,
    CALL_Z_a16,
    CALL_a16,
    ADC_A_n8,
    RST_08,
    RET_NC,
    POP_DE,
    JP_NC_a16,
    CALL_NC_a16,
    PUSH_DE,
    SUB_A_n8,
    RST_10,
    RET_C,
    RETI,
    JP_C_a16,
    CALL_C_a16,
    SBC_A_n8,
    RST_18,
    LDH_a8p_A,
    POP_HL,
    LDH_CP_A,
    PUSH_HL,
    AND_A_n8,
    RST_20,
    ADD_SP_e8,
    JP_HL,
    LD_a16p_A,
    XOR_A_n8,
    RST_28,
    LDH_A_a8p,
    POP_AF,
    LDH_A_CP,
    DI,
    PUSH_AF,
    OR_A_n8,
    RST_30,
    LD_HL_SPPLUSe8,
    LD_SP_HL,
    LD_A_a16p,
    EI,
    CP_A_n8,
    RST_38,
};

pub fn instFromByte(byte: u8) Instruction {
    return switch (byte) {
        0x00 => Instruction.NOP,
        0x01 => Instruction.LD_BC_n16,
        0x02 => Instruction.LD_BCA_A,
        0x03 => Instruction.INC_BC,
        0x04 => Instruction.INC_B,
        0x05 => Instruction.DEC_B,
        0x06 => Instruction.LD_B_n8,
        0x07 => Instruction.RLCA,
        0x08 => Instruction.LD_a16_SP,
        0x09 => Instruction.ADD_HL_BC,
        0x0A => Instruction.DEC_BC,
        0x0B => Instruction.LD_A_BC,
        0x0C => Instruction.INC_C,
        0x0D => Instruction.DEC_C,
        0x0E => Instruction.LD_C_n8,
        0x0F => Instruction.RRCA,
        0x10 => Instruction.STOP_n8,
        0x11 => Instruction.LD_DE_n16,
        0x12 => Instruction.LD_DEA_A,
        0x13 => Instruction.INC_DE,
        0x14 => Instruction.INC_D,
        0x15 => Instruction.DEC_D,
        0x16 => Instruction.LD_D_n8,
        0x17 => Instruction.RLA,
        0x18 => Instruction.JR_e8,
        0x19 => Instruction.ADD_HL_DE,
        0x1A => Instruction.LD_A_DE,
        0x1B => Instruction.DEC_DE,
        0x1C => Instruction.INC_E,
        0x1D => Instruction.DEC_E,
        0x1E => Instruction.LD_E_n8,
        0x1F => Instruction.RRA,
        0x20 => Instruction.JR_NZ_e8,
        0x21 => Instruction.LD_HL_n16,
        0x22 => Instruction.LD_HLI_A,
        0x23 => Instruction.INC_HL,
        0x24 => Instruction.INC_H,
        0x25 => Instruction.DEC_H,
        0x26 => Instruction.LD_H_n8,
        0x27 => Instruction.DAA,
        0x28 => Instruction.JR_Z_e8,
        0x29 => Instruction.ADD_HL_HL,
        0x2A => Instruction.LD_A_HLI,
        0x2B => Instruction.DEC_HL,
        0x2C => Instruction.INC_L,
        0x2D => Instruction.DEC_L,
        0x2E => Instruction.LD_L_n8,
        0x2F => Instruction.CPL,
        0x30 => Instruction.JR_NC_e8,
        0x31 => Instruction.LD_SP_n16,
        0x32 => Instruction.LD_HLD_A,
        0x33 => Instruction.INC_SP,
        0x34 => Instruction.INC_HLA,
        0x35 => Instruction.DEC_HLA,
        0x36 => Instruction.LD_HLA_n8,
        0x37 => Instruction.SCF,
        0x38 => Instruction.JR_C_e8,
        0x39 => Instruction.ADD_HL_SP,
        0x3A => Instruction.LD_A_HLD,
        0x3B => Instruction.DEC_SP,
        0x3C => Instruction.INC_A,
        0x3D => Instruction.DEC_A,
        0x3E => Instruction.LD_A_n8,
        0x3F => Instruction.CCF,
        0x40 => Instruction.LD_B_B,
        0x41 => Instruction.LD_B_C,
        0x42 => Instruction.LD_B_D,
        0x43 => Instruction.LD_B_E,
        0x44 => Instruction.LD_B_H,
        0x45 => Instruction.LD_B_L,
        0x46 => Instruction.LD_B_HLA,
        0x47 => Instruction.LD_B_A,
        0x48 => Instruction.LD_C_B,
        0x49 => Instruction.LD_C_C,
        0x4A => Instruction.LD_C_D,
        0x4B => Instruction.LD_C_E,
        0x4C => Instruction.LD_C_H,
        0x4D => Instruction.LD_C_L,
        0x4E => Instruction.LD_C_HLA,
        0x4F => Instruction.LD_C_A,
        0x50 => Instruction.LD_D_B,
        0x51 => Instruction.LD_D_C,
        0x52 => Instruction.LD_D_D,
        0x53 => Instruction.LD_D_E,
        0x54 => Instruction.LD_D_H,
        0x55 => Instruction.LD_D_L,
        0x56 => Instruction.LD_D_HLA,
        0x57 => Instruction.LD_D_A,
        0x58 => Instruction.LD_E_B,
        0x59 => Instruction.LD_E_C,
        0x5A => Instruction.LD_E_D,
        0x5B => Instruction.LD_E_E,
        0x5C => Instruction.LD_E_H,
        0x5D => Instruction.LD_E_L,
        0x5E => Instruction.LD_E_HLA,
        0x5F => Instruction.LD_E_A,
        0x60 => Instruction.LD_H_B,
        0x61 => Instruction.LD_H_C,
        0x62 => Instruction.LD_H_D,
        0x63 => Instruction.LD_H_E,
        0x64 => Instruction.LD_H_H,
        0x65 => Instruction.LD_H_L,
        0x66 => Instruction.LD_H_HLA,
        0x67 => Instruction.LD_H_A,
        0x68 => Instruction.LD_L_B,
        0x69 => Instruction.LD_L_C,
        0x6A => Instruction.LD_L_D,
        0x6B => Instruction.LD_L_E,
        0x6C => Instruction.LD_L_H,
        0x6D => Instruction.LD_L_L,
        0x6E => Instruction.LD_L_HLA,
        0x6F => Instruction.LD_L_A,
        0x70 => Instruction.LD_HLA_B,
        0x71 => Instruction.LD_HLA_C,
        0x72 => Instruction.LD_HLA_D,
        0x73 => Instruction.LD_HLA_E,
        0x74 => Instruction.LD_HLA_H,
        0x75 => Instruction.LD_HLA_L,
        0x76 => Instruction.HALT,
        0x77 => Instruction.LD_HLA_A,
        0x78 => Instruction.LD_A_B,
        0x79 => Instruction.LD_A_C,
        0x7A => Instruction.LD_A_D,
        0x7B => Instruction.LD_A_E,
        0x7C => Instruction.LD_A_H,
        0x7D => Instruction.LD_A_L,
        0x7E => Instruction.LD_A_HLA,
        0x7F => Instruction.LD_A_A,
        0x80 => Instruction.ADD_B,
        0x81 => Instruction.ADD_C,
        0x82 => Instruction.ADD_D,
        0x83 => Instruction.ADD_E,
        0x84 => Instruction.ADD_H,
        0x85 => Instruction.ADD_L,
        0x86 => Instruction.ADD_HLA,
        0x87 => Instruction.ADD_A,
        0x88 => Instruction.ADC_B,
        0x89 => Instruction.ADC_C,
        0x8A => Instruction.ADC_D,
        0x8B => Instruction.ADC_E,
        0x8C => Instruction.ADC_H,
        0x8D => Instruction.ADC_L,
        0x8E => Instruction.ADC_HLA,
        0x8F => Instruction.ADC_A,
        0x90 => Instruction.SUB_B,
        0x91 => Instruction.SUB_C,
        0x92 => Instruction.SUB_D,
        0x93 => Instruction.SUB_E,
        0x94 => Instruction.SUB_H,
        0x95 => Instruction.SUB_L,
        0x96 => Instruction.SUB_HLA,
        0x97 => Instruction.SUB_A,
        0x98 => Instruction.SBC_B,
        0x99 => Instruction.SBC_C,
        0x9A => Instruction.SBC_D,
        0x9B => Instruction.SBC_E,
        0x9C => Instruction.SBC_H,
        0x9D => Instruction.SBC_L,
        0x9E => Instruction.SBC_HLA,
        0x9F => Instruction.SBC_A,
        0xA0 => Instruction.AND_B,
        0xA1 => Instruction.AND_C,
        0xA2 => Instruction.AND_D,
        0xA3 => Instruction.AND_E,
        0xA4 => Instruction.AND_H,
        0xA5 => Instruction.AND_L,
        0xA6 => Instruction.AND_HLA,
        0xA7 => Instruction.AND_A,
        0xA8 => Instruction.XOR_B,
        0xA9 => Instruction.XOR_C,
        0xAA => Instruction.XOR_D,
        0xAB => Instruction.XOR_E,
        0xAC => Instruction.XOR_H,
        0xAD => Instruction.XOR_L,
        0xAE => Instruction.XOR_HLA,
        0xAF => Instruction.XOR_A,
        0xB0 => Instruction.OR_B,
        0xB1 => Instruction.OR_C,
        0xB2 => Instruction.OR_D,
        0xB3 => Instruction.OR_E,
        0xB4 => Instruction.OR_H,
        0xB5 => Instruction.OR_L,
        0xB6 => Instruction.OR_HLA,
        0xB7 => Instruction.OR_A,
        0xB8 => Instruction.CP_B,
        0xB9 => Instruction.CP_C,
        0xBA => Instruction.CP_D,
        0xBB => Instruction.CP_E,
        0xBC => Instruction.CP_H,
        0xBD => Instruction.CP_L,
        0xBE => Instruction.CP_HLA,
        0xBF => Instruction.CP_A,
        0xC0 => Instruction.RET_NZ,
        0xC1 => Instruction.POP_BC,
        0xC2 => Instruction.JP_NZ_a16,
        0xC3 => Instruction.JP_a16,
        0xC4 => Instruction.CALL_NZ_a16,
        0xC5 => Instruction.PUSH_BC,
        0xC6 => Instruction.ADD_A_n8,
        0xC7 => Instruction.RST_00,
        0xC8 => Instruction.RET_Z,
        0xC9 => Instruction.RET,
        0xCA => Instruction.JP_Z_a16,
        0xCB => Instruction.PREFIX,
        0xCC => Instruction.CALL_Z_a16,
        0xCD => Instruction.CALL_a16,
        0xCE => Instruction.ADC_A_n8,
        0xCF => Instruction.RST_08,
        0xD0 => Instruction.RET_NC,
        0xD1 => Instruction.POP_DE,
        0xD2 => Instruction.JP_NC_a16,
        0xD4 => Instruction.CALL_NC_a16,
        0xD5 => Instruction.PUSH_DE,
        0xD6 => Instruction.SUB_A_n8,
        0xD7 => Instruction.RST_10,
        0xD8 => Instruction.RET_C,
        0xD9 => Instruction.RETI,
        0xDA => Instruction.JP_C_a16,
        0xDC => Instruction.CALL_C_a16,
        0xDE => Instruction.SBC_A_n8,
        0xDF => Instruction.RST_18,
        0xE0 => Instruction.LDH_a8p_A,
        0xE1 => Instruction.POP_HL,
        0xE2 => Instruction.LDH_CP_A,
        0xE5 => Instruction.PUSH_HL,
        0xE6 => Instruction.AND_A_n8,
        0xE7 => Instruction.RST_20,
        0xE8 => Instruction.ADD_SP_e8,
        0xE9 => Instruction.JP_HL,
        0xEA => Instruction.LD_a16p_A,
        0xEE => Instruction.XOR_A_n8,
        0xEF => Instruction.RST_28,
        0xF0 => Instruction.LDH_A_a8p,
        0xF1 => Instruction.POP_AF,
        0xF2 => Instruction.LDH_A_CP,
        0xF3 => Instruction.DI,
        0xF5 => Instruction.PUSH_AF,
        0xF6 => Instruction.OR_A_n8,
        0xF7 => Instruction.RST_30,
        0xF8 => Instruction.LD_HL_SPPLUSe8,
        0xF9 => Instruction.LD_SP_HL,
        0xFA => Instruction.LD_A_a16p,
        0xFB => Instruction.EI,
        0xFE => Instruction.CP_A_n8,
        0xFF => Instruction.RST_38,
        else => unreachable,
    };
}

pub const PrefixInstruction = enum {
    RLC_B,
    RLC_C,
    RLC_D,
    RLC_E,
    RLC_H,
    RLC_L,
    RLC_HLA,
    RLC_A,
    RRC_B,
    RRC_C,
    RRC_D,
    RRC_E,
    RRC_H,
    RRC_L,
    RRC_HLA,
    RRC_A,
    RL_B,
    RL_C,
    RL_D,
    RL_E,
    RL_H,
    RL_L,
    RL_HLA,
    RL_A,
    RR_B,
    RR_C,
    RR_D,
    RR_E,
    RR_H,
    RR_L,
    RR_HLA,
    RR_A,
    SLA_B,
    SLA_C,
    SLA_D,
    SLA_E,
    SLA_H,
    SLA_L,
    SLA_HLA,
    SLA_A,
    SRA_B,
    SRA_C,
    SRA_D,
    SRA_E,
    SRA_H,
    SRA_L,
    SRA_HLA,
    SRA_A,
    SWAP_B,
    SWAP_C,
    SWAP_D,
    SWAP_E,
    SWAP_H,
    SWAP_L,
    SWAP_HLA,
    SWAP_A,
    SRL_B,
    SRL_C,
    SRL_D,
    SRL_E,
    SRL_H,
    SRL_L,
    SRL_HLA,
    SRL_A,
    BIT_0_B,
    BIT_0_C,
    BIT_0_D,
    BIT_0_E,
    BIT_0_H,
    BIT_0_L,
    BIT_0_HLA,
    BIT_0_A,
    BIT_1_B,
    BIT_1_C,
    BIT_1_D,
    BIT_1_E,
    BIT_1_H,
    BIT_1_L,
    BIT_1_HLA,
    BIT_1_A,
    BIT_2_B,
    BIT_2_C,
    BIT_2_D,
    BIT_2_E,
    BIT_2_H,
    BIT_2_L,
    BIT_2_HLA,
    BIT_2_A,
    BIT_3_B,
    BIT_3_C,
    BIT_3_D,
    BIT_3_E,
    BIT_3_H,
    BIT_3_L,
    BIT_3_HLA,
    BIT_3_A,
    BIT_4_B,
    BIT_4_C,
    BIT_4_D,
    BIT_4_E,
    BIT_4_H,
    BIT_4_L,
    BIT_4_HLA,
    BIT_4_A,
    BIT_5_B,
    BIT_5_C,
    BIT_5_D,
    BIT_5_E,
    BIT_5_H,
    BIT_5_L,
    BIT_5_HLA,
    BIT_5_A,
    BIT_6_B,
    BIT_6_C,
    BIT_6_D,
    BIT_6_E,
    BIT_6_H,
    BIT_6_L,
    BIT_6_HLA,
    BIT_6_A,
    BIT_7_B,
    BIT_7_C,
    BIT_7_D,
    BIT_7_E,
    BIT_7_H,
    BIT_7_L,
    BIT_7_HLA,
    BIT_7_A,
    RES_0_B,
    RES_0_C,
    RES_0_D,
    RES_0_E,
    RES_0_H,
    RES_0_L,
    RES_0_HLA,
    RES_0_A,
    RES_1_B,
    RES_1_C,
    RES_1_D,
    RES_1_E,
    RES_1_H,
    RES_1_L,
    RES_1_HLA,
    RES_1_A,
    RES_2_B,
    RES_2_C,
    RES_2_D,
    RES_2_E,
    RES_2_H,
    RES_2_L,
    RES_2_HLA,
    RES_2_A,
    RES_3_B,
    RES_3_C,
    RES_3_D,
    RES_3_E,
    RES_3_H,
    RES_3_L,
    RES_3_HLA,
    RES_3_A,
    RES_4_B,
    RES_4_C,
    RES_4_D,
    RES_4_E,
    RES_4_H,
    RES_4_L,
    RES_4_HLA,
    RES_4_A,
    RES_5_B,
    RES_5_C,
    RES_5_D,
    RES_5_E,
    RES_5_H,
    RES_5_L,
    RES_5_HLA,
    RES_5_A,
    RES_6_B,
    RES_6_C,
    RES_6_D,
    RES_6_E,
    RES_6_H,
    RES_6_L,
    RES_6_HLA,
    RES_6_A,
    RES_7_B,
    RES_7_C,
    RES_7_D,
    RES_7_E,
    RES_7_H,
    RES_7_L,
    RES_7_HLA,
    RES_7_A,
    SET_0_B,
    SET_0_C,
    SET_0_D,
    SET_0_E,
    SET_0_H,
    SET_0_L,
    SET_0_HLA,
    SET_0_A,
    SET_1_B,
    SET_1_C,
    SET_1_D,
    SET_1_E,
    SET_1_H,
    SET_1_L,
    SET_1_HLA,
    SET_1_A,
    SET_2_B,
    SET_2_C,
    SET_2_D,
    SET_2_E,
    SET_2_H,
    SET_2_L,
    SET_2_HLA,
    SET_2_A,
    SET_3_B,
    SET_3_C,
    SET_3_D,
    SET_3_E,
    SET_3_H,
    SET_3_L,
    SET_3_HLA,
    SET_3_A,
    SET_4_B,
    SET_4_C,
    SET_4_D,
    SET_4_E,
    SET_4_H,
    SET_4_L,
    SET_4_HLA,
    SET_4_A,
    SET_5_B,
    SET_5_C,
    SET_5_D,
    SET_5_E,
    SET_5_H,
    SET_5_L,
    SET_5_HLA,
    SET_5_A,
    SET_6_B,
    SET_6_C,
    SET_6_D,
    SET_6_E,
    SET_6_H,
    SET_6_L,
    SET_6_HLA,
    SET_6_A,
    SET_7_B,
    SET_7_C,
    SET_7_D,
    SET_7_E,
    SET_7_H,
    SET_7_L,
    SET_7_HLA,
    SET_7_A,
};

pub fn prefixInstFromByte(byte: u8) PrefixInstruction {
    return switch (byte) {
        0x00 => PrefixInstruction.RLC_B,
        0x01 => PrefixInstruction.RLC_C,
        0x02 => PrefixInstruction.RLC_D,
        0x03 => PrefixInstruction.RLC_E,
        0x04 => PrefixInstruction.RLC_H,
        0x05 => PrefixInstruction.RLC_L,
        0x06 => PrefixInstruction.RLC_HLA,
        0x07 => PrefixInstruction.RLC_A,
        0x08 => PrefixInstruction.RRC_B,
        0x09 => PrefixInstruction.RRC_C,
        0x0A => PrefixInstruction.RRC_D,
        0x0B => PrefixInstruction.RRC_E,
        0x0C => PrefixInstruction.RRC_H,
        0x0D => PrefixInstruction.RRC_L,
        0x0E => PrefixInstruction.RRC_HLA,
        0x0F => PrefixInstruction.RRC_A,
        0x10 => PrefixInstruction.RL_B,
        0x11 => PrefixInstruction.RL_C,
        0x12 => PrefixInstruction.RL_D,
        0x13 => PrefixInstruction.RL_E,
        0x14 => PrefixInstruction.RL_H,
        0x15 => PrefixInstruction.RL_L,
        0x16 => PrefixInstruction.RL_HLA,
        0x17 => PrefixInstruction.RL_A,
        0x18 => PrefixInstruction.RR_B,
        0x19 => PrefixInstruction.RR_C,
        0x1A => PrefixInstruction.RR_D,
        0x1B => PrefixInstruction.RR_E,
        0x1C => PrefixInstruction.RR_H,
        0x1D => PrefixInstruction.RR_L,
        0x1E => PrefixInstruction.RR_HLA,
        0x1F => PrefixInstruction.RR_A,
        0x20 => PrefixInstruction.SLA_B,
        0x21 => PrefixInstruction.SLA_C,
        0x22 => PrefixInstruction.SLA_D,
        0x23 => PrefixInstruction.SLA_E,
        0x24 => PrefixInstruction.SLA_H,
        0x25 => PrefixInstruction.SLA_L,
        0x26 => PrefixInstruction.SLA_HLA,
        0x27 => PrefixInstruction.SLA_A,
        0x28 => PrefixInstruction.SRA_B,
        0x29 => PrefixInstruction.SRA_C,
        0x2A => PrefixInstruction.SRA_D,
        0x2B => PrefixInstruction.SRA_E,
        0x2C => PrefixInstruction.SRA_H,
        0x2D => PrefixInstruction.SRA_L,
        0x2E => PrefixInstruction.SRA_HLA,
        0x2F => PrefixInstruction.SRA_A,
        0x30 => PrefixInstruction.SWAP_B,
        0x31 => PrefixInstruction.SWAP_C,
        0x32 => PrefixInstruction.SWAP_D,
        0x33 => PrefixInstruction.SWAP_E,
        0x34 => PrefixInstruction.SWAP_H,
        0x35 => PrefixInstruction.SWAP_L,
        0x36 => PrefixInstruction.SWAP_HLA,
        0x37 => PrefixInstruction.SWAP_A,
        0x38 => PrefixInstruction.SRL_B,
        0x39 => PrefixInstruction.SRL_C,
        0x3A => PrefixInstruction.SRL_D,
        0x3B => PrefixInstruction.SRL_E,
        0x3C => PrefixInstruction.SRL_H,
        0x3D => PrefixInstruction.SRL_L,
        0x3E => PrefixInstruction.SRL_HLA,
        0x3F => PrefixInstruction.SRL_A,
        0x40 => PrefixInstruction.BIT_0_B,
        0x41 => PrefixInstruction.BIT_0_C,
        0x42 => PrefixInstruction.BIT_0_D,
        0x43 => PrefixInstruction.BIT_0_E,
        0x44 => PrefixInstruction.BIT_0_H,
        0x45 => PrefixInstruction.BIT_0_L,
        0x46 => PrefixInstruction.BIT_0_HLA,
        0x47 => PrefixInstruction.BIT_0_A,
        0x48 => PrefixInstruction.BIT_1_B,
        0x49 => PrefixInstruction.BIT_1_C,
        0x4A => PrefixInstruction.BIT_1_D,
        0x4B => PrefixInstruction.BIT_1_E,
        0x4C => PrefixInstruction.BIT_1_H,
        0x4D => PrefixInstruction.BIT_1_L,
        0x4E => PrefixInstruction.BIT_1_HLA,
        0x4F => PrefixInstruction.BIT_1_A,
        0x50 => PrefixInstruction.BIT_2_B,
        0x51 => PrefixInstruction.BIT_2_C,
        0x52 => PrefixInstruction.BIT_2_D,
        0x53 => PrefixInstruction.BIT_2_E,
        0x54 => PrefixInstruction.BIT_2_H,
        0x55 => PrefixInstruction.BIT_2_L,
        0x56 => PrefixInstruction.BIT_2_HLA,
        0x57 => PrefixInstruction.BIT_2_A,
        0x58 => PrefixInstruction.BIT_3_B,
        0x59 => PrefixInstruction.BIT_3_C,
        0x5A => PrefixInstruction.BIT_3_D,
        0x5B => PrefixInstruction.BIT_3_E,
        0x5C => PrefixInstruction.BIT_3_H,
        0x5D => PrefixInstruction.BIT_3_L,
        0x5E => PrefixInstruction.BIT_3_HLA,
        0x5F => PrefixInstruction.BIT_3_A,
        0x60 => PrefixInstruction.BIT_4_B,
        0x61 => PrefixInstruction.BIT_4_C,
        0x62 => PrefixInstruction.BIT_4_D,
        0x63 => PrefixInstruction.BIT_4_E,
        0x64 => PrefixInstruction.BIT_4_H,
        0x65 => PrefixInstruction.BIT_4_L,
        0x66 => PrefixInstruction.BIT_4_HLA,
        0x67 => PrefixInstruction.BIT_4_A,
        0x68 => PrefixInstruction.BIT_5_B,
        0x69 => PrefixInstruction.BIT_5_C,
        0x6A => PrefixInstruction.BIT_5_D,
        0x6B => PrefixInstruction.BIT_5_E,
        0x6C => PrefixInstruction.BIT_5_H,
        0x6D => PrefixInstruction.BIT_5_L,
        0x6E => PrefixInstruction.BIT_5_HLA,
        0x6F => PrefixInstruction.BIT_5_A,
        0x70 => PrefixInstruction.BIT_6_B,
        0x71 => PrefixInstruction.BIT_6_C,
        0x72 => PrefixInstruction.BIT_6_D,
        0x73 => PrefixInstruction.BIT_6_E,
        0x74 => PrefixInstruction.BIT_6_H,
        0x75 => PrefixInstruction.BIT_6_L,
        0x76 => PrefixInstruction.BIT_6_HLA,
        0x77 => PrefixInstruction.BIT_6_A,
        0x78 => PrefixInstruction.BIT_7_B,
        0x79 => PrefixInstruction.BIT_7_C,
        0x7A => PrefixInstruction.BIT_7_D,
        0x7B => PrefixInstruction.BIT_7_E,
        0x7C => PrefixInstruction.BIT_7_H,
        0x7D => PrefixInstruction.BIT_7_L,
        0x7E => PrefixInstruction.BIT_7_HLA,
        0x7F => PrefixInstruction.BIT_7_A,
        0x80 => PrefixInstruction.RES_0_B,
        0x81 => PrefixInstruction.RES_0_C,
        0x82 => PrefixInstruction.RES_0_D,
        0x83 => PrefixInstruction.RES_0_E,
        0x84 => PrefixInstruction.RES_0_H,
        0x85 => PrefixInstruction.RES_0_L,
        0x86 => PrefixInstruction.RES_0_HLA,
        0x87 => PrefixInstruction.RES_0_A,
        0x88 => PrefixInstruction.RES_1_B,
        0x89 => PrefixInstruction.RES_1_C,
        0x8A => PrefixInstruction.RES_1_D,
        0x8B => PrefixInstruction.RES_1_E,
        0x8C => PrefixInstruction.RES_1_H,
        0x8D => PrefixInstruction.RES_1_L,
        0x8E => PrefixInstruction.RES_1_HLA,
        0x8F => PrefixInstruction.RES_1_A,
        0x90 => PrefixInstruction.RES_2_B,
        0x91 => PrefixInstruction.RES_2_C,
        0x92 => PrefixInstruction.RES_2_D,
        0x93 => PrefixInstruction.RES_2_E,
        0x94 => PrefixInstruction.RES_2_H,
        0x95 => PrefixInstruction.RES_2_L,
        0x96 => PrefixInstruction.RES_2_HLA,
        0x97 => PrefixInstruction.RES_2_A,
        0x98 => PrefixInstruction.RES_3_B,
        0x99 => PrefixInstruction.RES_3_C,
        0x9A => PrefixInstruction.RES_3_D,
        0x9B => PrefixInstruction.RES_3_E,
        0x9C => PrefixInstruction.RES_3_H,
        0x9D => PrefixInstruction.RES_3_L,
        0x9E => PrefixInstruction.RES_3_HLA,
        0x9F => PrefixInstruction.RES_3_A,
        0xA0 => PrefixInstruction.RES_4_B,
        0xA1 => PrefixInstruction.RES_4_C,
        0xA2 => PrefixInstruction.RES_4_D,
        0xA3 => PrefixInstruction.RES_4_E,
        0xA4 => PrefixInstruction.RES_4_H,
        0xA5 => PrefixInstruction.RES_4_L,
        0xA6 => PrefixInstruction.RES_4_HLA,
        0xA7 => PrefixInstruction.RES_4_A,
        0xA8 => PrefixInstruction.RES_5_B,
        0xA9 => PrefixInstruction.RES_5_C,
        0xAA => PrefixInstruction.RES_5_D,
        0xAB => PrefixInstruction.RES_5_E,
        0xAC => PrefixInstruction.RES_5_H,
        0xAD => PrefixInstruction.RES_5_L,
        0xAE => PrefixInstruction.RES_5_HLA,
        0xAF => PrefixInstruction.RES_5_A,
        0xB0 => PrefixInstruction.RES_6_B,
        0xB1 => PrefixInstruction.RES_6_C,
        0xB2 => PrefixInstruction.RES_6_D,
        0xB3 => PrefixInstruction.RES_6_E,
        0xB4 => PrefixInstruction.RES_6_H,
        0xB5 => PrefixInstruction.RES_6_L,
        0xB6 => PrefixInstruction.RES_6_HLA,
        0xB7 => PrefixInstruction.RES_6_A,
        0xB8 => PrefixInstruction.RES_7_B,
        0xB9 => PrefixInstruction.RES_7_C,
        0xBA => PrefixInstruction.RES_7_D,
        0xBB => PrefixInstruction.RES_7_E,
        0xBC => PrefixInstruction.RES_7_H,
        0xBD => PrefixInstruction.RES_7_L,
        0xBE => PrefixInstruction.RES_7_HLA,
        0xBF => PrefixInstruction.RES_7_A,
        0xC0 => PrefixInstruction.SET_0_B,
        0xC1 => PrefixInstruction.SET_0_C,
        0xC2 => PrefixInstruction.SET_0_D,
        0xC3 => PrefixInstruction.SET_0_E,
        0xC4 => PrefixInstruction.SET_0_H,
        0xC5 => PrefixInstruction.SET_0_L,
        0xC6 => PrefixInstruction.SET_0_HLA,
        0xC7 => PrefixInstruction.SET_0_A,
        0xC8 => PrefixInstruction.SET_1_B,
        0xC9 => PrefixInstruction.SET_1_C,
        0xCA => PrefixInstruction.SET_1_D,
        0xCB => PrefixInstruction.SET_1_E,
        0xCC => PrefixInstruction.SET_1_H,
        0xCD => PrefixInstruction.SET_1_L,
        0xCE => PrefixInstruction.SET_1_HLA,
        0xCF => PrefixInstruction.SET_1_A,
        0xD0 => PrefixInstruction.SET_2_B,
        0xD1 => PrefixInstruction.SET_2_C,
        0xD2 => PrefixInstruction.SET_2_D,
        0xD3 => PrefixInstruction.SET_2_E,
        0xD4 => PrefixInstruction.SET_2_H,
        0xD5 => PrefixInstruction.SET_2_L,
        0xD6 => PrefixInstruction.SET_2_HLA,
        0xD7 => PrefixInstruction.SET_2_A,
        0xD8 => PrefixInstruction.SET_3_B,
        0xD9 => PrefixInstruction.SET_3_C,
        0xDA => PrefixInstruction.SET_3_D,
        0xDB => PrefixInstruction.SET_3_E,
        0xDC => PrefixInstruction.SET_3_H,
        0xDD => PrefixInstruction.SET_3_L,
        0xDE => PrefixInstruction.SET_3_HLA,
        0xDF => PrefixInstruction.SET_3_A,
        0xE0 => PrefixInstruction.SET_4_B,
        0xE1 => PrefixInstruction.SET_4_C,
        0xE2 => PrefixInstruction.SET_4_D,
        0xE3 => PrefixInstruction.SET_4_E,
        0xE4 => PrefixInstruction.SET_4_H,
        0xE5 => PrefixInstruction.SET_4_L,
        0xE6 => PrefixInstruction.SET_4_HLA,
        0xE7 => PrefixInstruction.SET_4_A,
        0xE8 => PrefixInstruction.SET_5_B,
        0xE9 => PrefixInstruction.SET_5_C,
        0xEA => PrefixInstruction.SET_5_D,
        0xEB => PrefixInstruction.SET_5_E,
        0xEC => PrefixInstruction.SET_5_H,
        0xED => PrefixInstruction.SET_5_L,
        0xEE => PrefixInstruction.SET_5_HLA,
        0xEF => PrefixInstruction.SET_5_A,
        0xF0 => PrefixInstruction.SET_6_B,
        0xF1 => PrefixInstruction.SET_6_C,
        0xF2 => PrefixInstruction.SET_6_D,
        0xF3 => PrefixInstruction.SET_6_E,
        0xF4 => PrefixInstruction.SET_6_H,
        0xF5 => PrefixInstruction.SET_6_L,
        0xF6 => PrefixInstruction.SET_6_HLA,
        0xF7 => PrefixInstruction.SET_6_A,
        0xF8 => PrefixInstruction.SET_7_B,
        0xF9 => PrefixInstruction.SET_7_C,
        0xFA => PrefixInstruction.SET_7_D,
        0xFB => PrefixInstruction.SET_7_E,
        0xFC => PrefixInstruction.SET_7_H,
        0xFD => PrefixInstruction.SET_7_L,
        0xFE => PrefixInstruction.SET_7_HLA,
        0xFF => PrefixInstruction.SET_7_A,
    };
}
