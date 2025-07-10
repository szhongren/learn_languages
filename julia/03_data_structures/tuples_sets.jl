# Tuples and Sets in Julia

println("=== Tuples and Sets in Julia ===")

# TUPLES
println("TUPLES:")

# Creating tuples
println("\nCreating tuples:")
tuple1 = (1, 2, 3)
tuple2 = ("Alice", 30, "Engineer")
tuple3 = (1, "hello", 3.14, true)
single_tuple = (42,)  # Note the comma for single element

println("Integer tuple: $tuple1")
println("Mixed tuple: $tuple2")
println("Various types: $tuple3")
println("Single element: $single_tuple")

# Accessing tuple elements
println("\nAccessing tuple elements:")
person = ("John", 25, "Student")
println("Person: $person")
println("Name: $(person[1])")
println("Age: $(person[2])")
println("Occupation: $(person[3])")

# Tuple unpacking
println("\nTuple unpacking:")
coordinates = (10, 20)
x, y = coordinates
println("Coordinates: $coordinates")
println("x = $x, y = $y")

# Named tuples
println("\nNamed tuples:")
student = (name="Alice", age=20, grade=85)
println("Student: $student")
println("Name: $(student.name)")
println("Age: $(student.age)")
println("Grade: $(student.grade)")

# Alternative named tuple syntax
point = (x=1.0, y=2.0, z=3.0)
println("Point: $point")
println("X coordinate: $(point.x)")

# Tuple properties
println("\nTuple properties:")
test_tuple = (1, 2, 3, 4, 5)
println("Tuple: $test_tuple")
println("Length: $(length(test_tuple))")
println("Type: $(typeof(test_tuple))")
println("Element types: $(typeof.(test_tuple))")

# Tuple operations
println("\nTuple operations:")
tuple_a = (1, 2, 3)
tuple_b = (4, 5, 6)
concatenated = (tuple_a..., tuple_b...)
println("tuple_a: $tuple_a")
println("tuple_b: $tuple_b")
println("Concatenated: $concatenated")

# Tuple iteration
println("\nTuple iteration:")
colors = ("red", "green", "blue")
println("Colors:")
for color in colors
    println("  $color")
end

# Tuple comparison
println("\nTuple comparison:")
t1 = (1, 2, 3)
t2 = (1, 2, 3)
t3 = (1, 2, 4)
println("t1 = $t1, t2 = $t2, t3 = $t3")
println("t1 == t2: $(t1 == t2)")
println("t1 == t3: $(t1 == t3)")
println("t1 < t3: $(t1 < t3)")

# Tuple as function arguments
println("\nTuple as function arguments:")
function add_three(a, b, c)
    return a + b + c
end

numbers = (10, 20, 30)
result = add_three(numbers...)
println("Numbers: $numbers")
println("Sum: $result")

# Multiple return values (tuples)
println("\nMultiple return values:")
function divide_and_remainder(a, b)
    return a ÷ b, a % b
end

quotient, remainder = divide_and_remainder(17, 5)
println("17 ÷ 5 = $quotient remainder $remainder")

# SETS
println("\n\nSETS:")

# Creating sets
println("\nCreating sets:")
set1 = Set([1, 2, 3, 4, 5])
set2 = Set(["apple", "banana", "cherry"])
set3 = Set([1, 2, 2, 3, 3, 4])  # Duplicates are removed

println("Integer set: $set1")
println("String set: $set2")
println("Set with duplicates: $set3")

# Empty set
empty_set = Set{Int}()
println("Empty set: $empty_set")

# Set operations
println("\nSet operations:")
a = Set([1, 2, 3, 4, 5])
b = Set([4, 5, 6, 7, 8])
println("Set a: $a")
println("Set b: $b")
println("Union: $(union(a, b))")
println("Intersection: $(intersect(a, b))")
println("Difference (a - b): $(setdiff(a, b))")
println("Symmetric difference: $(symdiff(a, b))")

# Set membership
println("\nSet membership:")
numbers = Set([1, 2, 3, 4, 5])
println("Numbers: $numbers")
println("3 in set: $(3 in numbers)")
println("7 in set: $(7 in numbers)")

# Adding/removing elements
println("\nModifying sets:")
fruits = Set(["apple", "banana"])
println("Original: $fruits")

push!(fruits, "orange")
println("After adding orange: $fruits")

delete!(fruits, "banana")
println("After removing banana: $fruits")

# Set properties
println("\nSet properties:")
test_set = Set([1, 2, 3, 4, 5])
println("Set: $test_set")
println("Length: $(length(test_set))")
println("Is empty: $(isempty(test_set))")
println("Type: $(typeof(test_set))")

# Set iteration
println("\nSet iteration:")
animals = Set(["cat", "dog", "bird", "fish"])
println("Animals:")
for animal in animals
    println("  $animal")
end

# Set comprehensions
println("\nSet comprehensions:")
squares = Set([x^2 for x in 1:5])
println("Squares: $squares")

# Set comparisons
println("\nSet comparisons:")
set_x = Set([1, 2, 3])
set_y = Set([1, 2, 3])
set_z = Set([1, 2, 3, 4])
println("set_x: $set_x")
println("set_y: $set_y")
println("set_z: $set_z")
println("set_x == set_y: $(set_x == set_y)")
println("set_x ⊆ set_z (subset): $(set_x ⊆ set_z)")
println("set_z ⊆ set_x (subset): $(set_z ⊆ set_x)")

# Converting between collections
println("\nConverting between collections:")
array = [1, 2, 3, 2, 1]
set_from_array = Set(array)
array_from_set = collect(set_from_array)
println("Original array: $array")
println("Set from array: $set_from_array")
println("Array from set: $array_from_set")

# Set of tuples
println("\nSet of tuples:")
coordinates = Set([(1, 2), (3, 4), (1, 2), (5, 6)])
println("Coordinates: $coordinates")

# Using sets to remove duplicates
println("\nRemoving duplicates:")
words = ["apple", "banana", "apple", "cherry", "banana"]
unique_words = collect(Set(words))
println("Original: $words")
println("Unique: $unique_words")

# Set with mixed types
println("\nSet with mixed types:")
mixed_set = Set([1, "hello", 3.14, true])
println("Mixed set: $mixed_set")

# Frozen sets (immutable)
println("\nImmutable sets:")
frozen = Set([1, 2, 3])
println("Frozen set: $frozen")
println("Type: $(typeof(frozen))")