# Arrays in Julia

println("=== Arrays in Julia ===")

# Creating arrays
println("Creating arrays:")
arr1 = [1, 2, 3, 4, 5]
arr2 = [1.0, 2.0, 3.0]
arr3 = ["apple", "banana", "orange"]
mixed = [1, "hello", 3.14, true]

println("Integer array: $arr1")
println("Float array: $arr2")
println("String array: $arr3")
println("Mixed array: $mixed")

# Array constructors
println("\nArray constructors:")
zeros_arr = zeros(5)
ones_arr = ones(3)
range_arr = collect(1:10)
fill_arr = fill(42, 4)

println("Zeros: $zeros_arr")
println("Ones: $ones_arr")
println("Range: $range_arr")
println("Fill: $fill_arr")

# Array indexing (1-based!)
println("\nArray indexing:")
numbers = [10, 20, 30, 40, 50]
println("numbers = $numbers")
println("First element: $(numbers[1])")
println("Last element: $(numbers[end])")
println("Second to last: $(numbers[end-1])")
println("Elements 2-4: $(numbers[2:4])")

# Array slicing
println("\nArray slicing:")
data = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
println("data = $data")
println("First 3 elements: $(data[1:3])")
println("Last 3 elements: $(data[end-2:end])")
println("Every second element: $(data[1:2:end])")
println("Reversed: $(data[end:-1:1])")

# Modifying arrays
println("\nModifying arrays:")
fruits = ["apple", "banana"]
println("Original: $fruits")

# Add elements
push!(fruits, "orange")
println("After push!: $fruits")

# Remove elements
popped = pop!(fruits)
println("After pop!: $fruits (popped: $popped)")

# Insert at beginning
pushfirst!(fruits, "grape")
println("After pushfirst!: $fruits")

# Remove from beginning
shifted = popfirst!(fruits)
println("After popfirst!: $fruits (shifted: $shifted)")

# Insert at specific position
insert!(fruits, 2, "kiwi")
println("After insert!: $fruits")

# Delete at specific position
deleted = deleteat!(fruits, 2)
println("After deleteat!: $fruits")

# Array operations
println("\nArray operations:")
a = [1, 2, 3]
b = [4, 5, 6]
println("a = $a, b = $b")
println("Concatenation: $(vcat(a, b))")
println("Horizontal concatenation: $(hcat(a, b))")
println("Element-wise addition: $(a .+ b)")
println("Element-wise multiplication: $(a .* b)")

# Broadcasting
println("\nBroadcasting:")
arr = [1, 2, 3, 4, 5]
println("arr = $arr")
println("Add 10 to each: $(arr .+ 10)")
println("Square each: $(arr .^ 2)")
println("Greater than 3: $(arr .> 3)")

# Array comprehensions
println("\nArray comprehensions:")
squares = [x^2 for x in 1:5]
println("Squares: $squares")

even_squares = [x^2 for x in 1:10 if x % 2 == 0]
println("Even squares: $even_squares")

# Multi-dimensional arrays
println("\nMulti-dimensional arrays:")
matrix = [1 2 3; 4 5 6; 7 8 9]
println("Matrix:")
println(matrix)
println("Element at (2,3): $(matrix[2,3])")
println("Second row: $(matrix[2,:])")
println("Third column: $(matrix[:,3])")

# Array properties
println("\nArray properties:")
test_arr = [1, 2, 3, 4, 5]
println("Array: $test_arr")
println("Length: $(length(test_arr))")
println("Size: $(size(test_arr))")
println("Type: $(typeof(test_arr))")
println("Element type: $(eltype(test_arr))")

# Array functions
println("\nArray functions:")
values = [5, 2, 8, 1, 9, 3]
println("values = $values")
println("Sum: $(sum(values))")
println("Product: $(prod(values))")
println("Maximum: $(maximum(values))")
println("Minimum: $(minimum(values))")
println("Mean: $(sum(values)/length(values))")
println("Sorted: $(sort(values))")
println("Reverse sorted: $(sort(values, rev=true))")

# Finding elements
println("\nFinding elements:")
nums = [10, 20, 30, 20, 40]
println("nums = $nums")
println("Find first 20: $(findfirst(x -> x == 20, nums))")
println("Find all 20s: $(findall(x -> x == 20, nums))")
println("20 in array: $(20 in nums)")

# Array filtering
println("\nArray filtering:")
numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
println("numbers = $numbers")
evens = filter(x -> x % 2 == 0, numbers)
println("Even numbers: $evens")

# Array mapping
println("\nArray mapping:")
words = ["hello", "world", "julia"]
println("words = $words")
uppercased = map(uppercase, words)
println("Uppercased: $uppercased")

# Array reduction
println("\nArray reduction:")
nums = [1, 2, 3, 4, 5]
println("nums = $nums")
sum_result = reduce(+, nums)
println("Sum using reduce: $sum_result")
product_result = reduce(*, nums)
println("Product using reduce: $product_result")

# Nested arrays
println("\nNested arrays:")
nested = [[1, 2], [3, 4], [5, 6]]
println("Nested array: $nested")
println("First sub-array: $(nested[1])")
println("Element (2,1): $(nested[2][1])")

# Array copying
println("\nArray copying:")
original = [1, 2, 3]
shallow_copy = original
deep_copy = copy(original)

original[1] = 999
println("Original: $original")
println("Shallow copy: $shallow_copy")
println("Deep copy: $deep_copy")

# Array iteration
println("\nArray iteration:")
items = ["a", "b", "c"]
println("Simple iteration:")
for item in items
    println("  $item")
end

println("With index:")
for (i, item) in enumerate(items)
    println("  $i: $item")
end