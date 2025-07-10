(* Runtime & Compiler Concepts in OCaml *)

type point = { x : float; y : float }
type shape = Circle of float | Rectangle of float * float

type expr_type = TInt | TBool | TString | TArrow of expr_type * expr_type
type simple_ast = 
  | Literal of int
  | Variable of string
  | BinOp of string * simple_ast * simple_ast
  | Let of string * simple_ast * simple_ast

type bytecode = 
  | CONST of int
  | LOAD of string
  | STORE of string
  | ADD | SUB | MUL | DIV
  | PRINT

(* MEMORY REPRESENTATION OF VALUES:
   - OCaml uses a uniform representation for all values
   - Integers are tagged (last bit = 1)
   - Pointers are word-aligned (last bit = 0)
   - Blocks contain header with size and tag information *)

let demonstrate_memory_representation () =
  Printf.printf "\n=== MEMORY REPRESENTATION DEMONSTRATION ===\n";
  
  (* Integer representation *)
  let small_int = 42 in
  let large_int = 1000000 in
  Printf.printf "Small integer: %d\n" small_int;
  Printf.printf "Large integer: %d\n" large_int;
  
  (* String representation *)
  let short_string = "hi" in
  let long_string = "This is a longer string that will be allocated on the heap" in
  Printf.printf "Short string: %s (length: %d)\n" short_string (String.length short_string);
  Printf.printf "Long string: %s (length: %d)\n" long_string (String.length long_string);
  
  (* List representation (linked structure) *)
  let empty_list = [] in
  let single_item = [1] in
  let long_list = [1; 2; 3; 4; 5] in
  Printf.printf "Empty list: %s\n" (if empty_list = [] then "[]" else "not empty");
  Printf.printf "Single item list: [%s]\n" (String.concat "; " (List.map string_of_int single_item));
  Printf.printf "Long list: [%s]\n" (String.concat "; " (List.map string_of_int long_list));
  
  (* Record representation (block with fields) *)
  let p1 = { x = 1.0; y = 2.0 } in
  let p2 = { x = 3.14; y = 2.71 } in
  Printf.printf "Point 1: (%.2f, %.2f)\n" p1.x p1.y;
  Printf.printf "Point 2: (%.2f, %.2f)\n" p2.x p2.y;
  
  (* Variant representation (tagged blocks) *)
  let circle = Circle 5.0 in
  let rectangle = Rectangle (3.0, 4.0) in
  (match circle with
   | Circle r -> Printf.printf "Circle with radius %.2f\n" r
   | Rectangle (w, h) -> Printf.printf "Rectangle %.2f x %.2f\n" w h);
  (match rectangle with
   | Circle r -> Printf.printf "Circle with radius %.2f\n" r
   | Rectangle (w, h) -> Printf.printf "Rectangle %.2f x %.2f\n" w h);
  
  (* Array representation (block with elements) *)
  let int_array = [| 1; 2; 3; 4; 5 |] in
  let float_array = [| 1.0; 2.0; 3.0 |] in
  Printf.printf "Integer array: [|%s|]\n" 
    (String.concat "; " (List.map string_of_int (Array.to_list int_array)));
  Printf.printf "Float array: [|%s|]\n" 
    (String.concat "; " (List.map (Printf.sprintf "%.1f") (Array.to_list float_array)))

(* GARBAGE COLLECTOR:
   - OCaml uses a generational, stop-and-copy GC
   - Young generation (minor heap) for new allocations
   - Old generation (major heap) for long-lived objects
   - Automatic memory management with low pause times *)

