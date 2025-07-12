const std = @import("std");

pub fn main() !void {
    std.debug.print("=== Zig Practice Exercises ===\n\n", .{});
    
    // Exercise 1: Basic syntax and types
    exercise_1();
    
    // Exercise 2: Control flow
    exercise_2();
    
    // Exercise 3: Functions and error handling
    try exercise_3();
    
    // Exercise 4: Structs and methods
    exercise_4();
    
    // Exercise 5: Memory management with allocator
    try exercise_5();
}

// Exercise 1: Variables, types, and basic operations
fn exercise_1() void {
    std.debug.print("Exercise 1: Basic Types and Operations\n", .{});
    
    // Create variables of different types
    const a: i32 = 42;
    const b: f64 = 3.14159;
    var c: bool = false;
    
    // Type inference
    const d = "Hello, Zig!";
    const e = [_]i32{1, 2, 3, 4, 5};
    
    std.debug.print("Integer: {}, Float: {:.2}, Boolean: {}\n", .{a, b, c});
    std.debug.print("String: {s}\n", .{d});
    std.debug.print("Array: ", .{});
    for (e) |item| {
        std.debug.print("{} ", .{item});
    }
    std.debug.print("\n", .{});
    
    // Modify mutable variable
    c = true;
    std.debug.print("Modified boolean: {}\n", .{c});
    
    std.debug.print("\n", .{});
}

// Exercise 2: Control flow structures
fn exercise_2() void {
    std.debug.print("Exercise 2: Control Flow\n", .{});
    
    // If-else
    const temperature = 25;
    if (temperature > 30) {
        std.debug.print("Hot day!\n", .{});
    } else if (temperature > 20) {
        std.debug.print("Nice weather!\n", .{});
    } else {
        std.debug.print("Cold day!\n", .{});
    }
    
    // Switch statement
    const grade = 'B';
    switch (grade) {
        'A' => std.debug.print("Excellent!\n", .{}),
        'B' => std.debug.print("Good job!\n", .{}),
        'C' => std.debug.print("Average\n", .{}),
        else => std.debug.print("Keep trying!\n", .{}),
    }
    
    // For loop with range
    std.debug.print("Counting: ", .{});
    for (1..6) |i| {
        std.debug.print("{} ", .{i});
    }
    std.debug.print("\n", .{});
    
    // While loop
    var countdown: u8 = 5;
    std.debug.print("Countdown: ", .{});
    while (countdown > 0) {
        std.debug.print("{} ", .{countdown});
        countdown -= 1;
    }
    std.debug.print("Go!\n", .{});
    
    std.debug.print("\n", .{});
}

// Exercise 3: Functions and error handling
fn exercise_3() !void {
    std.debug.print("Exercise 3: Functions and Error Handling\n", .{});
    
    // Regular function call
    const sum = add(10, 20);
    std.debug.print("10 + 20 = {}\n", .{sum});
    
    // Function with error handling
    const result = divide(15, 3) catch |err| {
        std.debug.print("Error occurred: {}\n", .{err});
        return;
    };
    std.debug.print("15 / 3 = {}\n", .{result});
    
    // Handle division by zero
    const zero_result = divide(10, 0) catch |err| {
        std.debug.print("Caught error: {}\n", .{err});
        return;
    };
    std.debug.print("This shouldn't print: {}\n", .{zero_result});
    
    std.debug.print("\n", .{});
}

fn add(a: i32, b: i32) i32 {
    return a + b;
}

const MathError = error{
    DivisionByZero,
};

fn divide(a: f32, b: f32) MathError!f32 {
    if (b == 0) {
        return MathError.DivisionByZero;
    }
    return a / b;
}

// Exercise 4: Structs and methods
fn exercise_4() void {
    std.debug.print("Exercise 4: Structs and Methods\n", .{});
    
    // Create a person
    const person = Person{
        .name = "Alice",
        .age = 30,
        .height = 170.5,
    };
    
    person.introduce();
    
    // Create and manipulate a rectangle
    var rect = Rectangle{
        .width = 10.0,
        .height = 5.0,
    };
    
    std.debug.print("Rectangle: {}x{}\n", .{rect.width, rect.height});
    std.debug.print("Area: {}\n", .{rect.area()});
    std.debug.print("Perimeter: {}\n", .{rect.perimeter()});
    
    // Scale the rectangle
    rect.scale(2.0);
    std.debug.print("After scaling: {}x{}\n", .{rect.width, rect.height});
    std.debug.print("New area: {}\n", .{rect.area()});
    
    std.debug.print("\n", .{});
}

const Person = struct {
    name: []const u8,
    age: u32,
    height: f32,
    
    fn introduce(self: Person) void {
        std.debug.print("Hi, I'm {s}, {} years old, {:.1}cm tall\n", .{self.name, self.age, self.height});
    }
};

const Rectangle = struct {
    width: f32,
    height: f32,
    
    fn area(self: Rectangle) f32 {
        return self.width * self.height;
    }
    
    fn perimeter(self: Rectangle) f32 {
        return 2 * (self.width + self.height);
    }
    
    fn scale(self: *Rectangle, factor: f32) void {
        self.width *= factor;
        self.height *= factor;
    }
};

// Exercise 5: Memory management with allocator
fn exercise_5() !void {
    std.debug.print("Exercise 5: Memory Management\n", .{});
    
    // Use general purpose allocator
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();
    
    // Allocate memory for a slice
    const numbers = try allocator.alloc(i32, 5);
    defer allocator.free(numbers);
    
    // Fill the slice
    for (numbers, 0..) |*num, i| {
        num.* = @intCast(i * 2);
    }
    
    std.debug.print("Allocated numbers: ", .{});
    for (numbers) |num| {
        std.debug.print("{} ", .{num});
    }
    std.debug.print("\n", .{});
    
    // Dynamic array (ArrayList)
    var list = std.ArrayList(i32).init(allocator);
    defer list.deinit();
    
    // Add elements
    try list.append(10);
    try list.append(20);
    try list.append(30);
    
    std.debug.print("ArrayList: ", .{});
    for (list.items) |item| {
        std.debug.print("{} ", .{item});
    }
    std.debug.print("\n", .{});
    
    // Remove element
    _ = list.pop();
    std.debug.print("After pop: ", .{});
    for (list.items) |item| {
        std.debug.print("{} ", .{item});
    }
    std.debug.print("\n", .{});
    
    std.debug.print("\n", .{});
}