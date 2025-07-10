# Multiple Dispatch in Julia

println("=== Multiple Dispatch in Julia ===")

# Basic multiple dispatch
function greet(person::String)
    return "Hello, " * person * "!"
end

function greet(person::String, language::String)
    if language == "spanish"
        return "¡Hola, " * person * "!"
    elseif language == "french"
        return "Bonjour, " * person * "!"
    else
        return "Hello, " * person * "!"
    end
end

function greet(age::Int)
    if age < 18
        return "Hello, young person!"
    else
        return "Hello, adult!"
    end
end

println("Basic multiple dispatch:")
println(greet("Alice"))
println(greet("Bob", "spanish"))
println(greet(25))
println(greet(16))

# Multiple dispatch with different types
function calculate_area(radius::Float64)
    return π * radius^2
end

function calculate_area(length::Float64, width::Float64)
    return length * width
end

function calculate_area(side::Int)
    return side * side
end

println("\nCalculate area with different shapes:")
println("Circle area (radius=5.0): $(calculate_area(5.0))")
println("Rectangle area (4.0 × 3.0): $(calculate_area(4.0, 3.0))")
println("Square area (side=6): $(calculate_area(6))")

# Multiple dispatch with custom types
struct Point2D
    x::Float64
    y::Float64
end

struct Point3D
    x::Float64
    y::Float64
    z::Float64
end

function distance(p::Point2D)
    return sqrt(p.x^2 + p.y^2)
end

function distance(p::Point3D)
    return sqrt(p.x^2 + p.y^2 + p.z^2)
end

function distance(p1::Point2D, p2::Point2D)
    return sqrt((p1.x - p2.x)^2 + (p1.y - p2.y)^2)
end

function distance(p1::Point3D, p2::Point3D)
    return sqrt((p1.x - p2.x)^2 + (p1.y - p2.y)^2 + (p1.z - p2.z)^2)
end

println("\nCustom types with multiple dispatch:")
p1 = Point2D(3.0, 4.0)
p2 = Point2D(0.0, 0.0)
p3 = Point3D(1.0, 2.0, 3.0)

println("Distance from origin (2D): $(distance(p1))")
println("Distance from origin (3D): $(distance(p3))")
println("Distance between 2D points: $(distance(p1, p2))")

# Multiple dispatch with abstract types
abstract type Animal end
abstract type Mammal <: Animal end
abstract type Bird <: Animal end

struct Dog <: Mammal
    name::String
end

struct Cat <: Mammal
    name::String
end

struct Parrot <: Bird
    name::String
end

function make_sound(animal::Dog)
    return "$(animal.name) says: Woof!"
end

function make_sound(animal::Cat)
    return "$(animal.name) says: Meow!"
end

function make_sound(animal::Parrot)
    return "$(animal.name) says: Squawk!"
end

function make_sound(animal::Mammal)
    return "$(animal.name) makes a mammal sound"
end

function make_sound(animal::Animal)
    return "$(animal.name) makes some sound"
end

println("\nAbstract types and hierarchy:")
dog = Dog("Rex")
cat = Cat("Whiskers")
parrot = Parrot("Polly")

println(make_sound(dog))
println(make_sound(cat))
println(make_sound(parrot))

# Multiple dispatch with collections
function process_data(data::Vector{Int})
    return "Processing integer array: sum = $(sum(data))"
end

function process_data(data::Vector{Float64})
    return "Processing float array: mean = $(sum(data)/length(data))"
end

function process_data(data::Vector{String})
    return "Processing string array: joined = $(join(data, ", "))"
end

function process_data(data::Dict)
    return "Processing dictionary: $(length(data)) keys"
end

println("\nMultiple dispatch with collections:")
int_data = [1, 2, 3, 4, 5]
float_data = [1.1, 2.2, 3.3, 4.4, 5.5]
string_data = ["hello", "world", "julia"]
dict_data = Dict("a" => 1, "b" => 2, "c" => 3)

println(process_data(int_data))
println(process_data(float_data))
println(process_data(string_data))
println(process_data(dict_data))

# Multiple dispatch with optional parameters
function format_number(x::Int; base::Int=10)
    if base == 2
        return "Binary: $(string(x, base=2))"
    elseif base == 16
        return "Hex: $(string(x, base=16))"
    else
        return "Decimal: $x"
    end
end

function format_number(x::Float64; precision::Int=2)
    return "Float: $(round(x, digits=precision))"
end

println("\nMultiple dispatch with keyword arguments:")
println(format_number(42))
println(format_number(42, base=2))
println(format_number(42, base=16))
println(format_number(3.14159))
println(format_number(3.14159, precision=4))

# Dispatch ambiguity resolution
function ambiguous_func(x::Int, y::Any)
    return "Int, Any"
end

function ambiguous_func(x::Any, y::String)
    return "Any, String"
end

# More specific method to resolve ambiguity
function ambiguous_func(x::Int, y::String)
    return "Int, String (resolved)"
end

println("\nAmbiguity resolution:")
println(ambiguous_func(5, "hello"))
println(ambiguous_func(5, 42))
println(ambiguous_func(3.14, "world"))

# Union types in dispatch
function handle_mixed(x::Union{Int, String})
    if isa(x, Int)
        return "Got integer: $x"
    else
        return "Got string: $x"
    end
end

println("\nUnion types:")
println(handle_mixed(42))
println(handle_mixed("hello"))

# Parametric types in dispatch
function show_type(x::Vector{T}) where T
    return "Vector of $(T): $x"
end

function show_type(x::Dict{K, V}) where {K, V}
    return "Dict with key type $(K) and value type $(V)"
end

println("\nParametric types:")
println(show_type([1, 2, 3]))
println(show_type(["a", "b", "c"]))
println(show_type(Dict("a" => 1, "b" => 2)))

# Method introspection
println("\nMethod introspection:")
println("Methods for greet function:")
for method in methods(greet)
    println("  $method")
end

println("\nMethods for calculate_area function:")
for method in methods(calculate_area)
    println("  $method")
end

# Type hierarchy
println("\nType hierarchy:")
println("Int64 <: Number: $(Int64 <: Number)")
println("Float64 <: Number: $(Float64 <: Number)")
println("String <: AbstractString: $(String <: AbstractString)")
println("Vector{Int} <: AbstractArray: $(Vector{Int} <: AbstractArray)")

# Duck typing vs multiple dispatch
function quack(duck::Any)
    return "If it walks like a duck and quacks like a duck..."
end

function quack(duck::String)
    return "A duck named $duck says quack!"
end

struct RubberDuck
    name::String
end

function quack(duck::RubberDuck)
    return "$(duck.name) squeaks instead of quacking!"
end

println("\nDuck typing:")
println(quack("Donald"))
println(quack(RubberDuck("Rubber Ducky")))
println(quack(42))

# Performance benefits of multiple dispatch
println("\nPerformance note:")
println("Multiple dispatch allows Julia to generate optimized code")
println("for each specific combination of argument types at compile time.")
println("This is one of Julia's key performance advantages!")