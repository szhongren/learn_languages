# OCaml Learning Repository

A comprehensive guide to learning OCaml with detailed syntax explanations and practical examples covering all major language features.

## Repository Structure

```
src/
├── basics.ml                    # Core language features
├── data_structures.ml           # Records, variants, arrays, mutability
├── modules.ml                   # Module system and functors
├── advanced_data_structures.ml  # Maps, sets, hash tables, sequences
├── advanced_topics.ml           # Operators, objects, PPX, GADTs
├── runtime_compiler.ml          # Memory, GC, compiler concepts
├── memoization_monads.ml        # CS3110 advanced topics
└── dune                        # Build configuration

bin/
├── main.ml                     # Example runner
└── dune                        # Executable configuration

dune-project                    # Project configuration
```

## Topics Covered

### 1. Introduction & Core Features (`basics.ml`)
- ✅ Values and Functions
- ✅ Basic Data Types and Pattern Matching
- ✅ Lists and Recursion
- ✅ Higher Order Functions
- ✅ Labelled and Optional Arguments
- ✅ Loops and Recursion
- ✅ Options

### 2. Data Structures (`data_structures.ml`)
- ✅ Records
- ✅ Variant Types (Algebraic Data Types)
- ✅ Arrays and Strings
- ✅ Mutability and Imperative Control Flow

### 3. Module System (`modules.ml`)
- ✅ Modules
- ✅ Module Signatures
- ✅ Functors
- ✅ Nested Modules

### 4. Advanced Data Structures (`advanced_data_structures.ml`)
- ✅ Maps (ordered key-value pairs)
- ✅ Sets (unique elements)
- ✅ Hash Tables (mutable key-value pairs)
- ✅ Sequences (lazy streams)
- ✅ Queues (FIFO)
- ✅ Stacks (LIFO)
- ✅ Buffers (mutable strings)

### 5. Advanced Topics (`advanced_topics.ml`)
- ✅ Custom Operators
- ✅ Objects and Classes
- ✅ PPX Concepts (Preprocessor Extensions)
- ✅ First-Class Modules
- ✅ GADTs (Generalized Algebraic Data Types)

### 6. Runtime & Compiler (`runtime_compiler.ml`)
- ✅ Memory Representation of Values
- ✅ Understanding the Garbage Collector
- ✅ Compiler Frontend (lexing, parsing, type checking)
- ✅ Compiler Backend (code generation, optimization)
- ✅ Performance Considerations

### 7. CS3110 Topics (`memoization_monads.ml`)
- ✅ Memoization (caching function results)
- ✅ Monads (Option, Result, State, List)
- ✅ Advanced Memoization Techniques

### 8. Libraries With Dune
- ✅ Project structure with `dune-project`
- ✅ Library configuration
- ✅ Dependencies management
- ✅ Build system integration

## Usage

### Building the Project

```bash
# Build the project
dune build

# Run all examples
dune exec bin/main.exe

# Build and run in one command
dune exec bin/main.exe
```

### Running Individual Modules

You can also explore individual modules in the OCaml REPL:

```bash
# Start OCaml REPL with built library
dune utop

# In the REPL:
#require "learn_ocaml";;
open Learn_ocaml;;
Basics.run_all ();;
```

### Interactive Learning

Each module is self-contained and thoroughly documented. Start with `basics.ml` and progress through the files in order:

1. **basics.ml** - Start here for fundamental concepts
2. **data_structures.ml** - Learn about OCaml's type system
3. **modules.ml** - Understand code organization
4. **advanced_data_structures.ml** - Explore standard library collections
5. **advanced_topics.ml** - Dive into advanced language features
6. **runtime_compiler.ml** - Understand implementation details
7. **memoization_monads.ml** - Master advanced programming patterns

## Key Features

### Explicit Syntax Explanations
Every code example includes detailed comments explaining:
- Syntax rules and conventions
- Type system behavior
- Memory management
- Performance considerations
- Best practices

### Comprehensive Coverage
This repository covers all major OCaml topics from beginner to advanced:
- Basic syntax and semantics
- Type system and pattern matching
- Functional programming concepts
- Object-oriented features
- Module system and functors
- Advanced type system features
- Runtime and compiler internals
- Practical programming patterns

### Runnable Examples
All code is executable and demonstrates concepts with real output:
- Function definitions with explanations
- Pattern matching examples
- Data structure operations
- Module system demonstrations
- Performance comparisons
- Memory management examples

## Learning Path

### Beginner (Start Here)
1. `basics.ml` - Functions, types, pattern matching
2. `data_structures.ml` - Records, variants, arrays
3. `modules.ml` - Code organization

### Intermediate
4. `advanced_data_structures.ml` - Standard library collections
5. `advanced_topics.ml` - Objects, operators, GADTs

### Advanced
6. `runtime_compiler.ml` - Implementation details
7. `memoization_monads.ml` - Advanced patterns

## Dependencies

- OCaml >= 4.14
- Dune >= 3.0
- Unix library (for timing examples)

## Contributing

This is a learning repository. Feel free to:
- Add more examples
- Improve explanations
- Fix any issues
- Suggest new topics

## References

This repository synthesizes knowledge from:
- OCaml Manual
- Real World OCaml (RWO)
- CS3110 Cornell Course
- OCaml community best practices

## License

This educational repository is provided for learning purposes.