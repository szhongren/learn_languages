(* Basic OCaml syntax and concepts *)

(* FUNCTION DEFINITIONS:
   - Functions are defined with 'let function_name parameters = body'
   - The '()' parameter means the function takes no arguments (unit type)
   - Function names use snake_case convention
   - No explicit return statement - the last expression is returned *)
let hello_world () = print_endline "Hello, OCaml!"

(* VARIABLE BINDING AND BASIC TYPES:
   - Variables are bound with 'let variable_name = value'
   - OCaml has type inference - types are automatically determined
   - 'in' keyword creates local bindings within an expression
   - Basic types: int, float, string, bool *)
let basic_types () =
  let x = 42 in          (* int: 32-bit signed integer *)
  let y = 3.14 in        (* float: 64-bit floating point *)
  let name = "OCaml" in  (* string: immutable text *)
  let flag = true in     (* bool: true or false *)
  (* Printf.printf uses format specifiers: %d=int, %.2f=float with 2 decimals, %s=string, %b=bool *)
  Printf.printf "Integer: %d, Float: %.2f, String: %s, Boolean: %b\n" x y name flag

(* FUNCTION DEFINITIONS AND PIPES:
   - Functions can take multiple parameters: 'let func param1 param2 = ...'
   - Functions are curried by default (partial application supported)
   - The pipe operator '|>' passes the result of left side to right side
   - Equivalent to: multiply 2 (add 5 3) *)
let functions () =
  let add x y = x + y in       (* Function taking two int parameters *)
  let multiply x y = x * y in  (* Another function taking two int parameters *)
  let result = add 5 3 |> multiply 2 in  (* Pipe: (5 + 3) * 2 = 16 *)
  Printf.printf "Result: %d\n" result

(* PATTERN MATCHING:
   - 'match expression with' starts pattern matching
   - Each pattern starts with '|' followed by pattern -> result
   - Patterns are checked top to bottom, first match wins
   - 'when' adds guard conditions to patterns
   - '_' is wildcard pattern (matches anything)
   - Pattern matching must be exhaustive (all cases covered) *)
let pattern_matching () =
  let describe_number n =
    match n with
    | 0 -> "zero"              (* Exact match for 0 *)
    | 1 -> "one"               (* Exact match for 1 *)
    | n when n > 0 -> "positive"  (* Variable binding with guard condition *)
    | _ -> "negative"          (* Wildcard catches all remaining cases *)
  in
  (* List.iter applies function to each element; 'fun' creates anonymous function *)
  List.iter (fun n -> Printf.printf "%d is %s\n" n (describe_number n)) [0; 1; 5; -3]

(* LISTS AND RECURSION:
   - Lists are immutable, homogeneous collections
   - 'rec' keyword is required for recursive functions
   - 'function' is shorthand for 'fun x -> match x with'
   - List construction: element :: rest_of_list
   - List literal: [element1; element2; ...]
   - Empty list: []
   - Lists are linked lists, not arrays *)
let lists_and_recursion () =
  let rec sum_list = function  (* 'rec' allows function to call itself *)
    | [] -> 0                  (* Base case: empty list sums to 0 *)
    | head :: tail -> head + sum_list tail  (* Recursive case: head + sum of tail *)
  in
  let numbers = [1; 2; 3; 4; 5] in  (* List literal syntax *)
  let total = sum_list numbers in
  Printf.printf "Sum of [1;2;3;4;5] = %d\n" total

(* OPTION TYPE:
   - Option type represents values that might not exist
   - 'Some value' wraps an existing value
   - 'None' represents absence of value
   - Safer than null pointers - forces explicit handling
   - Common pattern for error handling without exceptions *)
let options () =
  let safe_divide x y =
    if y = 0 then None        (* Return None for division by zero *)
    else Some (x / y)         (* Return Some with the result *)
  in
  let handle_result = function
    | Some value -> Printf.printf "Result: %d\n" value     (* Extract value from Some *)
    | None -> Printf.printf "Division by zero!\n"          (* Handle None case *)
  in
  handle_result (safe_divide 10 2);  (* Returns Some 5 *)
  handle_result (safe_divide 10 0)   (* Returns None *)

