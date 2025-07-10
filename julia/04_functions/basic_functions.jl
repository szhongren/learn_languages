# Functions in Julia

println("=== Functions in Julia ===")

# Basic function definition
function greet(name)
    return "Hello, " * name * "!"
end

# Alternative syntax
greet2(name) = "Hello, " * name * "!"

# Anonymous function
greet3 = name -> "Hello, " * name * "!"

println("Basic functions:")
println(greet("Alice"))
println(greet2("Bob"))
println(greet3("Charlie"))

# Function with multiple parameters
function add_numbers(a, b)
    return a + b
end

println("\nMultiple parameters:")
println("5 + 3 = $(add_numbers(5, 3))")

# Function with default parameters
function greet_with_title(name, title="Mr.")
    return "Hello, " * title * " " * name * "!"
end

println("\nDefault parameters:")
println(greet_with_title("Smith"))
println(greet_with_title("Johnson", "Dr."))

# Function with keyword arguments
function create_person(name; age=25, city="Unknown")
    return "Name: $name, Age: $age, City: $city"
end

println("\nKeyword arguments:")
println(create_person("Alice"))
println(create_person("Bob", age=30))
println(create_person("Charlie", city="Boston", age=35))

# Function with variable arguments
function sum_all(numbers...)
    total = 0
    for num in numbers
        total += num
    end
    return total
end

println("\nVariable arguments:")
println("Sum of 1, 2, 3: $(sum_all(1, 2, 3))")
println("Sum of 1, 2, 3, 4, 5: $(sum_all(1, 2, 3, 4, 5))")

# Function returning multiple values
function divide_and_remainder(a, b)
    return a ÷ b, a % b
end

println("\nMultiple return values:")
quotient, remainder = divide_and_remainder(17, 5)
println("17 ÷ 5 = $quotient remainder $remainder")

# Function with type annotations
function typed_add(x::Int, y::Int)::Int
    return x + y
end

println("\nType annotations:")
println("typed_add(5, 3) = $(typed_add(5, 3))")

# Higher-order functions
function apply_twice(f, x)
    return f(f(x))
end

square(x) = x * x
increment(x) = x + 1

println("\nHigher-order functions:")
println("square(3) = $(square(3))")
println("apply_twice(square, 3) = $(apply_twice(square, 3))")
println("apply_twice(increment, 5) = $(apply_twice(increment, 5))")

# Functions as parameters
function process_array(arr, func)
    result = []
    for item in arr
        push!(result, func(item))
    end
    return result
end

numbers = [1, 2, 3, 4, 5]
println("\nFunctions as parameters:")
println("Original: $numbers")
println("Squared: $(process_array(numbers, square))")
println("Incremented: $(process_array(numbers, increment))")

# Anonymous functions in higher-order functions
println("\nAnonymous functions:")
doubled = process_array(numbers, x -> x * 2)
cubed = process_array(numbers, x -> x^3)
println("Doubled: $doubled")
println("Cubed: $cubed")

# Closures
function make_multiplier(factor)
    function multiplier(x)
        return x * factor
    end
    return multiplier
end

println("\nClosures:")
times_two = make_multiplier(2)
times_three = make_multiplier(3)
println("times_two(5) = $(times_two(5))")
println("times_three(4) = $(times_three(4))")

# Recursive functions
function factorial(n)
    if n <= 1
        return 1
    else
        return n * factorial(n - 1)
    end
end

function fibonacci(n)
    if n <= 1
        return n
    else
        return fibonacci(n - 1) + fibonacci(n - 2)
    end
end

println("\nRecursive functions:")
println("factorial(5) = $(factorial(5))")
println("fibonacci(7) = $(fibonacci(7))")

# Function composition
function compose(f, g)
    return x -> f(g(x))
end

add_one(x) = x + 1
multiply_by_two(x) = x * 2

println("\nFunction composition:")
add_then_multiply = compose(multiply_by_two, add_one)
println("add_then_multiply(5) = $(add_then_multiply(5))")  # (5 + 1) * 2 = 12

# Built-in higher-order functions
println("\nBuilt-in higher-order functions:")
data = [1, 2, 3, 4, 5]
println("Data: $data")
println("map(square, data) = $(map(square, data))")
println("filter(x -> x > 3, data) = $(filter(x -> x > 3, data))")
println("reduce(+, data) = $(reduce(+, data))")

# Function methods and multiple dispatch preview
function describe(x::Int)
    return "This is an integer: $x"
end

function describe(x::Float64)
    return "This is a float: $x"
end

function describe(x::String)
    return "This is a string: $x"
end

println("\nMultiple dispatch preview:")
println(describe(42))
println(describe(3.14))
println(describe("hello"))

# Functions with side effects
function print_and_return(x)
    println("Processing: $x")
    return x * 2
end

println("\nFunctions with side effects:")
result = print_and_return(10)
println("Result: $result")

# Function with mutable arguments
function modify_array!(arr)
    push!(arr, 99)
    return arr
end

println("\nMutable arguments:")
test_array = [1, 2, 3]
println("Before: $test_array")
modify_array!(test_array)
println("After: $test_array")

# Do-block syntax
println("\nDo-block syntax:")
result = map([1, 2, 3, 4, 5]) do x
    x^2 + 1
end
println("Result: $result")

# Function with conditional logic
function classify_number(n)
    if n > 0
        return "positive"
    elseif n < 0
        return "negative"
    else
        return "zero"
    end
end

println("\nConditional logic in functions:")
test_numbers = [-5, 0, 3]
for num in test_numbers
    println("$num is $(classify_number(num))")
end