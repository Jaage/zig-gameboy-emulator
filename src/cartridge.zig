const std = @import("std");
const expect = std.testing.expect;
const mem = std.mem;

const RomHeader = struct {
    entry: [4]u8,
    nintendo_logo: [0x30]u8,
    title: [16]u8,
    cgb_flag: u8,
    new_licensee_code: [2]u8,
    sgb_flag: u8,
    cartridge_type: u8,
    rom_size: u8,
    ram_size: u32,
    destination_code: u8,
    old_licensee_code: u8,
    version: u8,
    header_checksum: u8,
    global_checksum: u16,
};

const CartridgeContext = struct {
    filename: []const u8,
    rom_size: u32,
    rom_data: []u8,
    rom_header: RomHeader,
};

const CartridgeType = enum {
    ROM_ONLY,
    MBC1,
    MBC1_RAM,
    MBC1_RAM_BATTERY,
    MBC2,
    MBC2_BATTERY,
    ROM_RAM,
    ROM_RAM_BATTERY,
    MMM01,
    MMM01_RAM,
    MMM01_RAM_BATTERY,
    MBC3_TIMER_BATTERY,
    MBC3_TIMER_RAM_BATTERY,
    MBC3,
    MBC3_RAM,
    MBC3_RAM_BATTERY,
    MBC5,
    MBC5_RAM,
    MBC5_RAM_BATTERY,
    MBC5_RUMBLE,
    MBC5_RUMBLE_RAM,
    MBC5_RUMBLE_RAM_BATTERY,
    MBC6,
    MBC7_SENSOR_RUMBLE_RAM_BATTERY,
    POCKET_CAMERA,
    BANDAI_TAMA5,
    HuC3,
    HuC1_RAM_BATTERY,
};

pub fn getCartridgeType(code: u8) CartridgeType {
    return switch (code) {
        0x00 => CartridgeType.ROM_ONLY,
        0x01 => CartridgeType.MBC1,
        0x02 => CartridgeType.MBC1_RAM,
        0x03 => CartridgeType.MBC1_RAM_BATTERY,
        0x05 => CartridgeType.MBC2,
        0x06 => CartridgeType.MBC2_BATTERY,
        0x08 => CartridgeType.ROM_RAM,
        0x09 => CartridgeType.ROM_RAM_BATTERY,
        0x0B => CartridgeType.MMM01,
        0x0C => CartridgeType.MMM01_RAM,
        0x0D => CartridgeType.MMM01_RAM_BATTERY,
        0x0F => CartridgeType.MBC3_TIMER_BATTERY,
        0x10 => CartridgeType.MBC3_TIMER_RAM_BATTERY,
        0x11 => CartridgeType.MBC3,
        0x12 => CartridgeType.MBC3_RAM,
        0x13 => CartridgeType.MBC3_RAM_BATTERY,
        0x19 => CartridgeType.MBC5,
        0x1A => CartridgeType.MBC5_RAM,
        0x1B => CartridgeType.MBC5_RAM_BATTERY,
        0x1C => CartridgeType.MBC5_RUMBLE,
        0x1D => CartridgeType.MBC5_RUMBLE_RAM,
        0x1E => CartridgeType.MBC5_RUMBLE_RAM_BATTERY,
        0x20 => CartridgeType.MBC6,
        0x22 => CartridgeType.MBC7_SENSOR_RUMBLE_RAM_BATTERY,
        0xFC => CartridgeType.POCKET_CAMERA,
        0xFD => CartridgeType.BANDAI_TAMA5,
        0xFE => CartridgeType.HuC3,
        0xFF => CartridgeType.HuC1_RAM_BATTERY,
        else => unreachable,
    };
}

