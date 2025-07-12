const std = @import("std");

pub fn main() void {
    std.debug.print("=== Zig Feature Highlights ===\n\n", .{});
    
    // 1. Small, simple language
    simple_language_demo();
    
    // 2. Performance and Safety
    performance_and_safety_demo();
    
    // 3. No hidden control flow
    no_hidden_control_flow_demo();
    
    // 4. Compile-time features
    compile_time_features_demo();
}

// 1. Small, simple language - readable and maintainable
fn simple_language_demo() void {
    std.debug.print("1. SMALL, SIMPLE LANGUAGE\n", .{});
    
    // Clear, explicit syntax
    const message = "Hello, World!";
    std.debug.print("Simple message: {s}\n", .{message});
    
    // Type inference where helpful
    const number = 42; // inferred as comptime_int
    const pi = 3.14159; // inferred as comptime_float
    std.debug.print("Inferred types: {} and {}\n", .{number, pi});
    
    // Explicit types when needed
    const byte: u8 = 255;
    const signed: i32 = -1000;
    std.debug.print("Explicit types: {} and {}\n", .{byte, signed});
    
    std.debug.print("\n", .{});
}

// 2. Performance and Safety - fast and safe by default
fn performance_and_safety_demo() void {
    std.debug.print("2. PERFORMANCE AND SAFETY\n", .{});
    
    // Stack allocation is preferred and explicit
    const stack_array = [_]i32{1, 2, 3, 4, 5};
    std.debug.print("Stack array: ", .{});
    for (stack_array) |item| {
        std.debug.print("{} ", .{item});
    }
    std.debug.print("\n", .{});
    
    // Bounds checking in debug builds
    const index: usize = 2;
    if (index < stack_array.len) {
        std.debug.print("Safe array access: {}\n", .{stack_array[index]});
    }
    
    // Integer overflow detection in debug builds
    var counter: u8 = 200;
    counter += 50; // This would be caught in debug builds if it overflowed
    std.debug.print("Counter: {}\n", .{counter});
    
    // No undefined behavior by default
    // All memory is initialized unless explicitly marked as undefined
    var initialized_array: [3]i32 = undefined;
    initialized_array[0] = 1;
    initialized_array[1] = 2;
    initialized_array[2] = 3;
    std.debug.print("Initialized array: ", .{});
    for (initialized_array) |item| {
        std.debug.print("{} ", .{item});
    }
    std.debug.print("\n", .{});
    
    std.debug.print("\n", .{});
}

// 3. No hidden control flow - what you see is what you get
fn no_hidden_control_flow_demo() void {
    std.debug.print("3. NO HIDDEN CONTROL FLOW\n", .{});
    
    // No hidden memory allocations
    std.debug.print("No hidden heap allocations - all allocation is explicit\n", .{});
    
    // No exceptions - errors are values
    const result = divide(10, 2) catch |err| {
        std.debug.print("Error: {}\n", .{err});
        return;
    };
    std.debug.print("Division result: {}\n", .{result});
    
    // No operator overloading - + always means addition
    const a = 5;
    const b = 3;
    const sum = a + b;
    std.debug.print("Addition is always addition: {} + {} = {}\n", .{a, b, sum});
    
    // No hidden function calls
    std.debug.print("Function calls are explicit - no destructors or constructors\n", .{});
    
    // No goto, no macros that can hide control flow
    std.debug.print("Control flow is always visible in the code\n", .{});
    
    std.debug.print("\n", .{});
}

const DivisionError = error{
    DivisionByZero,
};

fn divide(a: f32, b: f32) DivisionError!f32 {
    if (b == 0) {
        return DivisionError.DivisionByZero;
    }
    return a / b;
}

// 4. Compile-time features - powerful metaprogramming
fn compile_time_features_demo() void {
    std.debug.print("4. COMPILE-TIME FEATURES\n", .{});
    
    // Compile-time variables
    const array_size = 5;
    const compile_time_array = [_]i32{1} ** array_size;
    std.debug.print("Compile-time array of size {}: ", .{array_size});
    for (compile_time_array) |item| {
        std.debug.print("{} ", .{item});
    }
    std.debug.print("\n", .{});
    
    // Compile-time execution
    const factorial_5 = comptime fibonacci(5);
    std.debug.print("Compile-time fibonacci(5): {}\n", .{factorial_5});
    
    // Generic functions (compile-time polymorphism)
    const int_max = max(i32, 10, 20);
    const float_max = max(f32, 3.14, 2.71);
    std.debug.print("Generic max function: max(10, 20) = {}, max(3.14, 2.71) = {}\n", .{int_max, float_max});
    
    // Basic type information
    std.debug.print("Size of Point: {} bytes\n", .{@sizeOf(Point)});
    std.debug.print("Alignment of Point: {} bytes\n", .{@alignOf(Point)});
    
    std.debug.print("\n", .{});
}

// Compile-time function
fn fibonacci(n: u32) u32 {
    if (n <= 1) return n;
    return fibonacci(n - 1) + fibonacci(n - 2);
}

// Generic function
fn max(comptime T: type, a: T, b: T) T {
    return if (a > b) a else b;
}

// Struct for basic reflection demo
const Point = struct {
    x: f32,
    y: f32,
};