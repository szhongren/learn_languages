# Input and Output in Julia

println("=== Input and Output ===")

# Basic printing
println("Hello, World!")
print("This doesn't add a newline")
print(" - continuing on same line\n")

# Printing with variables
name = "Julia"
julia_version = 1.7
println("Welcome to " * name * " " * string(julia_version) * "!")

# Printf-style formatting
using Printf
temperature = 23.456789
@printf "Temperature: %.2f°C\n" temperature

# Printing different types
numbers = [1, 2, 3, 4, 5]
println("Array: $numbers")

person = Dict("name" => "Alice", "age" => 30)
println("Dictionary: $person")

# Multiple print statements
println("First line")
println("Second line")
println("Third line")

# Print with separator
println("A", "B", "C")  # Default separator is space

# Printing to stderr
println(stderr, "This is an error message")

# String interpolation in printing
x = 10
y = 20
println("The sum of $x and $y is $(x + y)")

# Printing with different formats
println("Integer: $(42)")
println("Float: $(3.14159)")
println("Scientific notation: $(1.23e-4)")
println("Hexadecimal: $(0x2A)")
println("Binary: $(0b101010)")

# Formatting with alignment
println("Right aligned: $(lpad("Hello", 10))")
println("Left aligned: $(rpad("Hello", 10))")

# Multi-line strings
multiline = """
This is a
multi-line
string in Julia
"""
println("Multi-line string:")
println(multiline)

# Raw strings (no interpolation)
raw_string = raw"This is a raw string with $variable"
println("Raw string: $raw_string")

# Reading input (commented out for automated testing)
# println("What's your name?")
# user_name = readline()
# println("Hello, $user_name!")

# Reading and parsing input
# println("Enter a number:")
# number_str = readline()
# number = parse(Int, number_str)
# println("You entered: $number")

# File I/O example
filename = "temp_output.txt"
println("\nFile I/O Example:")

# Writing to a file
open(filename, "w") do file
    println(file, "Hello, file!")
    println(file, "This is line 2")
    println(file, "Numbers: $(1:5)")
end

# Reading from a file
content = open(filename, "r") do file
    read(file, String)
end
println("File content:")
println(content)

# Clean up
rm(filename)
println("Temporary file removed")