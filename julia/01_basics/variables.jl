# Variables and Basic Types in Julia

println("=== Variables and Basic Types ===")

# Variables in Julia are dynamically typed
x = 10
println("x = $x, type: $(typeof(x))")

# You can reassign variables to different types
x = "Hello, Julia!"
println("x = $x, type: $(typeof(x))")

# Numeric types
integer_var = 42
float_var = 3.14159
complex_var = 2 + 3im
rational_var = 1//3

println("\nNumeric Types:")
println("Integer: $integer_var ($(typeof(integer_var)))")
println("Float: $float_var ($(typeof(float_var)))")
println("Complex: $complex_var ($(typeof(complex_var)))")
println("Rational: $rational_var ($(typeof(rational_var)))")

# Boolean type
bool_true = true
bool_false = false
println("\nBoolean:")
println("True: $bool_true ($(typeof(bool_true)))")
println("False: $bool_false ($(typeof(bool_false)))")

# String type
greeting = "Hello"
name = "Julia"
full_greeting = greeting * ", " * name * "!"
println("\nStrings:")
println("Greeting: $greeting")
println("Name: $name")
println("Full greeting: $full_greeting")

# String interpolation
age = 25
message = "I am $age years old"
println("String interpolation: $message")

# Characters
char_a = 'a'
char_unicode = '∀'
println("\nCharacters:")
println("Character 'a': $char_a ($(typeof(char_a)))")
println("Unicode character: $char_unicode ($(typeof(char_unicode)))")

# Nothing and missing values
nothing_val = nothing
missing_val = missing
println("\nSpecial values:")
println("Nothing: $nothing_val ($(typeof(nothing_val)))")
println("Missing: $missing_val ($(typeof(missing_val)))")

# Type conversion
int_from_float = Int64(trunc(3.14))  # Use trunc for safe conversion
float_from_int = Float64(42)
string_from_int = string(42)
println("\nType conversion:")
println("Int from float (truncated): $int_from_float")
println("Float from int: $float_from_int")
println("String from int: $string_from_int")

# Constants
const PI_APPROX = 3.14159
println("\nConstants:")
println("PI approximation: $PI_APPROX")