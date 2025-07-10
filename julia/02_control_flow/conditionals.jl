# Conditional Statements in Julia

println("=== Conditional Statements ===")

# Basic if-else
age = 25
if age >= 18
    println("You are an adult")
else
    println("You are a minor")
end

# If-elseif-else
score = 85
if score >= 90
    grade = "A"
elseif score >= 80
    grade = "B"
elseif score >= 70
    grade = "C"
elseif score >= 60
    grade = "D"
else
    grade = "F"
end
println("Score: $score, Grade: $grade")

# Ternary operator
temperature = 30
weather = temperature > 25 ? "hot" : "cold"
println("Temperature: " * string(temperature) * "°C, Weather: " * weather)

# Nested ternary
num = 0
result = num > 0 ? "positive" : num < 0 ? "negative" : "zero"
println("Number: $num is $result")

# Multiple conditions
hour = 14
day = "Monday"
if hour >= 9 && hour <= 17 && day != "Saturday" && day != "Sunday"
    println("Office hours")
else
    println("Outside office hours")
end

# Short-circuit evaluation
x = 5
y = 0
if y != 0 && x / y > 2
    println("Division is greater than 2")
else
    println("Cannot divide by zero or division is not greater than 2")
end

# Using logical operators
is_student = true
has_id = true
if is_student || has_id
    println("Access granted")
else
    println("Access denied")
end

# Checking types
value = 42
if isa(value, Integer)
    println("Value is an integer")
elseif isa(value, Float64)
    println("Value is a float")
else
    println("Value is something else")
end

# Pattern matching with conditions
function classify_number(n)
    if n == 0
        return "zero"
    elseif n > 0 && n % 2 == 0
        return "positive even"
    elseif n > 0 && n % 2 == 1
        return "positive odd"
    elseif n < 0 && n % 2 == 0
        return "negative even"
    else
        return "negative odd"
    end
end

numbers = [-4, -3, 0, 1, 2, 5]
for num in numbers
    println("$num is $(classify_number(num))")
end

# Checking for nothing and missing
data = [1, 2, nothing, 4, missing, 6]
for item in data
    if item === nothing
        println("Found nothing")
    elseif ismissing(item)
        println("Found missing value")
    else
        println("Found value: $item")
    end
end

# Using in operator
vowels = ['a', 'e', 'i', 'o', 'u']
letter = 'e'
if letter in vowels
    println("'$letter' is a vowel")
else
    println("'$letter' is not a vowel")
end

# Checking ranges
test_score = 75
if test_score in 90:100
    println("Excellent!")
elseif test_score in 80:89
    println("Good job!")
elseif test_score in 70:79
    println("Fair")
else
    println("Needs improvement")
end