let demonstrate_gc_concepts () =
  Printf.printf "\n=== GARBAGE COLLECTOR DEMONSTRATION ===\n";
  
  (* Get initial GC stats *)
  let initial_stats = Gc.stat () in
  Printf.printf "Initial GC stats:\n";
  Printf.printf "  Minor collections: %d\n" initial_stats.minor_collections;
  Printf.printf "  Major collections: %d\n" initial_stats.major_collections;
  Printf.printf "  Heap size: %d words\n" initial_stats.heap_words;
  Printf.printf "  Live data: %d words\n" initial_stats.live_words;
  
  (* Allocate many temporary objects *)
  let create_temporary_data n =
    let rec loop acc i =
      if i >= n then acc
      else 
        let temp_list = [i; i+1; i+2; i+3; i+4] in
        let temp_string = string_of_int i ^ "_temporary" in
        loop ((temp_list, temp_string) :: acc) (i + 1)
    in
    loop [] 0
  in
  
  Printf.printf "\nAllocating temporary data...\n";
  let temp_data = create_temporary_data 1000 in
  let temp_length = List.length temp_data in
  Printf.printf "Created %d temporary objects\n" temp_length;
  
  (* Force garbage collection *)
  Gc.major ();
  
  (* Get stats after allocation and GC *)
  let after_stats = Gc.stat () in
  Printf.printf "\nAfter allocation and GC:\n";
  Printf.printf "  Minor collections: %d (increased by %d)\n" 
    after_stats.minor_collections 
    (after_stats.minor_collections - initial_stats.minor_collections);
  Printf.printf "  Major collections: %d (increased by %d)\n" 
    after_stats.major_collections 
    (after_stats.major_collections - initial_stats.major_collections);
  Printf.printf "  Heap size: %d words\n" after_stats.heap_words;
  Printf.printf "  Live data: %d words\n" after_stats.live_words;
  
  (* Create long-lived data *)
  let long_lived = ref [] in
  for i = 1 to 100 do
    long_lived := (i, string_of_int i) :: !long_lived
  done;
  
  Printf.printf "\nCreated long-lived data: %d items\n" (List.length !long_lived);
  
  (* GC control *)
  let gc_control = Gc.get () in
  Printf.printf "\nGC parameters:\n";
  Printf.printf "  Minor heap size: %d words\n" gc_control.minor_heap_size;
  Printf.printf "  Major heap increment: %d words\n" gc_control.major_heap_increment;
  Printf.printf "  Space overhead: %d%%\n" gc_control.space_overhead;
  
  (* Demonstrate weak references (not collected while referenced) *)
  let weak_array = Weak.create 10 in
  let some_data = [1; 2; 3; 4; 5] in
  Weak.set weak_array 0 (Some some_data);
  Printf.printf "Weak reference set: %b\n" (Weak.check weak_array 0);
  
  (* After some operations, weak references might be collected *)
  Gc.major ();
  Printf.printf "Weak reference after GC: %b\n" (Weak.check weak_array 0)

(* COMPILER FRONTEND:
   - Lexical analysis (tokenization)
   - Syntax analysis (parsing)
   - Semantic analysis (type checking)
   - AST transformations *)

let demonstrate_compiler_frontend () =
  Printf.printf "\n=== COMPILER FRONTEND CONCEPTS ===\n";
  
  (* Simulate lexical analysis *)
  let tokenize input =
    let tokens = ref [] in
    let current_token = ref "" in
    let add_token () =
      if !current_token <> "" then (
        tokens := !current_token :: !tokens;
        current_token := ""
      )
    in
    String.iter (fun c ->
      match c with
      | ' ' | '\t' | '\n' -> add_token ()
      | '+' | '-' | '*' | '/' | '(' | ')' | '=' ->
          add_token ();
          tokens := String.make 1 c :: !tokens
      | _ -> current_token := !current_token ^ String.make 1 c
    ) input;
    add_token ();
    List.rev !tokens
  in
  
  let code = "let x = 5 + 3 * 2" in
  let tokens = tokenize code in
  Printf.printf "Source code: %s\n" code;
  Printf.printf "Tokens: [%s]\n" (String.concat "; " tokens);
  
  (* Simulate type checking *)
  let rec string_of_type = function
    | TInt -> "int"
    | TBool -> "bool"
    | TString -> "string"
    | TArrow (t1, t2) -> Printf.sprintf "(%s -> %s)" (string_of_type t1) (string_of_type t2)
  in
  
  let type_examples = [
    ("42", TInt);
    ("true", TBool);
    ("\"hello\"", TString);
    ("fun x -> x + 1", TArrow (TInt, TInt));
    ("fun x -> x", TArrow (TInt, TInt));  (* Simplified *)
  ] in
  
  Printf.printf "\nType inference examples:\n";
  List.iter (fun (expr, typ) ->
    Printf.printf "  %s : %s\n" expr (string_of_type typ)
  ) type_examples;
  
  (* Simulate AST representation *)
  let rec string_of_ast = function
    | Literal n -> string_of_int n
    | Variable v -> v
    | BinOp (op, e1, e2) -> Printf.sprintf "(%s %s %s)" (string_of_ast e1) op (string_of_ast e2)
    | Let (var, e1, e2) -> Printf.sprintf "(let %s = %s in %s)" var (string_of_ast e1) (string_of_ast e2)
  in
  
  let ast_example = 
    Let ("x", BinOp ("+", Literal 5, Literal 3), 
         BinOp ("*", Variable "x", Literal 2)) in
  
  Printf.printf "\nAST representation:\n";
  Printf.printf "  Expression: let x = 5 + 3 in x * 2\n";
  Printf.printf "  AST: %s\n" (string_of_ast ast_example)

(* COMPILER BACKEND:
   - Code generation
   - Optimization
   - Assembly output
   - Linking *)

