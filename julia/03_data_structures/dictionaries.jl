# Dictionaries in Julia

println("=== Dictionaries in Julia ===")

# Creating dictionaries
println("Creating dictionaries:")
dict1 = Dict("name" => "Alice", "age" => 30, "city" => "New York")
dict2 = Dict(:name => "Bob", :age => 25, :city => "Boston")
dict3 = Dict(1 => "one", 2 => "two", 3 => "three")

println("String keys: $dict1")
println("Symbol keys: $dict2")
println("Integer keys: $dict3")

# Alternative syntax
println("\nAlternative syntax:")
person = Dict("name" => "Charlie", "age" => 35)
println("Person: $person")

# Accessing values
println("\nAccessing values:")
println("Name: $(dict1["name"])")
println("Age: $(dict1["age"])")

# Safe access with get
println("\nSafe access:")
println("City: $(get(dict1, "city", "Unknown"))")
println("Country: $(get(dict1, "country", "Unknown"))")

# Checking keys
println("\nChecking keys:")
println("Has 'name' key: $(haskey(dict1, "name"))")
println("Has 'country' key: $(haskey(dict1, "country"))")

# Adding/modifying values
println("\nAdding/modifying values:")
scores = Dict("Alice" => 85, "Bob" => 92)
println("Original scores: $scores")

scores["Charlie"] = 78
println("After adding Charlie: $scores")

scores["Alice"] = 90
println("After updating Alice: $scores")

# Removing values
println("\nRemoving values:")
delete!(scores, "Bob")
println("After removing Bob: $scores")

# Merging dictionaries
println("\nMerging dictionaries:")
dict_a = Dict("a" => 1, "b" => 2)
dict_b = Dict("b" => 3, "c" => 4)
merged = merge(dict_a, dict_b)
println("dict_a: $dict_a")
println("dict_b: $dict_b")
println("Merged: $merged")

# Dictionary properties
println("\nDictionary properties:")
test_dict = Dict("x" => 10, "y" => 20, "z" => 30)
println("Dictionary: $test_dict")
println("Length: $(length(test_dict))")
println("Keys: $(keys(test_dict))")
println("Values: $(values(test_dict))")
println("Is empty: $(isempty(test_dict))")

# Iterating over dictionaries
println("\nIterating over dictionaries:")
grades = Dict("Math" => 95, "Science" => 88, "English" => 92)

println("Key-value pairs:")
for (subject, grade) in grades
    println("  $subject: $grade")
end

println("Keys only:")
for key in keys(grades)
    println("  $key")
end

println("Values only:")
for value in values(grades)
    println("  $value")
end

# Dictionary comprehensions
println("\nDictionary comprehensions:")
squared = Dict(x => x^2 for x in 1:5)
println("Squared: $squared")

filtered = Dict(k => v for (k, v) in grades if v >= 90)
println("Grades >= 90: $filtered")

# Nested dictionaries
println("\nNested dictionaries:")
students = Dict(
    "Alice" => Dict("age" => 20, "grade" => 85),
    "Bob" => Dict("age" => 22, "grade" => 92),
    "Charlie" => Dict("age" => 19, "grade" => 78)
)

println("Students: $students")
println("Alice's age: $(students["Alice"]["age"])")
println("Bob's grade: $(students["Bob"]["grade"])")

# Dictionary of arrays
println("\nDictionary of arrays:")
data = Dict(
    "numbers" => [1, 2, 3, 4, 5],
    "strings" => ["a", "b", "c"],
    "booleans" => [true, false, true]
)

println("Data: $data")
println("First number: $(data["numbers"][1])")
println("All strings: $(data["strings"])")

# Array of dictionaries
println("\nArray of dictionaries:")
people = [
    Dict("name" => "Alice", "age" => 30),
    Dict("name" => "Bob", "age" => 25),
    Dict("name" => "Charlie", "age" => 35)
]

println("People: $people")
println("First person: $(people[1])")
println("Second person's name: $(people[2]["name"])")

# Dictionary functions
println("\nDictionary functions:")
inventory = Dict("apples" => 50, "bananas" => 30, "oranges" => 25)
println("Inventory: $inventory")

# Get all keys as array
keys_array = collect(keys(inventory))
println("Keys as array: $keys_array")

# Get all values as array
values_array = collect(values(inventory))
println("Values as array: $values_array")

# Dictionary operations
println("\nDictionary operations:")
dict_x = Dict("a" => 1, "b" => 2, "c" => 3)
dict_y = Dict("b" => 20, "c" => 30, "d" => 40)

println("dict_x: $dict_x")
println("dict_y: $dict_y")

# Merge with function for conflicts
merged_sum = merge(+, dict_x, dict_y)
println("Merged with sum: $merged_sum")

# Empty dictionary
println("\nEmpty dictionary:")
empty_dict = Dict{String, Int}()
println("Empty dict: $empty_dict")
println("Type: $(typeof(empty_dict))")

# Dictionary with default value
println("\nDictionary with default:")
default_dict = Dict("a" => 1, "b" => 2)
println("Get 'a' (exists): $(get(default_dict, "a", 0))")
println("Get 'c' (doesn't exist): $(get(default_dict, "c", 0))")

# Convert arrays to dictionary
println("\nConvert arrays to dictionary:")
keys_arr = ["name", "age", "city"]
values_arr = ["David", 28, "Chicago"]
created_dict = Dict(zip(keys_arr, values_arr))
println("Created from arrays: $created_dict")

# Dictionary sorting
println("\nDictionary sorting:")
unsorted = Dict("c" => 3, "a" => 1, "b" => 2)
sorted_pairs = sort(collect(unsorted))
println("Unsorted: $unsorted")
println("Sorted pairs: $sorted_pairs")

# Set operations on dictionaries
println("\nSet operations:")
dict1_keys = Set(keys(dict_x))
dict2_keys = Set(keys(dict_y))
println("dict_x keys: $dict1_keys")
println("dict_y keys: $dict2_keys")
println("Common keys: $(intersect(dict1_keys, dict2_keys))")
println("All keys: $(union(dict1_keys, dict2_keys))")
println("Keys only in dict_x: $(setdiff(dict1_keys, dict2_keys))")