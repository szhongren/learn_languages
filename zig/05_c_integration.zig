const std = @import("std");

pub fn main() void {
    std.debug.print("=== C Integration Concepts ===\n\n", .{});
    
    // 1. C-compatible types
    c_compatible_types_demo();
    
    // 2. C-compatible structs
    c_compatible_structs_demo();
    
    // 3. C-compatible functions
    c_compatible_functions_demo();
    
    // 4. Memory layout compatibility
    memory_layout_demo();
}

// 1. C-compatible types - types that match C ABI
fn c_compatible_types_demo() void {
    std.debug.print("1. C-COMPATIBLE TYPES\n", .{});
    
    // C integer types
    const c_int_val: c_int = 42;
    const c_long_val: c_long = 1000;
    const c_short_val: c_short = 100;
    
    std.debug.print("C int: {}, C long: {}, C short: {}\n", .{c_int_val, c_long_val, c_short_val});
    
    // C floating point types
    const c_float_val: f32 = 3.14; // c_float equivalent
    const c_double_val: f64 = 2.718281828; // c_double equivalent
    
    std.debug.print("C float: {}, C double: {}\n", .{c_float_val, c_double_val});
    
    // C character types
    const c_char_val: u8 = 'A'; // c_char equivalent
    const c_unsigned_char: u8 = 200;
    
    std.debug.print("C char: {c}, C unsigned char: {}\n", .{c_char_val, c_unsigned_char});
    
    // Size and pointer types
    const size_val: usize = 1024; // size_t equivalent
    const ptr_val: usize = 0x1000; // pointer size
    
    std.debug.print("Size type: {}, Pointer size: {}\n", .{size_val, ptr_val});
    
    std.debug.print("\n", .{});
}

// 2. C-compatible structs - extern structs match C layout
fn c_compatible_structs_demo() void {
    std.debug.print("2. C-COMPATIBLE STRUCTS\n", .{});
    
    // Regular Zig struct (may be reordered by compiler)
    const ZigStruct = struct {
        a: u8,
        b: u32,
        c: u16,
    };
    
    // C-compatible struct (guaranteed C layout)
    const CStruct = extern struct {
        a: u8,
        b: u32,
        c: u16,
    };
    
    std.debug.print("Zig struct size: {}, C struct size: {}\n", .{@sizeOf(ZigStruct), @sizeOf(CStruct)});
    
    // Create C-compatible struct
    const c_point = CPoint{
        .x = 10.5,
        .y = 20.7,
    };
    
    std.debug.print("C-compatible point: ({}, {})\n", .{c_point.x, c_point.y});
    
    // Array of C-compatible structs
    const points = [_]CPoint{
        CPoint{.x = 1.0, .y = 1.0},
        CPoint{.x = 2.0, .y = 2.0},
        CPoint{.x = 3.0, .y = 3.0},
    };
    
    std.debug.print("Points array: ", .{});
    for (points) |point| {
        std.debug.print("({}, {}) ", .{point.x, point.y});
    }
    std.debug.print("\n", .{});
    
    std.debug.print("\n", .{});
}

// C-compatible struct
const CPoint = extern struct {
    x: f64,
    y: f64,
};

// 3. C-compatible functions - extern functions can be called from C
fn c_compatible_functions_demo() void {
    std.debug.print("3. C-COMPATIBLE FUNCTIONS\n", .{});
    
    // Call C-compatible function
    const distance = calculate_distance(3.0, 4.0);
    std.debug.print("Distance from origin: {}\n", .{distance});
    
    // Call function with C-compatible struct
    var point = CPoint{.x = 5.0, .y = 12.0};
    const point_distance = calculate_point_distance(&point);
    std.debug.print("Point distance: {}\n", .{point_distance});
    
    // C-compatible function with multiple parameters
    const sum = add_numbers(10, 20, 30);
    std.debug.print("Sum: {}\n", .{sum});
    
    // C-compatible function modifying struct
    modify_point(&point, 2.0);
    std.debug.print("Modified point: ({}, {})\n", .{point.x, point.y});
    
    std.debug.print("\n", .{});
}

// C-compatible function (can be called from C)
export fn calculate_distance(x: f64, y: f64) f64 {
    return @sqrt(x * x + y * y);
}

// C-compatible function with struct pointer
export fn calculate_point_distance(point: *const CPoint) f64 {
    return @sqrt(point.x * point.x + point.y * point.y);
}

// C-compatible function with multiple parameters
export fn add_numbers(a: c_int, b: c_int, c: c_int) c_int {
    return a + b + c;
}

// C-compatible function that modifies data
export fn modify_point(point: *CPoint, scale: f64) void {
    point.x *= scale;
    point.y *= scale;
}

// 4. Memory layout compatibility
fn memory_layout_demo() void {
    std.debug.print("4. MEMORY LAYOUT COMPATIBILITY\n", .{});
    
    // Packed struct - no padding
    const PackedStruct = packed struct {
        a: u8,
        b: u16,
        c: u8,
    };
    
    // Extern struct - C-compatible layout
    const ExternStruct = extern struct {
        a: u8,
        b: u16,
        c: u8,
    };
    
    // Regular struct - Zig-optimized layout
    const RegularStruct = struct {
        a: u8,
        b: u16,
        c: u8,
    };
    
    std.debug.print("Packed struct size: {}\n", .{@sizeOf(PackedStruct)});
    std.debug.print("Extern struct size: {}\n", .{@sizeOf(ExternStruct)});
    std.debug.print("Regular struct size: {}\n", .{@sizeOf(RegularStruct)});
    
    // Alignment information
    std.debug.print("Packed struct alignment: {}\n", .{@alignOf(PackedStruct)});
    std.debug.print("Extern struct alignment: {}\n", .{@alignOf(ExternStruct)});
    std.debug.print("Regular struct alignment: {}\n", .{@alignOf(RegularStruct)});
    
    // Demonstrate field offsets
    std.debug.print("Extern struct field offsets:\n", .{});
    std.debug.print("  a: {}\n", .{@offsetOf(ExternStruct, "a")});
    std.debug.print("  b: {}\n", .{@offsetOf(ExternStruct, "b")});
    std.debug.print("  c: {}\n", .{@offsetOf(ExternStruct, "c")});
    
    std.debug.print("\n", .{});
}