(* Data structures and types *)

type mutable_person = {
  name : string;
  mutable age : int;                      (* Mutable field *)
  mutable city : string;
}

exception Custom_error of string

(* RECORD TYPES:
   - Records are structured data with named fields
   - Fields are separated by semicolons
   - Field types are specified with 'field_name : type'
   - Records are immutable by default
   - Similar to structs in other languages *)
type person = {
  name : string;    (* Field name with string type *)
  age : int;        (* Field age with int type *)
  email : string;   (* Field email with string type *)
}

(* VARIANT TYPES (ALGEBRAIC DATA TYPES):
   - Variants represent values that can be one of several forms
   - Each variant constructor starts with capital letter
   - Constructors can carry data (like 'float' for Circle)
   - Tuples in constructors: (type1 * type2 * ...)
   - Similar to enums but can carry different data types *)
type shape =
  | Circle of float                    (* Circle carries one float (radius) *)
  | Rectangle of float * float         (* Rectangle carries tuple (width, height) *)
  | Triangle of float * float * float  (* Triangle carries three floats (sides) *)

(* RECORD CONSTRUCTION AND FIELD ACCESS:
   - Records created with { field1 = value1; field2 = value2; ... }
   - Field access uses dot notation: record.field
   - 'with' keyword creates new record copying existing one with changes
   - All fields must be provided unless using 'with' *)
let records () =
  let alice = { name = "Alice"; age = 30; email = "alice@example.com" } in
  let bob = { alice with name = "Bob"; age = 25 } in  (* Copy alice, change name and age *)
  Printf.printf "%s is %d years old\n" alice.name alice.age;  (* Field access *)
  Printf.printf "%s is %d years old\n" bob.name bob.age

(* VARIANT PATTERN MATCHING:
   - Variants are deconstructed using pattern matching
   - Constructor names must match exactly
   - Variables in patterns extract the carried data
   - Tuples are deconstructed with (var1, var2, ...)
   - Float arithmetic uses '.' operators: +., -., *., /. *)
let variants () =
  let area = function
    | Circle r -> 3.14159 *. r *. r                    (* Extract radius 'r' *)
    | Rectangle (w, h) -> w *. h                       (* Extract width 'w' and height 'h' *)
    | Triangle (a, b, c) ->                            (* Extract three sides a, b, c *)
        let s = (a +. b +. c) /. 2.0 in               (* Heron's formula: semi-perimeter *)
        sqrt (s *. (s -. a) *. (s -. b) *. (s -. c))  (* Area calculation *)
  in
  let shapes = [
    Circle 5.0;                (* Constructor with single float *)
    Rectangle (4.0, 6.0);      (* Constructor with tuple *)
    Triangle (3.0, 4.0, 5.0);  (* Constructor with three floats *)
  ] in
  List.iter (fun shape ->
    match shape with
    | Circle r -> Printf.printf "Circle (r=%.1f): area = %.2f\n" r (area shape)
    | Rectangle (w, h) -> Printf.printf "Rectangle (%.1f×%.1f): area = %.2f\n" w h (area shape)
    | Triangle (a, b, c) -> Printf.printf "Triangle (%.1f,%.1f,%.1f): area = %.2f\n" a b c (area shape)
  ) shapes

(* ARRAYS AND STRINGS:
   - Arrays are mutable, fixed-size collections
   - Array literal: [| element1; element2; ... |]
   - Array access: array.(index)
   - Array mutation: array.(index) <- new_value
   - Strings are immutable sequences of characters
   - String functions: String.length, String.sub *)
let arrays_and_strings () =
  let arr = [| 1; 2; 3; 4; 5 |] in  (* Array literal syntax *)
  arr.(2) <- 10;                     (* Mutate element at index 2 *)
  Printf.printf "Array: [|";
  Array.iter (Printf.printf "%d; ") arr;  (* Iterate over array elements *)
  Printf.printf "|]\n";
  
  let str = "Hello, World!" in       (* String literal *)
  Printf.printf "String length: %d\n" (String.length str);        (* Get string length *)
  Printf.printf "Substring: %s\n" (String.sub str 0 5)           (* Extract substring: start=0, length=5 *)

(* MUTABILITY AND IMPERATIVE CONTROL FLOW:
   - OCaml supports mutable data structures
   - References: mutable containers for single values
   - Mutable fields in records
   - Imperative control flow with loops and conditionals *)
let mutability_and_imperative () =
  (* References - mutable containers *)
  let counter = ref 0 in                    (* Create reference with initial value *)
  Printf.printf "Initial counter: %d\n" !counter;  (* Dereference with ! *)
  counter := !counter + 1;                  (* Update with := *)
  Printf.printf "After increment: %d\n" !counter;
  
  (* Mutable record fields *)
  let person = { name = "Alice"; age = 25; city = "Paris" } in
  Printf.printf "%s is %d years old\n" person.name person.age;
  person.age <- person.age + 1;             (* Mutate field *)
  person.city <- "London";
  Printf.printf "%s is now %d years old in %s\n" person.name person.age person.city;
  
  (* Imperative control flow *)
  let arr = [| 1; 2; 3; 4; 5 |] in
  Printf.printf "Original array: ";
  Array.iter (Printf.printf "%d ") arr;
  Printf.printf "\n";
  
  (* Modify array in place *)
  for i = 0 to Array.length arr - 1 do
    arr.(i) <- arr.(i) * 2
  done;
  
  Printf.printf "Doubled array: ";
  Array.iter (Printf.printf "%d ") arr;
  Printf.printf "\n";
  
  (* Exception handling *)
  (try
    let result = 10 / 0 in
    Printf.printf "Result: %d\n" result
  with
  | Division_by_zero -> Printf.printf "Caught division by zero!\n");
  
  (* Custom exceptions *)
  (try
    raise (Custom_error "Something went wrong")
  with
  | Custom_error msg -> Printf.printf "Custom error: %s\n" msg)

(* RUN ALL DEMONSTRATIONS:
   - Execute all data structure examples in sequence *)
let run_all () =
  records ();
  variants ();
  arrays_and_strings ();
  mutability_and_imperative ()