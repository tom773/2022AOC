const std = @import("std");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    const ArrayList = std.ArrayList;
    const bytes = try allocator.alloc(u8, 16384);
    defer allocator.free(bytes);

    var file = try std.fs.cwd().openFile("src/1.txt", .{});
    defer file.close();

    var buffer: [1024]u8 = undefined;
    var sum: i32 = 0;
    var list = ArrayList(i32).init(allocator);

    while (try file.reader().readUntilDelimiterOrEof(&buffer, '\n')) |line| {
        var num = std.fmt.parseInt(i32, line, 10) catch -1;

        if (num == -1) {
            try list.append(sum);
            sum = 0;
        } else {
            sum += num;
        }
    }

    std.mem.sort(i32, list.items, {}, comptime std.sort.asc(i32));
    var end: usize = list.items.len;
    var total = list.items[end - 3 .. end];

    var newSum: i32 = 0;
    for (total) |item| {
        newSum += item;
    }

    std.debug.print("Total: {d}\n", .{newSum});
}
