const std = @import("std");

pub fn main() void {
    std.debug.print("=== Compile-time Features and Generics ===\n\n", .{});
    
    // 1. Compile-time execution
    compile_time_execution_demo();
    
    // 2. Generic data structures
    generic_data_structures_demo();
    
    // 3. Basic compile-time inspection
    basic_compile_time_inspection_demo();
    
    // 4. Comptime parameters
    comptime_parameters_demo();
    
    // 5. Type manipulation
    type_manipulation_demo();
}

// 1. Compile-time execution - run code at compile time
fn compile_time_execution_demo() void {
    std.debug.print("1. COMPILE-TIME EXECUTION\n", .{});
    
    // Compile-time constants
    const fibonacci_10 = comptime fibonacci(10);
    std.debug.print("Fibonacci(10) computed at compile time: {}\n", .{fibonacci_10});
    
    // Compile-time array generation
    const powers_of_two = comptime generatePowersOfTwo(8);
    std.debug.print("Powers of two (compile-time): ", .{});
    for (powers_of_two) |power| {
        std.debug.print("{} ", .{power});
    }
    std.debug.print("\n", .{});
    
    // Compile-time string operations
    const message = comptime "Hello, " ++ "World!";
    std.debug.print("Compile-time string concatenation: {s}\n", .{message});
    
    // Compile-time loop
    comptime var sum: i32 = 0;
    comptime var i: i32 = 1;
    inline while (i <= 10) : (i += 1) {
        sum += i;
    }
    std.debug.print("Sum 1-10 computed at compile time: {}\n", .{sum});
    
    std.debug.print("\n", .{});
}

fn fibonacci(n: u32) u32 {
    if (n <= 1) return n;
    return fibonacci(n - 1) + fibonacci(n - 2);
}

fn generatePowersOfTwo(comptime count: u32) [count]u32 {
    var powers: [count]u32 = undefined;
    var i: u32 = 0;
    while (i < count) : (i += 1) {
        powers[i] = std.math.pow(u32, 2, i);
    }
    return powers;
}

// 2. Generic data structures - type-safe collections
fn generic_data_structures_demo() void {
    std.debug.print("2. GENERIC DATA STRUCTURES\n", .{});
    
    // Generic stack
    var int_stack = Stack(i32).init();
    int_stack.push(10);
    int_stack.push(20);
    int_stack.push(30);
    
    std.debug.print("Integer stack: ", .{});
    while (int_stack.pop()) |value| {
        std.debug.print("{} ", .{value});
    }
    std.debug.print("\n", .{});
    
    // Generic stack with different type
    var float_stack = Stack(f32).init();
    float_stack.push(1.5);
    float_stack.push(2.5);
    float_stack.push(3.5);
    
    std.debug.print("Float stack: ", .{});
    while (float_stack.pop()) |value| {
        std.debug.print("{} ", .{value});
    }
    std.debug.print("\n", .{});
    
    // Generic pair
    const int_pair = Pair(i32, i32){.first = 10, .second = 20};
    std.debug.print("Integer pair: ({}, {})\n", .{int_pair.first, int_pair.second});
    
    const mixed_pair = Pair(i32, []const u8){.first = 42, .second = "hello"};
    std.debug.print("Mixed pair: ({}, {s})\n", .{mixed_pair.first, mixed_pair.second});
    
    // Generic array operations
    const numbers = [_]i32{1, 2, 3, 4, 5};
    const sum = arraySum(i32, &numbers);
    std.debug.print("Array sum: {}\n", .{sum});
    
    const floats = [_]f32{1.1, 2.2, 3.3};
    const float_sum = arraySum(f32, &floats);
    std.debug.print("Float array sum: {}\n", .{float_sum});
    
    std.debug.print("\n", .{});
}

// Generic stack implementation
fn Stack(comptime T: type) type {
    return struct {
        const Self = @This();
        const capacity = 10;
        
        items: [capacity]T,
        count: usize,
        
        fn init() Self {
            return Self{
                .items = undefined,
                .count = 0,
            };
        }
        
        fn push(self: *Self, item: T) void {
            if (self.count < capacity) {
                self.items[self.count] = item;
                self.count += 1;
            }
        }
        
        fn pop(self: *Self) ?T {
            if (self.count > 0) {
                self.count -= 1;
                return self.items[self.count];
            }
            return null;
        }
    };
}

// Generic pair
fn Pair(comptime T: type, comptime U: type) type {
    return struct {
        first: T,
        second: U,
    };
}