pub fn getPublisher(code: u8) []const u8 {
    return switch (code) {
        0x00 => "None",
        0x01 => "Nintendo R&D1",
        0x08 => "Capcom",
        0x13 => "Electronic Arts",
        0x18 => "Hudson Soft",
        0x19 => "b-ai",
        0x20 => "kss",
        0x22 => "pow",
        0x24 => "PCM Complete",
        0x25 => "san-x",
        0x28 => "Kemco Japan",
        0x29 => "seta",
        0x30 => "Viacom",
        0x31 => "Nintendo",
        0x32 => "Bandai",
        0x33 => "Ocean/Acclaim",
        0x34 => "Konami",
        0x35 => "Hector",
        0x37 => "Taito",
        0x38 => "Hudson",
        0x39 => "Banpresto",
        0x41 => "Ubi Soft",
        0x42 => "Atlus",
        0x44 => "Malibu",
        0x46 => "angel",
        0x47 => "Bullet-Proof",
        0x49 => "irem",
        0x50 => "Absolute",
        0x51 => "Acclaim",
        0x52 => "Activision",
        0x53 => "American sammy",
        0x54 => "Konami",
        0x55 => "Hi tech entertainment",
        0x56 => "LJN",
        0x57 => "Matchbox",
        0x58 => "Mattel",
        0x59 => "Milton Bradley",
        0x60 => "Titus",
        0x61 => "Virgin",
        0x64 => "LucasArts",
        0x67 => "Ocean",
        0x69 => "Electronic Arts",
        0x70 => "Infogrames",
        0x71 => "Interplay",
        0x72 => "Broderbund",
        0x73 => "sculptured",
        0x75 => "sci",
        0x78 => "THQ",
        0x79 => "Accolade",
        0x80 => "misawa",
        0x83 => "lozc",
        0x86 => "Tokuma Shoten Intermedia",
        0x87 => "Tsukuda Original",
        0x91 => "Chunsoft",
        0x92 => "Video system",
        0x93 => "Ocean/Acclaim",
        0x95 => "Varie",
        0x96 => "Yonezawa/s’pal",
        0x97 => "Kaneko",
        0x99 => "Pack in soft",
        0xA4 => "Konami (Yu-Gi-Oh!)",
        else => unreachable,
    };
}

fn getRomSize(byte: u8) u32 {
    return switch (byte) {
        0x00 => 32 * 1024,
        0x01 => 64 * 1024,
        0x02 => 128 * 1024,
        0x03 => 256 * 1024,
        0x04 => 512 * 1024,
        0x05 => 1024 * 1024,
        0x06 => 2 * 1024 * 1024,
        0x07 => 4 * 1024 * 1024,
        0x08 => 8 * 1024 * 1024,
        else => unreachable,
    };
}

fn getRamSize(byte: u8) u32 {
    return switch (byte) {
        0x00 => 0,
        0x01 => 0,
        0x02 => 8 * 1024,
        0x03 => 32 * 1024,
        0x04 => 128 * 1024,
        0x05 => 64 * 1024,
        else => unreachable,
    };
}

pub fn loadCartridge(allocator: std.mem.Allocator, rom_file: []const u8) !CartridgeContext {
    const file = std.fs.cwd().openFile(rom_file, .{}) catch |err| {
        std.log.err("Failed to open file: {s}, with error: {s}", .{ rom_file, @errorName(err) });
        return err;
    };
    defer file.close();

    const rom = try file.readToEndAlloc(allocator, 1572864);
    const rom_header = RomHeader{
        .entry = rom[0x0100..0x0104].*,
        .nintendo_logo = rom[0x0104..0x0134].*,
        .title = rom[0x0134..0x0144].*,
        .cgb_flag = rom[0x0143],
        .new_licensee_code = rom[0x0144..0x0146].*,
        .sgb_flag = rom[0x0146],
        .cartridge_type = rom[0x0147],
        .rom_size = rom[0x0148],
        .ram_size = getRamSize(rom[0x0149]),
        .destination_code = rom[0x014A],
        .old_licensee_code = rom[0x014B],
        .version = rom[0x014C],
        .header_checksum = rom[0x014D],
        .global_checksum = @bitCast(rom[0x014E..0x0150].*),
    };

    const cc = CartridgeContext{
        .filename = rom_file,
        .rom_size = getRomSize(rom_header.rom_size),
        .rom_data = rom,
        .rom_header = rom_header,
    };
    std.debug.print("Title:            {s}\n", .{cc.rom_header.title});
    std.debug.print("Cartridge Type:   0x{X} ({any})\n", .{ cc.rom_header.cartridge_type, getCartridgeType(cc.rom_header.cartridge_type) });
    std.debug.print("ROM Size:         {d} Bytes\n", .{getRomSize(cc.rom_header.rom_size)});
    std.debug.print("RAM Size:         {d} Bytes\n", .{cc.rom_header.ram_size});
    std.debug.print("Destination Code: 0x{X} ({s})\n", .{ cc.rom_header.destination_code, switch (cc.rom_header.destination_code) {
        0x00 => "Japan (and possibly overseas)",
        0x01 => "Overseas only",
        else => unreachable,
    } });
    std.debug.print("Version:          0x{X}\n", .{cc.rom_header.version});
    return cc;
}

