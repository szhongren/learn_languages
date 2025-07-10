# Loops in Julia

println("=== Loops in Julia ===")

# For loops
println("For loop with range:")
for i in 1:5
    println("i = $i")
end

# For loop with array
fruits = ["apple", "banana", "orange"]
println("\nFor loop with array:")
for fruit in fruits
    println("I like $fruit")
end

# For loop with enumerate
println("\nFor loop with enumerate:")
for (index, fruit) in enumerate(fruits)
    println("$index: $fruit")
end

# For loop with step
println("\nFor loop with step:")
for i in 1:2:10
    println("i = $i")
end

# For loop with reverse
println("\nFor loop in reverse:")
for i in 10:-1:1
    println("Countdown: $i")
end

# Nested for loops
println("\nNested for loops (multiplication table):")
for i in 1:3
    for j in 1:3
        print("$(i*j)\t")
    end
    println()
end

# While loop
println("\nWhile loop:")
count = 1
while count <= 5
    println("Count: $count")
    global count += 1
end

# While loop with condition
println("\nWhile loop with condition:")
x = 100
while x > 1
    global x = x ÷ 2
    println("x = $x")
end

# Do-while pattern (using while true with break)
println("\nDo-while pattern:")
number = 1
while true
    println("Number: $number")
    global number *= 2
    if number > 10
        break
    end
end

# Break and continue
println("\nBreak and continue:")
for i in 1:10
    if i == 3
        continue  # Skip 3
    end
    if i == 7
        break    # Stop at 7
    end
    println("i = $i")
end

# Loop with multiple variables
println("\nLoop with multiple variables:")
for (x, y) in zip(1:3, 4:6)
    println("x = $x, y = $y, sum = $(x + y)")
end

# Loop over dictionary
person = Dict("name" => "Alice", "age" => 30, "city" => "New York")
println("\nLoop over dictionary:")
for (key, value) in person
    println("$key: $value")
end

# Loop over string characters
word = "Julia"
println("\nLoop over string characters:")
for char in word
    println("Character: $char")
end

# Comprehensions (loop-like constructs)
println("\nArray comprehension:")
squares = [x^2 for x in 1:5]
println("Squares: $squares")

# Comprehension with condition
println("\nComprehension with condition:")
even_squares = [x^2 for x in 1:10 if x % 2 == 0]
println("Even squares: $even_squares")

# Nested comprehension
println("\nNested comprehension:")
matrix = [[i*j for j in 1:3] for i in 1:3]
println("Matrix: $matrix")

# Generator expressions
println("\nGenerator expression:")
sum_of_squares = sum(x^2 for x in 1:5)
println("Sum of squares 1-5: $sum_of_squares")

# Infinite loop with break (be careful!)
println("\nInfinite loop with break:")
counter = 0
while true
    global counter += 1
    if counter > 3
        break
    end
    println("Counter: $counter")
end

# Loop with try-catch
println("\nLoop with error handling:")
numbers = [1, 2, 0, 4, 5]
for num in numbers
    try
        result = 10 / num
        println("10 / $num = $result")
    catch e
        println("Error dividing by $num: Cannot divide by zero")
    end
end

# Ranges in loops
println("\nDifferent range types:")
for i in 1:3
    println("Range 1:3, i = $i")
end

for i in range(1, 3)
    println("range(1, 3), i = $i")
end

for i in range(1, step=2, length=3)
    println("range(1, step=2, length=3), i = $i")
end