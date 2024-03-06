const std = @import("std");

// Day 3 Part 1
pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    const bytes = try allocator.alloc(u8, 16384);
    defer allocator.free(bytes);

    var file = try std.fs.cwd().openFile("src/day3/3.txt", .{});
    defer file.close();

    var buffer: [1024]u8 = undefined;
    var total: i16 = 0;
    while (try file.reader().readUntilDelimiterOrEof(&buffer, '\n')) |line| {
        const length: usize = line.len;
        const spltLine1 = line[0..(length / 2)];
        const spltLine2 = line[(length / 2)..length];
        var duplicate: u8 = undefined;

        for (spltLine1) |c| {
            for (spltLine2) |c2| {
                if (c == c2) {
                    duplicate = c2;
                    break;
                }
            }
        }

        if (duplicate >= 97) {
            total += duplicate - 96;
        } else {
            total += duplicate - 38;
        }
    }
    std.debug.print("{}", .{total});
}
