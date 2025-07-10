# Operators in Julia

println("=== Operators in Julia ===")

# Arithmetic operators
a = 10
b = 3

println("Arithmetic Operators:")
println("a = $a, b = $b")
println("Addition: a + b = $(a + b)")
println("Subtraction: a - b = $(a - b)")
println("Multiplication: a * b = $(a * b)")
println("Division: a / b = $(a / b)")
println("Integer division: a ÷ b = $(a ÷ b)")
println("Modulo: a % b = $(a % b)")
println("Power: a ^ b = $(a ^ b)")

# Comparison operators
println("\nComparison Operators:")
println("a == b: $(a == b)")
println("a != b: $(a != b)")
println("a > b: $(a > b)")
println("a < b: $(a < b)")
println("a >= b: $(a >= b)")
println("a <= b: $(a <= b)")

# Logical operators
x = true
y = false

println("\nLogical Operators:")
println("x = $x, y = $y")
println("AND: x && y = $(x && y)")
println("OR: x || y = $(x || y)")
println("NOT: !x = $(!x)")

# Bitwise operators
num1 = 12  # 1100 in binary
num2 = 10  # 1010 in binary

println("\nBitwise Operators:")
println("num1 = $num1, num2 = $num2")
println("Bitwise AND: num1 & num2 = $(num1 & num2)")
println("Bitwise OR: num1 | num2 = $(num1 | num2)")
println("Bitwise XOR: num1 ⊻ num2 = $(num1 ⊻ num2)")
println("Bitwise NOT: ~num1 = $(~num1)")
println("Left shift: num1 << 1 = $(num1 << 1)")
println("Right shift: num1 >> 1 = $(num1 >> 1)")

# Assignment operators
c = 5
println("\nAssignment Operators:")
println("Initial c = $c")

c += 3
println("After c += 3: c = $c")

c -= 2
println("After c -= 2: c = $c")

c *= 2
println("After c *= 2: c = $c")

c /= 2
println("After c /= 2: c = $c")

# Ternary operator
age = 18
status = age >= 18 ? "adult" : "minor"
println("\nTernary Operator:")
println("Age: $age, Status: $status")

# Chained comparisons
value = 5
println("\nChained Comparisons:")
println("1 < value < 10: $(1 < value < 10)")
println("0 <= value <= 3: $(0 <= value <= 3)")

# String operators
str1 = "Hello"
str2 = "World"
println("\nString Operators:")
println("Concatenation: str1 * \" \" * str2 = $(str1 * " " * str2)")
println("Repetition: str1 ^ 3 = $(str1 ^ 3)")

# Mathematical functions as operators
println("\nMathematical Functions:")
println("sqrt(16) = $(sqrt(16))")
println("abs(-5) = $(abs(-5))")
println("sin(π/2) = $(sin(π/2))")
println("log(e) = $(log(ℯ))")
println("max(3, 7, 2) = $(max(3, 7, 2))")
println("min(3, 7, 2) = $(min(3, 7, 2))")