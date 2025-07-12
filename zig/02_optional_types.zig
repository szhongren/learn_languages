const std = @import("std");

pub fn main() void {
    std.debug.print("=== Optional Types and Null Safety ===\n\n", .{});
    
    // 1. Optional types instead of null pointers
    optional_types_demo();
    
    // 2. Null safety
    null_safety_demo();
    
    // 3. Working with optionals
    working_with_optionals_demo();
    
    // 4. Optional pointers
    optional_pointers_demo();
}

// 1. Optional types - explicit null handling
fn optional_types_demo() void {
    std.debug.print("1. OPTIONAL TYPES\n", .{});
    
    // Optional integer - can be null or contain a value
    var maybe_number: ?i32 = 42;
    std.debug.print("Optional with value: {?}\n", .{maybe_number});
    
    // Set to null
    maybe_number = null;
    std.debug.print("Optional set to null: {?}\n", .{maybe_number});
    
    // Optional string
    var maybe_name: ?[]const u8 = "Alice";
    std.debug.print("Optional string: {?s}\n", .{maybe_name});
    
    maybe_name = null;
    std.debug.print("Optional string set to null: {?s}\n", .{maybe_name});
    
    // Optional struct
    const maybe_point: ?Point = Point{.x = 1.0, .y = 2.0};
    std.debug.print("Optional struct: x={?}, y={?}\n", .{maybe_point.?.x, maybe_point.?.y});
    
    std.debug.print("\n", .{});
}

const Point = struct {
    x: f32,
    y: f32,
};

// 2. Null safety - compile-time protection
fn null_safety_demo() void {
    std.debug.print("2. NULL SAFETY\n", .{});
    
    // Cannot use optional without checking
    var maybe_value: ?i32 = 100;
    
    // Safe access with if statement
    if (maybe_value) |value| {
        std.debug.print("Value exists: {}\n", .{value});
    } else {
        std.debug.print("Value is null\n", .{});
    }
    
    // Safe access with orelse
    const default_value = maybe_value orelse 0;
    std.debug.print("Value or default: {}\n", .{default_value});
    
    // Set to null and test again
    maybe_value = null;
    if (maybe_value) |value| {
        std.debug.print("Value exists: {}\n", .{value});
    } else {
        std.debug.print("Value is null\n", .{});
    }
    
    const default_value2 = maybe_value orelse 42;
    std.debug.print("Value or default when null: {}\n", .{default_value2});
    
    std.debug.print("\n", .{});
}

// 3. Working with optionals - practical patterns
fn working_with_optionals_demo() void {
    std.debug.print("3. WORKING WITH OPTIONALS\n", .{});
    
    // Optional chaining with if
    const maybe_person: ?Person = Person{.name = "Bob", .age = 30};
    
    if (maybe_person) |person| {
        std.debug.print("Person: {s}, age {}\n", .{person.name, person.age});
        
        // Can use the unwrapped value
        if (person.age >= 18) {
            std.debug.print("Person is an adult\n", .{});
        }
    }
    
    // Optional return from function
    const found_item = findItem(&[_]i32{1, 2, 3, 4, 5}, 3);
    if (found_item) |item| {
        std.debug.print("Found item: {}\n", .{item});
    } else {
        std.debug.print("Item not found\n", .{});
    }
    
    const not_found = findItem(&[_]i32{1, 2, 3, 4, 5}, 10);
    if (not_found) |item| {
        std.debug.print("Found item: {}\n", .{item});
    } else {
        std.debug.print("Item not found\n", .{});
    }
    
    // Optional with error handling
    const parse_result = parseNumber("123");
    if (parse_result) |number| {
        std.debug.print("Parsed number: {}\n", .{number});
    } else {
        std.debug.print("Could not parse number\n", .{});
    }
    
    std.debug.print("\n", .{});
}

const Person = struct {
    name: []const u8,
    age: u32,
};

// Function returning optional
fn findItem(items: []const i32, target: i32) ?i32 {
    for (items) |item| {
        if (item == target) {
            return item;
        }
    }
    return null;
}

// Function returning optional - simple number parser
fn parseNumber(str: []const u8) ?i32 {
    // Simple implementation - just check if it's "123"
    if (std.mem.eql(u8, str, "123")) {
        return 123;
    }
    return null;
}

// 4. Optional pointers - safe pointer handling
fn optional_pointers_demo() void {
    std.debug.print("4. OPTIONAL POINTERS\n", .{});
    
    // Optional pointer
    var number: i32 = 42;
    var maybe_ptr: ?*i32 = &number;
    
    // Safe pointer dereference
    if (maybe_ptr) |ptr| {
        std.debug.print("Pointer value: {}\n", .{ptr.*});
        
        // Can modify through pointer
        ptr.* = 100;
        std.debug.print("Modified value: {}\n", .{number});
    }
    
    // Set pointer to null
    maybe_ptr = null;
    if (maybe_ptr) |ptr| {
        std.debug.print("Pointer value: {}\n", .{ptr.*});
    } else {
        std.debug.print("Pointer is null\n", .{});
    }
    
    // Optional pointer to struct
    var point = Point{.x = 5.0, .y = 10.0};
    const maybe_point_ptr: ?*Point = &point;
    
    if (maybe_point_ptr) |ptr| {
        std.debug.print("Point via pointer: ({}, {})\n", .{ptr.x, ptr.y});
        
        // Modify through pointer
        ptr.x = 15.0;
        std.debug.print("Modified point: ({}, {})\n", .{point.x, point.y});
    }
    
    std.debug.print("\n", .{});
}