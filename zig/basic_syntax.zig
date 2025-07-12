const std = @import("std");

pub fn main() void {
    std.debug.print("=== Zig Basic Syntax Examples ===\n\n", .{});
    
    // Variables and types
    variables_and_types();
    
    // Control flow
    control_flow();
    
    // Functions
    functions_demo();
    
    // Arrays and slices
    arrays_and_slices();
    
    // Structs
    structs_demo();
    
    // Enums
    enums_demo();
    
    // Error handling
    error_handling_demo();
    
    // Memory management
    memory_management();
}

fn variables_and_types() void {
    std.debug.print("1. VARIABLES AND TYPES\n", .{});
    
    // Immutable by default
    const x = 42;
    std.debug.print("Constant x: {}\n", .{x});
    
    // Mutable variables
    var y: i32 = 10;
    y += 5;
    std.debug.print("Mutable y: {}\n", .{y});
    
    // Type inference
    const z = 3.14; // f64
    std.debug.print("Inferred type z: {}\n", .{z});
    
    // Explicit types
    const a: u8 = 255;
    const b: i16 = -1000;
    std.debug.print("u8 a: {}, i16 b: {}\n", .{ a, b });
    
    // Booleans
    const is_true = true;
    const is_false = false;
    std.debug.print("Boolean: {} {}\n", .{ is_true, is_false });
    
    std.debug.print("\n", .{});
}

fn control_flow() void {
    std.debug.print("2. CONTROL FLOW\n", .{});
    
    // If statements
    const x = 10;
    if (x > 5) {
        std.debug.print("x is greater than 5\n", .{});
    } else {
        std.debug.print("x is not greater than 5\n", .{});
    }
    
    // Switch statements
    const day = 3;
    switch (day) {
        1 => std.debug.print("Monday\n", .{}),
        2 => std.debug.print("Tuesday\n", .{}),
        3 => std.debug.print("Wednesday\n", .{}),
        else => std.debug.print("Other day\n", .{}),
    }
    
    // For loops
    std.debug.print("Counting 1 to 5: ", .{});
    for (1..6) |i| {
        std.debug.print("{} ", .{i});
    }
    std.debug.print("\n", .{});
    
    // While loops
    var i: u8 = 0;
    std.debug.print("While loop: ", .{});
    while (i < 3) {
        std.debug.print("{} ", .{i});
        i += 1;
    }
    std.debug.print("\n", .{});
    
    std.debug.print("\n", .{});
}

fn functions_demo() void {
    std.debug.print("3. FUNCTIONS\n", .{});
    
    const result = add(5, 3);
    std.debug.print("5 + 3 = {}\n", .{result});
    
    const factorial_result = factorial(5);
    std.debug.print("5! = {}\n", .{factorial_result});
    
    // Function with multiple return values
    const a, const b = swap(10, 20);
    std.debug.print("Swapped: {} and {}\n", .{ a, b });
    
    std.debug.print("\n", .{});
}

fn add(a: i32, b: i32) i32 {
    return a + b;
}

fn factorial(n: u32) u32 {
    if (n <= 1) return 1;
    return n * factorial(n - 1);
}

fn swap(a: i32, b: i32) struct { i32, i32 } {
    return .{ b, a };
}

fn arrays_and_slices() void {
    std.debug.print("4. ARRAYS AND SLICES\n", .{});
    
    // Arrays
    const arr = [_]i32{ 1, 2, 3, 4, 5 };
    std.debug.print("Array: ", .{});
    for (arr) |item| {
        std.debug.print("{} ", .{item});
    }
    std.debug.print("\n", .{});
    
    // Slices
    const slice = arr[1..4];
    std.debug.print("Slice [1..4]: ", .{});
    for (slice) |item| {
        std.debug.print("{} ", .{item});
    }
    std.debug.print("\n", .{});
    
    // Array with index
    std.debug.print("Array with indices: ", .{});
    for (arr, 0..) |item, index| {
        std.debug.print("{}:{} ", .{ index, item });
    }
    std.debug.print("\n", .{});
    
    std.debug.print("\n", .{});
}

fn structs_demo() void {
    std.debug.print("5. STRUCTS\n", .{});
    
    const person = Person{
        .name = "Alice",
        .age = 30,
        .is_student = false,
    };
    
    std.debug.print("Person: {s}, age {}, student: {}\n", .{ person.name, person.age, person.is_student });
    
    // Method call
    person.greet();
    
    // Struct with methods
    var rectangle = Rectangle{ .width = 10, .height = 5 };
    const area = rectangle.area();
    std.debug.print("Rectangle area: {}\n", .{area});
    
    rectangle.scale(2);
    std.debug.print("Scaled rectangle: {}x{}\n", .{ rectangle.width, rectangle.height });
    
    std.debug.print("\n", .{});
}

const Person = struct {
    name: []const u8,
    age: u32,
    is_student: bool,
    
    fn greet(self: Person) void {
        std.debug.print("Hello, my name is {s}\n", .{self.name});
    }
};

const Rectangle = struct {
    width: f32,
    height: f32,
    
    fn area(self: Rectangle) f32 {
        return self.width * self.height;
    }
    
    fn scale(self: *Rectangle, factor: f32) void {
        self.width *= factor;
        self.height *= factor;
    }
};

fn enums_demo() void {
    std.debug.print("6. ENUMS\n", .{});
    
    const color = Color.Red;
    switch (color) {
        Color.Red => std.debug.print("Color is red\n", .{}),
        Color.Green => std.debug.print("Color is green\n", .{}),
        Color.Blue => std.debug.print("Color is blue\n", .{}),
    }
    
    // Tagged unions (enums with data)
    const shape = Shape{ .Circle = 5.0 };
    switch (shape) {
        Shape.Circle => |radius| std.debug.print("Circle with radius {}\n", .{radius}),
        Shape.Rectangle => |rect| std.debug.print("Rectangle {}x{}\n", .{ rect.width, rect.height }),
        Shape.Triangle => |tri| std.debug.print("Triangle with base {} and height {}\n", .{ tri.base, tri.height }),
    }
    
    std.debug.print("\n", .{});
}

const Color = enum {
    Red,
    Green,
    Blue,
};

const Shape = union(enum) {
    Circle: f32,
    Rectangle: struct { width: f32, height: f32 },
    Triangle: struct { base: f32, height: f32 },
};

fn error_handling_demo() void {
    std.debug.print("7. ERROR HANDLING\n", .{});
    
    // Try with error handling
    const result = divide(10, 2) catch |err| {
        std.debug.print("Error: {}\n", .{err});
        return;
    };
    std.debug.print("10 / 2 = {}\n", .{result});
    
    // Try with zero division
    const zero_result = divide(10, 0) catch |err| blk: {
        std.debug.print("Caught error: {}\n", .{err});
        break :blk 0;
    };
    std.debug.print("10 / 0 = {} (handled)\n", .{zero_result});
    
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

fn memory_management() void {
    std.debug.print("8. MEMORY MANAGEMENT\n", .{});
    
    // Stack allocation
    const stack_array = [_]i32{1, 2, 3, 4, 5};
    std.debug.print("Stack array: ", .{});
    for (stack_array) |item| {
        std.debug.print("{} ", .{item});
    }
    std.debug.print("\n", .{});
    
    // Heap allocation would require an allocator
    // This demonstrates the concept without actual allocation
    std.debug.print("Zig requires explicit allocator for heap allocation\n", .{});
    std.debug.print("This ensures memory safety and no hidden allocations\n", .{});
    
    std.debug.print("\n", .{});
}