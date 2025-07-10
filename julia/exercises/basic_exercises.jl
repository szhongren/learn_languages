# Basic Julia Exercises

println("=== Basic Julia Exercises ===")

# Exercise 1: FizzBuzz
println("Exercise 1: FizzBuzz")
println("Print numbers 1-20, but replace multiples of 3 with 'Fizz',")
println("multiples of 5 with 'Buzz', and multiples of both with 'FizzBuzz'")

for i in 1:20
    if i % 15 == 0
        println("FizzBuzz")
    elseif i % 3 == 0
        println("Fizz")
    elseif i % 5 == 0
        println("Buzz")
    else
        println(i)
    end
end

# Exercise 2: Palindrome checker
println("\nExercise 2: Palindrome Checker")
function is_palindrome(s)
    s = lowercase(replace(s, r"[^a-z]" => ""))
    return s == reverse(s)
end

test_strings = ["racecar", "hello", "A man a plan a canal Panama", "12321"]
for str in test_strings
    result = is_palindrome(str) ? "is" : "is not"
    println("'$str' $result a palindrome")
end

# Exercise 3: Prime number checker
println("\nExercise 3: Prime Number Checker")
function is_prime(n)
    if n < 2
        return false
    end
    for i in 2:sqrt(n)
        if n % i == 0
            return false
        end
    end
    return true
end

println("Prime numbers from 1 to 30:")
primes = [i for i in 1:30 if is_prime(i)]
println(primes)

# Exercise 4: Word frequency counter
println("\nExercise 4: Word Frequency Counter")
function count_words(text)
    words = split(lowercase(text), r"[^a-zA-Z]+")
    word_count = Dict{String, Int}()
    for word in words
        if word != ""
            word_count[word] = get(word_count, word, 0) + 1
        end
    end
    return word_count
end

text = "The quick brown fox jumps over the lazy dog. The dog was really lazy."
word_freq = count_words(text)
println("Word frequencies:")
for (word, count) in sort(collect(word_freq))
    println("  $word: $count")
end

# Exercise 5: Matrix operations
println("\nExercise 5: Matrix Operations")
A = [1 2 3; 4 5 6; 7 8 9]
B = [9 8 7; 6 5 4; 3 2 1]

println("Matrix A:")
println(A)
println("Matrix B:")
println(B)
println("A + B:")
println(A + B)
println("A * B:")
println(A * B)
println("Transpose of A:")
println(A')

# Exercise 6: Temperature conversion
println("\nExercise 6: Temperature Conversion")
function celsius_to_fahrenheit(c)
    return c * 9/5 + 32
end

function fahrenheit_to_celsius(f)
    return (f - 32) * 5/9
end

temperatures_c = [0, 20, 30, 100]
println("Celsius to Fahrenheit:")
for temp in temperatures_c
    f = celsius_to_fahrenheit(temp)
    println("$(temp)°C = $(f)°F")
end

# Exercise 7: Fibonacci sequence
println("\nExercise 7: Fibonacci Sequence")
function fibonacci_sequence(n)
    if n <= 0
        return Int[]
    elseif n == 1
        return [0]
    elseif n == 2
        return [0, 1]
    end
    
    fib = [0, 1]
    for i in 3:n
        push!(fib, fib[i-1] + fib[i-2])
    end
    return fib
end

fib_10 = fibonacci_sequence(10)
println("First 10 Fibonacci numbers: $fib_10")

# Exercise 8: Statistics calculator
println("\nExercise 8: Statistics Calculator")
function calculate_stats(numbers)
    n = length(numbers)
    mean_val = sum(numbers) / n
    sorted_nums = sort(numbers)
    
    # Median
    if n % 2 == 1
        median_val = sorted_nums[n ÷ 2 + 1]
    else
        median_val = (sorted_nums[n ÷ 2] + sorted_nums[n ÷ 2 + 1]) / 2
    end
    
    # Mode (most frequent value)
    freq = Dict{eltype(numbers), Int}()
    for num in numbers
        freq[num] = get(freq, num, 0) + 1
    end
    mode_val = reduce((a, b) -> freq[a] > freq[b] ? a : b, keys(freq))
    
    # Standard deviation
    variance = sum((x - mean_val)^2 for x in numbers) / n
    std_dev = sqrt(variance)
    
    return (mean=mean_val, median=median_val, mode=mode_val, std_dev=std_dev)
end

test_data = [1, 2, 2, 3, 4, 4, 4, 5, 6, 7]
stats = calculate_stats(test_data)
println("Data: $test_data")
println("Mean: $(stats.mean)")
println("Median: $(stats.median)")
println("Mode: $(stats.mode)")
println("Standard deviation: $(round(stats.std_dev, digits=2))")

# Exercise 9: String manipulation
println("\nExercise 9: String Manipulation")
function string_analysis(text)
    char_count = length(text)
    word_count = length(split(text))
    vowel_count = count(c -> c in "aeiouAEIOU", text)
    consonant_count = count(c -> c in "bcdfghjklmnpqrstvwxyzBCDFGHJKLMNPQRSTVWXYZ", text)
    
    return (chars=char_count, words=word_count, vowels=vowel_count, consonants=consonant_count)
end

sample_text = "Hello, World! This is a sample text for analysis."
analysis = string_analysis(sample_text)
println("Text: '$sample_text'")
println("Characters: $(analysis.chars)")
println("Words: $(analysis.words)")
println("Vowels: $(analysis.vowels)")
println("Consonants: $(analysis.consonants)")

# Exercise 10: Simple calculator
println("\nExercise 10: Simple Calculator")
function calculate(op, a, b)
    if op == "+"
        return a + b
    elseif op == "-"
        return a - b
    elseif op == "*"
        return a * b
    elseif op == "/"
        return b != 0 ? a / b : "Error: Division by zero"
    else
        return "Error: Unknown operation"
    end
end

operations = [("+", 10, 5), ("-", 10, 5), ("*", 10, 5), ("/", 10, 5), ("/", 10, 0)]
for (op, a, b) in operations
    result = calculate(op, a, b)
    println("$a $op $b = $result")
end

println("\nExercises completed! Try modifying these examples or creating your own variations.")