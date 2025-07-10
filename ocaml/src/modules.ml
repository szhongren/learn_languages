(* Modules and functors *)

(* MODULES:
   - Modules are namespaces that group related types, values, and functions
   - 'module Name = struct ... end' defines a module
   - Access module contents with dot notation: Module.item
   - Modules can be nested inside other modules
   - Modules help organize code and prevent name conflicts *)
module Math = struct
  let pi = 3.14159              (* Module-level constant *)
  let square x = x * x          (* Module-level function *)
  let cube x = x * x * x        (* Another module-level function *)
  
  (* NESTED MODULES:
     - Modules can contain other modules
     - Nested modules accessed with multiple dots: Math.Complex.create *)
  module Complex = struct
    type t = { real : float; imag : float }  (* Type definition in module *)
    
    let create r i = { real = r; imag = i }  (* Constructor function *)
    let add c1 c2 = { real = c1.real +. c2.real; imag = c1.imag +. c2.imag }  (* Operation *)
    let to_string c = Printf.sprintf "%.2f + %.2fi" c.real c.imag  (* String conversion *)
  end
end

(* MODULE SIGNATURES (INTERFACES):
   - 'module type NAME = sig ... end' defines a signature
   - Signatures specify what a module must provide
   - 'type' declares abstract or concrete types
   - 'val' declares function signatures
   - Polymorphic types use type variables like 'a
   - Signatures enable multiple implementations of same interface *)
module type STACK = sig
  type 'a t                               (* Abstract type for stack of 'a *)
  val empty : 'a t                        (* Empty stack value *)
  val push : 'a -> 'a t -> 'a t          (* Push function signature *)
  val pop : 'a t -> 'a * 'a t            (* Pop returns (top_element, remaining_stack) *)
  val is_empty : 'a t -> bool            (* Check if stack is empty *)
end

(* MODULE IMPLEMENTATION:
   - 'module Name : SIGNATURE = struct ... end' implements a signature
   - Concrete type definitions replace abstract ones
   - All functions from signature must be implemented
   - Implementation details are hidden from outside users *)
module ListStack : STACK = struct
  type 'a t = 'a list              (* Concrete implementation: stack as list *)
  
  let empty = []                   (* Empty stack is empty list *)
  let push x stack = x :: stack    (* Push by prepending to list *)
  let pop = function               (* Pop by pattern matching *)
    | [] -> failwith "Empty stack"             (* Error on empty stack *)
    | x :: xs -> (x, xs)                       (* Return (top, rest) *)
  let is_empty = function          (* Check emptiness *)
    | [] -> true                               (* Empty list is empty *)
    | _ -> false                               (* Non-empty list is not empty *)
end

(* MODULE USAGE EXAMPLES:
   - Demonstrate accessing module contents with dot notation
   - Show nested module access
   - Illustrate polymorphic module usage *)
let demonstrate_modules () =
  Printf.printf "Pi = %.5f\n" Math.pi;                    (* Access module constant *)
  Printf.printf "Square of 5 = %d\n" (Math.square 5);    (* Call module function *)
  
  let c1 = Math.Complex.create 3.0 2.0 in                (* Create complex number *)
  let c2 = Math.Complex.create 1.0 4.0 in                (* Create another complex number *)
  let sum = Math.Complex.add c1 c2 in                     (* Add using module function *)
  Printf.printf "(%s) + (%s) = %s\n"                     (* Display results *)
    (Math.Complex.to_string c1) 
    (Math.Complex.to_string c2) 
    (Math.Complex.to_string sum);
  
  (* PIPE OPERATOR WITH MODULES:
     - Chain operations using |> operator
     - Each function takes stack as last parameter *)
  let stack = ListStack.empty |> ListStack.push 1 |> ListStack.push 2 |> ListStack.push 3 in
  let (top, rest) = ListStack.pop stack in               (* Destructure tuple result *)
  Printf.printf "Popped: %d\n" top;
  Printf.printf "Stack empty? %b\n" (ListStack.is_empty rest)

(* FUNCTORS:
   - Functors are functions that take modules as arguments and return modules
   - Enable parameterized modules and code reuse
   - Useful for creating generic data structures *)

(* Define a functor that creates a Set module from an ordered type *)
module type ORDERED = sig
  type t
  val compare : t -> t -> int
end

module MakeSet (Ord : ORDERED) = struct
  type element = Ord.t
  type t = element list  (* Simple implementation using lists *)
  
  let empty = []
  
  let rec mem x = function
    | [] -> false
    | h :: t -> 
        let c = Ord.compare x h in
        if c = 0 then true
        else if c < 0 then false
        else mem x t
  
  let rec add x = function
    | [] -> [x]
    | h :: t ->
        let c = Ord.compare x h in
        if c = 0 then h :: t  (* Already present *)
        else if c < 0 then x :: h :: t
        else h :: add x t
  
  let elements s = s  (* Already sorted *)
end

(* Create concrete instances of the Set functor *)
module IntSet = MakeSet(struct
  type t = int
  let compare = compare
end)

module StringSet = MakeSet(struct
  type t = string
  let compare = compare
end)

(* Functor for creating a Map-like structure *)
module type PRINTABLE = sig
  type t
  val to_string : t -> string
end

module MakeLogger (P : PRINTABLE) = struct
  type t = P.t
  
  let log_value prefix value =
    Printf.printf "%s: %s\n" prefix (P.to_string value)
  
  let log_list prefix values =
    Printf.printf "%s: [%s]\n" prefix 
      (String.concat "; " (List.map P.to_string values))
end

module IntLogger = MakeLogger(struct
  type t = int
  let to_string = string_of_int
end)

let demonstrate_functors () =
  Printf.printf "\n=== FUNCTORS DEMONSTRATION ===\n";
  
  (* Using IntSet *)
  let int_set = IntSet.empty 
    |> IntSet.add 3 
    |> IntSet.add 1 
    |> IntSet.add 4 
    |> IntSet.add 1 in  (* Duplicate, should be ignored *)
  
  Printf.printf "IntSet contains 3: %b\n" (IntSet.mem 3 int_set);
  Printf.printf "IntSet contains 2: %b\n" (IntSet.mem 2 int_set);
  Printf.printf "IntSet elements: [%s]\n" 
    (String.concat "; " (List.map string_of_int (IntSet.elements int_set)));
  
  (* Using StringSet *)
  let string_set = StringSet.empty
    |> StringSet.add "hello"
    |> StringSet.add "world"
    |> StringSet.add "OCaml" in
  
  Printf.printf "StringSet elements: [%s]\n"
    (String.concat "; " (StringSet.elements string_set));
  
  (* Using Logger functor *)
  IntLogger.log_value "Current number" 42;
  IntLogger.log_list "Numbers" [1; 2; 3; 4; 5]

(* RUN ALL MODULE DEMONSTRATIONS:
   - Execute all module-related examples *)
let run_all () =
  demonstrate_modules ();
  demonstrate_functors ()