// Generic function
fn arraySum(comptime T: type, array: []const T) T {
    var sum: T = 0;
    for (array) |item| {
        sum += item;
    }
    return sum;
}

// 3. Basic compile-time inspection
fn basic_compile_time_inspection_demo() void {
    std.debug.print("3. BASIC COMPILE-TIME INSPECTION\n", .{});
    
    // Type size and alignment
    std.debug.print("Size of Person: {} bytes\n", .{@sizeOf(Person)});
    std.debug.print("Alignment of Person: {} bytes\n", .{@alignOf(Person)});
    
    // Type names (simple)
    std.debug.print("Type name of i32: {s}\n", .{@typeName(i32)});
    std.debug.print("Type name of Person: {s}\n", .{@typeName(Person)});
    
    // Field offsets
    std.debug.print("Person field offsets:\n", .{});
    std.debug.print("  name: {}\n", .{@offsetOf(Person, "name")});
    std.debug.print("  age: {}\n", .{@offsetOf(Person, "age")});
    std.debug.print("  height: {}\n", .{@offsetOf(Person, "height")});
    
    // Type checking
    const is_same_type = @TypeOf(42) == @TypeOf(100);
    std.debug.print("42 and 100 have same type: {}\n", .{is_same_type});
    
    std.debug.print("\n", .{});
}

const Person = struct {
    name: []const u8,
    age: u32,
    height: f32,
};

// 4. Comptime parameters - configure behavior at compile time
fn comptime_parameters_demo() void {
    std.debug.print("4. COMPTIME PARAMETERS\n", .{});
    
    // Array with compile-time size
    const small_array = createArray(i32, 3, 42);
    std.debug.print("Small array: ", .{});
    for (small_array) |item| {
        std.debug.print("{} ", .{item});
    }
    std.debug.print("\n", .{});
    
    const large_array = createArray(f32, 5, 3.14);
    std.debug.print("Large array: ", .{});
    for (large_array) |item| {
        std.debug.print("{} ", .{item});
    }
    std.debug.print("\n", .{});
    
    // Conditional compilation
    const debug_build = comptime isDebugBuild();
    if (debug_build) {
        std.debug.print("Running in debug mode\n", .{});
    } else {
        std.debug.print("Running in release mode\n", .{});
    }
    
    // Generic function with comptime behavior
    const result1 = processValue(i32, 100, true);
    std.debug.print("Processed integer: {}\n", .{result1});
    
    const result2 = processValue(f32, 3.14, false);
    std.debug.print("Processed float: {}\n", .{result2});
    
    std.debug.print("\n", .{});
}

fn createArray(comptime T: type, comptime size: usize, value: T) [size]T {
    var array: [size]T = undefined;
    for (&array) |*item| {
        item.* = value;
    }
    return array;
}

fn isDebugBuild() bool {
    return @import("builtin").mode == .Debug;
}

fn processValue(comptime T: type, value: T, comptime double_it: bool) T {
    if (double_it) {
        return value * 2;
    } else {
        return value;
    }
}

// 5. Type manipulation - create new types at compile time
fn type_manipulation_demo() void {
    std.debug.print("5. TYPE MANIPULATION\n", .{});
    
    // Optional wrapper
    const maybe_int = wrapOptional(i32, 42);
    std.debug.print("Optional int: {?}\n", .{maybe_int});
    
    // Array of specific size
    const FixedArray = createArrayType(i32, 5);
    const fixed_array = FixedArray{1, 2, 3, 4, 5};
    std.debug.print("Fixed array: ", .{});
    for (fixed_array) |item| {
        std.debug.print("{} ", .{item});
    }
    std.debug.print("\n", .{});
    
    // Type-based dispatch (simplified)
    const int_result = processInteger(100);
    std.debug.print("Integer processing result: {}\n", .{int_result});
    
    const float_result = processFloat(3.14);
    std.debug.print("Float processing result: {}\n", .{float_result});
    
    const bool_result = processBoolean(true);
    std.debug.print("Boolean processing result: {}\n", .{bool_result});
    
    std.debug.print("\n", .{});
}

fn wrapOptional(comptime T: type, value: T) ?T {
    return value;
}

fn createArrayType(comptime T: type, comptime size: usize) type {
    return [size]T;
}

fn processInteger(value: i32) i32 {
    std.debug.print("  Processing integer type\n", .{});
    return value * 2;
}

fn processFloat(value: f32) f32 {
    std.debug.print("  Processing float type\n", .{});
    return value * 1.5;
}

fn processBoolean(value: bool) bool {
    std.debug.print("  Processing boolean type\n", .{});
    return !value;
}