let demonstrate_compiler_backend () =
  Printf.printf "\n=== COMPILER BACKEND CONCEPTS ===\n";
  
  (* Simulate bytecode generation *)
  let string_of_bytecode = function
    | CONST n -> Printf.sprintf "CONST %d" n
    | LOAD v -> Printf.sprintf "LOAD %s" v
    | STORE v -> Printf.sprintf "STORE %s" v
    | ADD -> "ADD"
    | SUB -> "SUB"
    | MUL -> "MUL"
    | DIV -> "DIV"
    | PRINT -> "PRINT"
  in
  
  let example_bytecode = [
    CONST 5;
    CONST 3;
    ADD;
    STORE "x";
    LOAD "x";
    CONST 2;
    MUL;
    PRINT
  ] in
  
  Printf.printf "Bytecode for 'let x = 5 + 3 in print (x * 2)':\n";
  List.iteri (fun i instr ->
    Printf.printf "  %d: %s\n" i (string_of_bytecode instr)
  ) example_bytecode;
  
  (* Simulate optimization *)
  Printf.printf "\nOptimization examples:\n";
  Printf.printf "  Constant folding: 5 + 3 -> 8\n";
  Printf.printf "  Dead code elimination: Remove unused variables\n";
  Printf.printf "  Inlining: Replace function calls with body\n";
  Printf.printf "  Tail call optimization: Convert recursion to loops\n";
  
  (* Simulate compilation statistics *)
  Printf.printf "\nCompilation statistics:\n";
  Printf.printf "  Source lines: 100\n";
  Printf.printf "  Bytecode instructions: 250\n";
  Printf.printf "  Optimized instructions: 180\n";
  Printf.printf "  Native code size: 1.2KB\n";
  Printf.printf "  Compilation time: 0.05s\n";
  
  (* Memory layout simulation *)
  Printf.printf "\nMemory layout:\n";
  Printf.printf "  Code segment: 0x1000 - 0x2000\n";
  Printf.printf "  Data segment: 0x2000 - 0x3000\n";
  Printf.printf "  Heap: 0x3000 - 0x8000\n";
  Printf.printf "  Stack: 0x8000 - 0x9000\n"

(* PERFORMANCE CONSIDERATIONS:
   - Tail recursion optimization
   - Allocation patterns
   - Cache-friendly data structures *)

let demonstrate_performance () =
  Printf.printf "\n=== PERFORMANCE CONSIDERATIONS ===\n";
  
  (* Tail recursion vs non-tail recursion *)
  let rec factorial_non_tail n =
    if n <= 1 then 1
    else n * factorial_non_tail (n - 1)
  in
  
  let rec factorial_tail n acc =
    if n <= 1 then acc
    else factorial_tail (n - 1) (n * acc)
  in
  
  let factorial n = factorial_tail n 1 in
  
  Printf.printf "Factorial 10 (non-tail): %d\n" (factorial_non_tail 10);
  Printf.printf "Factorial 10 (tail): %d\n" (factorial 10);
  
  (* Allocation patterns *)
  let time_function f x =
    let start_time = Sys.time () in
    let result = f x in
    let end_time = Sys.time () in
    (result, end_time -. start_time)
  in
  
  let list_concat_slow n =
    let rec loop acc i =
      if i >= n then acc
      else loop (acc @ [i]) (i + 1)
    in
    loop [] 0
  in
  
  let list_concat_fast n =
    let rec loop acc i =
      if i >= n then acc
      else loop (i :: acc) (i + 1)
    in
    List.rev (loop [] 0)
  in
  
  let (_result1, time1) = time_function list_concat_slow 1000 in
  let (_result2, time2) = time_function list_concat_fast 1000 in
  
  Printf.printf "Slow list building (1000 elements): %.6f seconds\n" time1;
  Printf.printf "Fast list building (1000 elements): %.6f seconds\n" time2;
  Printf.printf "Speedup: %.2fx\n" (time1 /. time2);
  
  (* Memory allocation demonstration *)
  let measure_allocation f =
    let initial_stats = Gc.stat () in
    let _ = f () in
    let final_stats = Gc.stat () in
    final_stats.minor_words -. initial_stats.minor_words
  in
  
  let allocate_lists () =
    let rec loop acc i =
      if i >= 1000 then acc
      else loop ([i; i+1; i+2] :: acc) (i + 1)
    in
    loop [] 0
  in
  
  let allocate_arrays () =
    let rec loop acc i =
      if i >= 1000 then acc
      else loop ([| i; i+1; i+2 |] :: acc) (i + 1)
    in
    loop [] 0
  in
  
  let list_allocation = measure_allocation allocate_lists in
  let array_allocation = measure_allocation allocate_arrays in
  
  Printf.printf "List allocation: %.0f words\n" list_allocation;
  Printf.printf "Array allocation: %.0f words\n" array_allocation

(* RUN ALL DEMONSTRATIONS *)
let run_all () =
  demonstrate_memory_representation ();
  demonstrate_gc_concepts ();
  demonstrate_compiler_frontend ();
  demonstrate_compiler_backend ();
  demonstrate_performance ()