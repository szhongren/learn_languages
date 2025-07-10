# Metaprogramming in Julia

println("=== Metaprogramming in Julia ===")

# Expressions
println("Basic expressions:")
ex1 = :(x + y)
println("Expression: $ex1")
println("Type: $(typeof(ex1))")

# Quote blocks
println("\nQuote blocks:")
ex3 = quote
    x = 5
    y = 10
    x + y
end
println("Quote block: $ex3")

# Evaluating expressions
println("\nEvaluating expressions:")
x = 5
y = 10
result = eval(ex1)
println("eval($ex1) = $result")

# Symbols
println("\nSymbols:")
sym1 = :x
sym2 = Symbol("hello")
println("Symbol: $sym1 (type: $(typeof(sym1)))")
println("Symbol from string: $sym2")

# Macros
println("\nMacros:")
macro sayhello(name)
    return :( println("Hello, ", $name, "!") )
end

@sayhello "Alice"

# Macro with string processing
macro myprint(expr)
    return :( println("Result: ", $expr) )
end

@myprint 2 + 3

# Time macro example
println("\nTiming macro:")
println("The @time macro measures execution time of code blocks")

# Code generation
println("\nCode generation:")
function make_function(op)
    return quote
        function generated_func(x, y)
            return $op(x, y)
        end
    end
end

# Generate addition function
add_func = make_function(:+)
eval(add_func)
println("generated_func(3, 4) = $(generated_func(3, 4))")

# Generate multiplication function
mult_func = make_function(:*)
eval(mult_func)
println("generated_func(3, 4) = $(generated_func(3, 4))")

# AST manipulation
println("\nAST manipulation:")
expr = :(x + y * z)
println("Original expression: $expr")
println("Expression args: $(expr.args)")

# Modify the AST
expr.args[3].args[1] = :a  # Change y to a
println("Modified expression: $expr")

# Generated functions
println("\nGenerated functions:")
@generated function dot_product(a, b)
    n = length(a.parameters[1].parameters)
    ex = :(a[1] * b[1])
    for i in 2:n
        ex = :($ex + a[$i] * b[$i])
    end
    return ex
end

# This would work with StaticArrays
println("Generated functions create specialized code at compile time")

# Reflection
println("\nReflection:")
f(x) = x^2
println("Method signatures for f:")
for m in methods(f)
    println("  $m")
end

# Type introspection
println("\nType introspection:")
T = Int64
println("Type: $T")
println("Supertype: $(supertype(T))")
println("Subtypes of Number: [Real, Complex]")

# Macro hygiene
println("\nMacro hygiene:")
macro swap(a, b)
    quote
        temp = $a
        $a = $b
        $b = temp
    end
end

x, y = 1, 2
println("Before swap: x=$x, y=$y")
@swap x y
println("After swap: x=$x, y=$y")

# String macros
println("\nString macros:")
macro r_str(s)
    Regex(s)
end

pattern = r"[0-9]+"
text = "I have 42 apples"
match_result = match(pattern, text)
println("Regex match: $match_result")

# Interpolation in macros
println("\nInterpolation in macros:")
macro debug(var)
    quote
        println($(string(var)), " = ", $var)
    end
end

value = 42
@debug value

# Advanced metaprogramming patterns
println("\nAdvanced patterns:")
println("- Domain-specific languages (DSLs)")
println("- Code optimization")
println("- Automatic differentiation")
println("- Generic programming")
println("- Compile-time computation")

# Simple DSL example
println("\nSimple DSL example:")
macro math_ops(expr)
    if expr.head == :call
        op = expr.args[1]
        if op == :add
            return :( $(expr.args[2]) + $(expr.args[3]) )
        elseif op == :mul
            return :( $(expr.args[2]) * $(expr.args[3]) )
        end
    end
    return expr
end

result1 = @math_ops add(5, 3)
result2 = @math_ops mul(4, 7)
println("DSL add(5, 3) = $result1")
println("DSL mul(4, 7) = $result2")

println("\nMetaprogramming enables:")
println("- Code generation at compile time")
println("- Creation of domain-specific languages")
println("- Powerful macro system")
println("- Runtime code modification")
println("- Advanced optimization techniques")