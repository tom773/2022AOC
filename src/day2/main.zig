const std = @import("std");

// Part 1
const Move = enum{
    rock,
    paper,
    scissors,
};

const Result = enum{
    win,
    lose,
    tie,
};

const CustomError = error{ NoSuchMove };

fn playGame(eMove: Move, myMove: Move) Result {
    const result: Result = switch((eMove)) {
        Move.rock => switch(myMove) {
            Move.rock => .tie,
            Move.paper => .win,
            Move.scissors => .lose,
        },
        Move.paper => switch(myMove) {
            Move.rock => .lose,
            Move.paper => .tie,
            Move.scissors => .win,
        },
        Move.scissors => switch(myMove) {
            Move.rock => .win,
            Move.paper => .lose,
            Move.scissors => .tie,
        },
    };
    return result;
}

fn getMyMove(toD: u8) CustomError!Move {
    const bigMove: Move = switch(toD) {
        'X' => .rock,
        'Y' => .paper,
        'Z' => .scissors,
        else => return CustomError.NoSuchMove,
    };
    return bigMove;
}

fn getEMove(toD: u8) CustomError!Move {
    const bigMove: Move = switch(toD) {
        'A' => .rock,
        'B' => .paper,
        'C' => .scissors,
        else => return CustomError.NoSuchMove,
    };
    return bigMove;
}

pub fn mainPart1() !void {

    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    const bytes = try allocator.alloc(u8, 16384);
    defer allocator.free(bytes);

    var file = try std.fs.cwd().openFile("src/day2/2.txt", .{});
    defer file.close();

    var buffer: [1024]u8 = undefined;
    var total: i32 = 0;

    while (try file.reader().readUntilDelimiterOrEof(&buffer, '\n')) |line| {
        const eMove = try getEMove(line[0]);
        const myMove = try getMyMove(line[2]);

        const res = playGame(eMove, myMove);

        switch (res) {
            Result.win => {
                if (myMove == Move.rock) {
                    total += 6+1;
                } else if (myMove == Move.paper) {
                    total += 6+2;
                } else {
                    total += 6+3;
                }
            },
            Result.lose => {
                if (myMove == Move.rock) {
                    total += 0+1;
                } else if (myMove == Move.paper) {
                    total += 0+2;
                } else {
                    total += 0+3;
                }
            },
            Result.tie => {
                if (myMove == Move.rock) {
                    total += 3+1;
                } else if (myMove == Move.paper) {
                    total += 3+2;
                } else {
                    total += 3+3;
                }
            },
        }
    }
    std.debug.print("{}\n", .{total});
}

// Part 2

fn getEMoveP2(toD: u8) CustomError!Move {
    const bigMove: Move = switch(toD) {
        'A' => .rock,
        'B' => .paper,
        'C' => .scissors,
        else => return CustomError.NoSuchMove,
    };
    return bigMove;
}

fn desResult(toD: u8) CustomError!Result {
    const bigMove: Result = switch(toD) {
        'X' => .lose,
        'Y' => .tie,
        'Z' => .win,
        else => return CustomError.NoSuchMove,
    };
    return bigMove;
}

pub fn main() !void {

    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    const bytes = try allocator.alloc(u8, 16384);
    defer allocator.free(bytes);

    var file = try std.fs.cwd().openFile("src/day2/2.txt", .{});
    defer file.close();

    var buffer: [1024]u8 = undefined;
    var total_: i32 = 0;

    while (try file.reader().readUntilDelimiterOrEof(&buffer, '\n')) |line| {
        const eMove = try getEMoveP2(line[0]);
        const desResult_ = try desResult(line[2]);

        
        switch (desResult_) {
            Result.win => {
                if (eMove == Move.rock) {
                    total_ += 6 + 2;
                } else if (eMove == Move.paper) {
                    total_ += 6 + 3;
                } else {
                    total_ += 6 + 1;
                }
            },
            Result.lose => {
                if (eMove == Move.rock) {
                    total_ += 0 + 3;
                } else if (eMove == Move.paper) {
                    total_ += 0 + 1;
                } else {
                    total_ += 0 + 2;
                }
            },
            else => {
                if (eMove == Move.rock) {
                    total_ += 3 + 1;
                } else if (eMove == Move.paper) {
                    total_ += 3 + 2;
                } else {
                    total_ += 3 + 3;
                }
            },
        }
    }
    std.debug.print("{d}\n", .{total_});
}