(* HIGHER ORDER FUNCTIONS:
   - Functions that take other functions as arguments
   - Functions that return functions
   - Common patterns: map, filter, fold
   - Enable functional programming style *)
let higher_order_functions () =
  let numbers = [1; 2; 3; 4; 5] in
  
  (* Map: apply function to each element *)
  let squared = List.map (fun x -> x * x) numbers in
  Printf.printf "Squared: [%s]\n" (String.concat "; " (List.map string_of_int squared));
  
  (* Filter: keep elements that satisfy predicate *)
  let evens = List.filter (fun x -> x mod 2 = 0) numbers in
  Printf.printf "Evens: [%s]\n" (String.concat "; " (List.map string_of_int evens));
  
  (* Fold: reduce list to single value *)
  let sum = List.fold_left (+) 0 numbers in
  let product = List.fold_left ( * ) 1 numbers in
  Printf.printf "Sum: %d, Product: %d\n" sum product;
  
  (* Function composition *)
  let double x = x * 2 in
  let add_one x = x + 1 in
  let double_then_add_one = fun x -> x |> double |> add_one in
  Printf.printf "double_then_add_one 5 = %d\n" (double_then_add_one 5)

(* LABELLED AND OPTIONAL ARGUMENTS:
   - Labels make function calls more readable
   - Optional arguments have default values
   - Syntax: ~label:value for labeled, ?label:value for optional *)
let labelled_and_optional () =
  (* Function with labeled arguments *)
  let create_person ~name ~age ~city = 
    Printf.sprintf "%s, %d years old, from %s" name age city in
  
  (* Function with optional arguments *)
  let greet ?title name = 
    match title with
    | Some t -> Printf.sprintf "Hello, %s %s!" t name
    | None -> Printf.sprintf "Hello, %s!" name in
  
  (* Function with optional argument with default *)
  let power ?(exp=2) base = 
    let rec pow b e acc = 
      if e = 0 then acc 
      else pow b (e-1) (acc * b) in
    pow base exp 1 in
  
  (* Usage examples *)
  let person = create_person ~name:"Alice" ~age:30 ~city:"Paris" in
  Printf.printf "%s\n" person;
  
  Printf.printf "%s\n" (greet "Alice");
  Printf.printf "%s\n" (greet ~title:"Dr." "Smith");
  
  Printf.printf "2^3 = %d\n" (power ~exp:3 2);
  Printf.printf "5^2 = %d\n" (power 5)

(* LOOPS AND RECURSION:
   - OCaml prefers recursion over loops
   - for loops for simple iterations
   - while loops for conditional iterations
   - tail recursion for efficiency *)
let loops_and_recursion () =
  (* For loop *)
  Printf.printf "For loop: ";
  for i = 1 to 5 do
    Printf.printf "%d " i
  done;
  Printf.printf "\n";
  
  (* While loop *)
  Printf.printf "While loop: ";
  let counter = ref 1 in
  while !counter <= 5 do
    Printf.printf "%d " !counter;
    counter := !counter + 1
  done;
  Printf.printf "\n";
  
  (* Tail recursion example *)
  let rec factorial_tail n acc =
    if n <= 1 then acc
    else factorial_tail (n-1) (n * acc) in
  
  let factorial n = factorial_tail n 1 in
  Printf.printf "Factorial of 5: %d\n" (factorial 5);
  
  (* Mutual recursion *)
  let rec is_even n = 
    if n = 0 then true 
    else is_odd (n-1)
  and is_odd n = 
    if n = 0 then false 
    else is_even (n-1) in
  
  Printf.printf "Is 4 even? %b\n" (is_even 4);
  Printf.printf "Is 5 odd? %b\n" (is_odd 5)

(* PROGRAM ENTRY POINT:
   - Functions are called sequentially
   - Semicolon ';' separates statements
   - Unit type '()' is used for functions with side effects *)
let run_all () =
  hello_world ();
  basic_types ();
  functions ();
  pattern_matching ();
  lists_and_recursion ();
  options ();
  higher_order_functions ();
  labelled_and_optional ();
  loops_and_recursion ()