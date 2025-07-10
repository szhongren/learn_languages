# Modules and Packages in Julia

println("=== Modules and Packages ===")

# Creating a simple module
module MathUtils
    export add, multiply, PI_APPROX
    
    const PI_APPROX = 3.14159
    
    function add(x, y)
        return x + y
    end
    
    function multiply(x, y)
        return x * y
    end
    
    # Private function (not exported)
    function private_func()
        return "This is private"
    end
end

# Using the module
using .MathUtils

println("Using custom module:")
println("add(5, 3) = $(add(5, 3))")
println("multiply(4, 7) = $(multiply(4, 7))")
println("PI_APPROX = $(PI_APPROX)")

# Module with submodules
module Statistics
    export mean, median
    
    module BasicStats
        export mean, variance
        
        function mean(data)
            return sum(data) / length(data)
        end
        
        function variance(data)
            m = mean(data)
            return sum((x - m)^2 for x in data) / length(data)
        end
    end
    
    using .BasicStats
    
    function median(data)
        sorted_data = sort(data)
        n = length(sorted_data)
        if n % 2 == 1
            return sorted_data[n ÷ 2 + 1]
        else
            return (sorted_data[n ÷ 2] + sorted_data[n ÷ 2 + 1]) / 2
        end
    end
end

using .Statistics

println("\nUsing nested modules:")
test_data = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
println("Data: $test_data")
println("Mean: $(mean(test_data))")
println("Median: $(median(test_data))")

# Standard library modules
println("\nStandard library modules:")

# Using Random
import Random
Random.seed!(42)
random_numbers = [Random.rand() for _ in 1:5]
println("Random numbers: $random_numbers")

# Using Dates
import Dates
today = Dates.today()
println("Today's date: $today")

# Using JSON (if available)
try
    import JSON
    data = Dict("name" => "Alice", "age" => 30)
    json_string = JSON.json(data)
    println("JSON: $json_string")
catch e
    println("JSON package not available: $e")
end

# Package management commands (commented out for safety)
println("\nPackage management:")
println("# To install a package: Pkg.add(\"PackageName\")")
println("# To update packages: Pkg.update()")
println("# To remove a package: Pkg.rm(\"PackageName\")")
println("# To see installed packages: Pkg.status()")

# Creating a package structure example
println("\nPackage structure:")
println("MyPackage/")
println("├── Project.toml")
println("├── src/")
println("│   └── MyPackage.jl")
println("├── test/")
println("│   └── runtests.jl")
println("└── docs/")
println("    └── make.jl")

# Module import patterns
println("\nImport patterns:")
println("using Module          # brings exported names into scope")
println("import Module         # brings Module into scope")
println("import Module: func   # brings specific function into scope")
println("using Module: func    # brings specific function into scope")

# Conditional imports
println("\nConditional imports:")
if VERSION >= v"1.6"
    println("Julia version 1.6 or higher detected")
else
    println("Older Julia version detected")
end

println("\nModule system provides:")
println("- Namespacing")
println("- Code organization")
println("- Dependency management")
println("- Precompilation")
println("- Version control")