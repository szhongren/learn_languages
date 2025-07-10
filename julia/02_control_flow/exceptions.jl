# Exception Handling in Julia

println("=== Exception Handling ===")

# Basic try-catch
println("Basic try-catch:")
try
    result = 10 / 0
    println("Result: $result")
catch e
    println("Caught an error: $e")
end

# Specific exception types
println("\nCatching specific exceptions:")
try
    x = parse(Int, "not_a_number")
    println("Parsed: $x")
catch e
    if isa(e, ArgumentError)
        println("ArgumentError: Invalid number format")
    else
        println("Other error: $e")
    end
end

# Multiple catch blocks
println("\nMultiple catch blocks:")
function safe_divide(a, b)
    try
        return a / b
    catch e
        if isa(e, DivideError)
            println("Cannot divide by zero!")
            return NaN
        elseif isa(e, MethodError)
            println("Invalid types for division")
            return nothing
        else
            println("Unknown error: $e")
            return nothing
        end
    end
end

println("safe_divide(10, 2) = $(safe_divide(10, 2))")
println("safe_divide(10, 0) = $(safe_divide(10, 0))")
println("safe_divide(\"10\", 2) = $(safe_divide("10", 2))")

# Try-catch-finally
println("\nTry-catch-finally:")
function process_file(filename)
    file = nothing
    try
        # Simulate file opening
        println("Opening file: $filename")
        if filename == "nonexistent.txt"
            error("File not found")
        end
        println("Processing file...")
        # Some processing
        return "Success"
    catch e
        println("Error processing file: $e")
        return "Failed"
    finally
        println("Cleaning up resources")
        if file !== nothing
            println("Closing file")
        end
    end
end

result1 = process_file("data.txt")
println("Result: $result1")

result2 = process_file("nonexistent.txt")
println("Result: $result2")

# Throwing custom exceptions
println("\nThrowing custom exceptions:")
function check_age(age)
    if age < 0
        throw(ArgumentError("Age cannot be negative"))
    elseif age > 150
        throw(ArgumentError("Age cannot be greater than 150"))
    else
        println("Valid age: $age")
    end
end

ages = [25, -5, 200, 30]
for age in ages
    try
        check_age(age)
    catch e
        println("Error for age $age: $e")
    end
end

# Using assert for debugging
println("\nUsing assert:")
function factorial(n)
    @assert n >= 0 "Factorial is not defined for negative numbers"
    if n == 0 || n == 1
        return 1
    else
        return n * factorial(n - 1)
    end
end

try
    println("factorial(5) = $(factorial(5))")
    println("factorial(-1) = $(factorial(-1))")
catch e
    println("Assertion error: $e")
end

# Error propagation
println("\nError propagation:")
function level3()
    error("Something went wrong in level3")
end

function level2()
    level3()
end

function level1()
    try
        level2()
    catch e
        println("Caught error in level1: $e")
        rethrow()  # Re-throw the error
    end
end

try
    level1()
catch e
    println("Final catch: $e")
end

# Custom exception types
println("\nCustom exception types:")
struct CustomError <: Exception
    message::String
end

function risky_operation(x)
    if x < 0
        throw(CustomError("Input must be non-negative"))
    elseif x > 100
        throw(CustomError("Input too large"))
    else
        return sqrt(x)
    end
end

test_values = [25, -10, 150, 64]
for val in test_values
    try
        result = risky_operation(val)
        println("risky_operation($val) = $result")
    catch e
        if isa(e, CustomError)
            println("Custom error for $val: $(e.message)")
        else
            println("Unexpected error for $val: $e")
        end
    end
end

# Stack traces
println("\nStack traces:")
function deep_function()
    error("Deep error occurred")
end

function middle_function()
    deep_function()
end

function shallow_function()
    middle_function()
end

try
    shallow_function()
catch e
    println("Error: $e")
    println("Stack trace:")
    for (i, frame) in enumerate(stacktrace(catch_backtrace()))
        println("  $i: $frame")
        if i >= 5  # Limit output
            break
        end
    end
end

# Warnings
println("\nWarnings:")
function deprecated_function()
    @warn "This function is deprecated, use new_function instead"
    return "old result"
end

result = deprecated_function()
println("Result: $result")