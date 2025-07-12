const std = @import("std");

pub fn main() !void {
    std.debug.print("=== Error Handling and Stack Traces ===\n\n", .{});
    
    // 1. Error values - errors are values, not exceptions
    error_values_demo();
    
    // 2. Error handling patterns
    try error_handling_patterns_demo();
    
    // 3. Stack traces
    stack_traces_demo();
    
    // 4. Error sets and unions
    error_sets_demo();
    
    // 5. Defer and errdefer
    defer_and_errdefer_demo();
}

// 1. Error values - explicit error handling
fn error_values_demo() void {
    std.debug.print("1. ERROR VALUES\n", .{});
    
    // Function that can return an error
    const result1 = divide(10, 2) catch |err| {
        std.debug.print("Error caught: {}\n", .{err});
        return;
    };
    std.debug.print("10 / 2 = {}\n", .{result1});
    
    // Function that returns an error
    const result2 = divide(10, 0) catch |err| blk: {
        std.debug.print("Error caught: {}\n", .{err});
        break :blk 0; // Return default value
    };
    std.debug.print("10 / 0 = {} (with default)\n", .{result2});
    
    // Different ways to handle errors
    const result3 = divide(15, 3) catch unreachable; // Assert no error
    std.debug.print("15 / 3 = {} (unreachable)\n", .{result3});
    
    std.debug.print("\n", .{});
}

// Simple error set
const MathError = error{
    DivisionByZero,
    Overflow,
};

fn divide(a: f32, b: f32) MathError!f32 {
    if (b == 0) {
        return MathError.DivisionByZero;
    }
    return a / b;
}

// 2. Error handling patterns
fn error_handling_patterns_demo() !void {
    std.debug.print("2. ERROR HANDLING PATTERNS\n", .{});
    
    // Pattern 1: Propagate errors with try
    const result1 = try parseAndDouble("5");
    std.debug.print("Parse and double '5': {}\n", .{result1});
    
    // Pattern 2: Handle specific errors
    const result2 = parseAndDouble("abc") catch |err| switch (err) {
        ParseError.InvalidFormat => {
            std.debug.print("Invalid format error caught\n", .{});
            return;
        },
        ParseError.TooLarge => {
            std.debug.print("Too large error caught\n", .{});
            return;
        },
    };
    
    std.debug.print("This won't print: {}\n", .{result2});
    
    std.debug.print("\n", .{});
}

const ParseError = error{
    InvalidFormat,
    TooLarge,
};

fn parseNumber(str: []const u8) ParseError!i32 {
    // Simple parser - just handle a few cases
    if (std.mem.eql(u8, str, "5")) return 5;
    if (std.mem.eql(u8, str, "10")) return 10;
    if (std.mem.eql(u8, str, "999999")) return ParseError.TooLarge;
    return ParseError.InvalidFormat;
}

fn parseAndDouble(str: []const u8) ParseError!i32 {
    const num = try parseNumber(str);
    return num * 2;
}

// 3. Stack traces demonstration
fn stack_traces_demo() void {
    std.debug.print("3. STACK TRACES\n", .{});
    
    // Call a function that will error
    const result = deepFunction(0) catch |err| {
        std.debug.print("Error in deep function: {}\n", .{err});
        return;
    };
    
    std.debug.print("Deep function result: {}\n", .{result});
    
    std.debug.print("\n", .{});
}

fn deepFunction(depth: u32) MathError!f32 {
    if (depth < 3) {
        return try deepFunction(depth + 1);
    }
    return try divide(10, 0); // This will error
}

// 4. Error sets and unions
fn error_sets_demo() void {
    std.debug.print("4. ERROR SETS AND UNIONS\n", .{});
    
    // Combined error set
    const result1 = complexOperation(5) catch |err| switch (err) {
        MathError.DivisionByZero => {
            std.debug.print("Math error: Division by zero\n", .{});
            return;
        },
        MathError.Overflow => {
            std.debug.print("Math error: Overflow\n", .{});
            return;
        },
        ParseError.InvalidFormat => {
            std.debug.print("Parse error: Invalid format\n", .{});
            return;
        },
        ParseError.TooLarge => {
            std.debug.print("Parse error: Too large\n", .{});
            return;
        },
    };
    
    std.debug.print("Complex operation result: {}\n", .{result1});
    
    // Test with error case
    const result2 = complexOperation(0) catch |err| {
        std.debug.print("Complex operation error: {}\n", .{err});
        return;
    };
    
    std.debug.print("This won't print: {}\n", .{result2});
    
    std.debug.print("\n", .{});
}

// Function that can return multiple types of errors
fn complexOperation(input: i32) (MathError || ParseError)!f32 {
    if (input == 0) {
        return MathError.DivisionByZero;
    }
    if (input > 1000) {
        return ParseError.TooLarge;
    }
    return try divide(100, @as(f32, @floatFromInt(input)));
}

// 5. Defer and errdefer - cleanup on success/error
fn defer_and_errdefer_demo() void {
    std.debug.print("5. DEFER AND ERRDEFER\n", .{});
    
    // Successful operation
    const result1 = resourceOperation(false) catch |err| {
        std.debug.print("Resource operation error: {}\n", .{err});
        return;
    };
    std.debug.print("Resource operation result: {}\n", .{result1});
    
    // Failed operation
    const result2 = resourceOperation(true) catch |err| {
        std.debug.print("Resource operation error: {}\n", .{err});
        return;
    };
    std.debug.print("This won't print: {}\n", .{result2});
    
    std.debug.print("\n", .{});
}

const ResourceError = error{
    ResourceUnavailable,
    AccessDenied,
};

fn resourceOperation(should_fail: bool) ResourceError!i32 {
    std.debug.print("  Acquiring resource...\n", .{});
    
    // defer runs when function exits normally
    defer std.debug.print("  Cleaning up resource (normal exit)\n", .{});
    
    // errdefer runs only when function exits with error
    errdefer std.debug.print("  Cleaning up resource (error exit)\n", .{});
    
    if (should_fail) {
        std.debug.print("  Operation failed!\n", .{});
        return ResourceError.ResourceUnavailable;
    }
    
    std.debug.print("  Operation succeeded!\n", .{});
    return 42;
}