test "getCartridgeType" {
    try expect(getCartridgeType(0x0D) == CartridgeType.MMM01_RAM_BATTERY);
}

test "getPublisher" {
    try expect(mem.eql(u8, getPublisher(0x97), "Kaneko"));
    try expect(mem.eql(u8, getPublisher(0x33), "Ocean/Acclaim"));
    try expect(mem.eql(u8, getPublisher(0x47), "Bullet-Proof"));
    try expect(mem.eql(u8, getPublisher(0x86), "Tokuma Shoten Intermedia"));
    try expect(mem.eql(u8, getPublisher(0x96), "Yonezawa/s’pal"));
}

test "getRomSize" {
    try expect(getRomSize(0x05) == 1048576);
}

test "getRamSize" {
    try expect(getRamSize(0x02) == 8192);
}

test "loadCartridge" {
    var gpa = std.heap.GeneralPurposeAllocator(.{ .thread_safe = true }){};
    const allocator = gpa.allocator();
    // // defer (gpa.deinit() == .leak){std.log.err("Memory leak", .{})};
    defer {
        const is_leak = gpa.deinit() == .leak;
        if (is_leak) {
            std.log.err("Memory leak", .{});
        }
    }
    const cc = try loadCartridge(allocator, "pokemon-red-rom.gb");
    defer allocator.free(cc.rom_data);

    try expect(mem.eql(u8, std.mem.trimRight(u8, &cc.rom_header.title, &[_]u8{0}), "POKEMON RED"));
    try expect(mem.eql(u8, &cc.rom_header.nintendo_logo, &[_]u8{
        0xCE, 0xED, 0x66, 0x66, 0xCC, 0x0D, 0x00, 0x0B, 0x03, 0x73, 0x00, 0x83, 0x00, 0x0C, 0x00, 0x0D,
        0x00, 0x08, 0x11, 0x1F, 0x88, 0x89, 0x00, 0x0E, 0xDC, 0xCC, 0x6E, 0xE6, 0xDD, 0xDD, 0xD9, 0x99,
        0xBB, 0xBB, 0x67, 0x63, 0x6E, 0x0E, 0xEC, 0xCC, 0xDD, 0xDC, 0x99, 0x9F, 0xBB, 0xB9, 0x33, 0x3E,
    }));
    // try expect(cc.rom_header.cgb_flag == 0xC0); byte is 0 for pokemon red
    try expect(cc.rom_header.old_licensee_code == 0x33);
    try expect(mem.eql(u8, getPublisher(try std.fmt.parseInt(u8, &cc.rom_header.new_licensee_code, 16)), "Nintendo R&D1"));
    try expect(cc.rom_header.sgb_flag == 0x03);
    var checksum: u8 = 0;
    for (0x0134..0x014D) |i| {
        checksum = checksum -% cc.rom_data[i] -% 1;
    }
    try expect(checksum == cc.rom_header.header_checksum);
}
