(* Advanced Topics in OCaml *)

(* Class definitions *)
class counter initial_value = object
  val mutable count = initial_value
  method get = count
  method inc = count <- count + 1
  method add n = count <- count + n
  method reset = count <- 0
end

class advanced_counter initial_value = object
  inherit counter initial_value
  val mutable history = []
  method get_history = List.rev history
  method! inc = 
    history <- count :: history;
    count <- count + 1
  method! add n = 
    history <- count :: history;
    count <- count + n
end

(* CUSTOM OPERATORS:
   - OCaml allows defining custom infix operators
   - Operators are just functions with special syntax
   - Precedence and associativity rules apply *)

let demonstrate_operators () =
  Printf.printf "\n=== CUSTOM OPERATORS DEMONSTRATION ===\n";
  
  (* Define custom operators *)
  let (++) x y = x + y in                    (* Addition alias *)
  let (--) x y = x - y in                    (* Subtraction alias *)
  let (><) x y = x * y in                    (* Multiplication *)
  let (@@@) f x = f x in                     (* Function application *)
  
  (* Vector operations *)
  let vector_add (x1, y1) (x2, y2) = (x1 + x2, y1 + y2) in
  let vector_scale scalar (x, y) = (scalar * x, scalar * y) in
  
  (* Usage examples *)
  let result1 = 5 ++ 3 in
  let result2 = 10 -- 4 in
  let result3 = 6 >< 7 in
  let result4 = string_of_int @@@ 42 in
  
  Printf.printf "5 ++ 3 = %d\n" result1;
  Printf.printf "10 -- 4 = %d\n" result2;
  Printf.printf "6 >< 7 = %d\n" result3;
  Printf.printf "string_of_int @@@ 42 = %s\n" result4;
  
  (* Vector operations *)
  let v1 = (3, 4) in
  let v2 = (1, 2) in
  let v_sum = vector_add v1 v2 in
  let v_scaled = vector_scale 2 v1 in
  
  Printf.printf "Vector addition: (%d, %d) + (%d, %d) = (%d, %d)\n"
    (fst v1) (snd v1) (fst v2) (snd v2) (fst v_sum) (snd v_sum);
  Printf.printf "Vector scaling: 2 * (%d, %d) = (%d, %d)\n"
    (fst v1) (snd v1) (fst v_scaled) (snd v_scaled);
  
  (* Pipeline operator variations *)
  let (|>) x f = f x in                      (* Standard pipe *)
  let (<|) f x = f x in                      (* Reverse pipe *)
  let (>>) f g x = g (f x) in                (* Function composition *)
  
  let add_one x = x + 1 in
  let double x = x * 2 in
  let composed = add_one >> double in
  
  Printf.printf "Pipeline: 5 |> add_one |> double = %d\n" (5 |> add_one |> double);
  Printf.printf "Reverse pipe: double <| add_one <| 5 = %d\n" (double <| (add_one <| 5));
  Printf.printf "Composition: (add_one >> double) 5 = %d\n" (composed 5)

(* OBJECTS AND CLASSES:
   - OCaml supports object-oriented programming
   - Objects encapsulate data and methods
   - Classes define object templates
   - Inheritance and polymorphism supported *)

let demonstrate_objects () =
  Printf.printf "\n=== OBJECTS AND CLASSES DEMONSTRATION ===\n";
  
  (* Simple object without class *)
  let simple_counter = object
    val mutable count = 0
    method get = count
    method inc = count <- count + 1
    method reset = count <- 0
  end in
  
  Printf.printf "Initial count: %d\n" simple_counter#get;
  simple_counter#inc;
  simple_counter#inc;
  Printf.printf "After 2 increments: %d\n" simple_counter#get;
  simple_counter#reset;
  Printf.printf "After reset: %d\n" simple_counter#get;
  
  (* Using classes *)
  let counter1 = new counter 10 in
  let counter2 = new counter 5 in
  
  Printf.printf "Counter1 initial: %d\n" counter1#get;
  Printf.printf "Counter2 initial: %d\n" counter2#get;
  
  counter1#inc;
  counter2#add 3;
  
  Printf.printf "Counter1 after inc: %d\n" counter1#get;
  Printf.printf "Counter2 after add 3: %d\n" counter2#get;
  
  (* Using inherited class *)
  let adv_counter = new advanced_counter 0 in
  adv_counter#inc;
  adv_counter#add 5;
  adv_counter#inc;
  
  Printf.printf "Advanced counter value: %d\n" adv_counter#get;
  Printf.printf "History: [%s]\n" 
    (String.concat "; " (List.map string_of_int adv_counter#get_history))

(* PREPROCESSORS AND PPXS:
   - PPX (PreProcessor eXtension) allows code generation
   - Transforms OCaml AST at compile time
   - Common uses: deriving, custom syntax
   - Note: This is a conceptual demonstration *)

type person = {
  name : string;
  age : int;
  city : string;
}

let demonstrate_ppx_concepts () =
  Printf.printf "\n=== PPX CONCEPTS DEMONSTRATION ===\n";
  
  (* What ppx_deriving might generate for [@@deriving show] *)
  let show_person p = 
    Printf.sprintf "{ name = %s; age = %d; city = %s }" p.name p.age p.city
  in
  
  (* What ppx_deriving might generate for [@@deriving eq] *)
  let equal_person p1 p2 = 
    p1.name = p2.name && p1.age = p2.age && p1.city = p2.city
  in
  
  let person1 = { name = "Alice"; age = 30; city = "Paris" } in
  let person2 = { name = "Alice"; age = 30; city = "Paris" } in
  let person3 = { name = "Bob"; age = 25; city = "London" } in
  
  Printf.printf "Person1: %s\n" (show_person person1);
  Printf.printf "Person1 = Person2: %b\n" (equal_person person1 person2);
  Printf.printf "Person1 = Person3: %b\n" (equal_person person1 person3);
  
  (* Simulated ppx for JSON serialization *)
  let to_json_person p = 
    Printf.sprintf "{ \"name\": \"%s\", \"age\": %d, \"city\": \"%s\" }" 
      p.name p.age p.city
  in
  
  Printf.printf "Person1 as JSON: %s\n" (to_json_person person1);
  
  (* Simulated custom syntax extension *)
  let (let*) opt f = 
    match opt with
    | Some x -> f x
    | None -> None
  in
  
  let safe_divide x y = 
    if y = 0 then None else Some (x / y)
  in
  
  let chain_ops () =
    let* x = safe_divide 20 4 in
    let* y = safe_divide x 2 in
    let* z = safe_divide y 1 in
    Some (z + 1)
  in
  
  (match chain_ops () with
   | Some result -> Printf.printf "Chained operations result: %d\n" result
   | None -> Printf.printf "Chained operations failed\n")

(* FIRST-CLASS MODULES:
   - Modules can be treated as values
   - Pack/unpack modules dynamically
   - Enable runtime module selection *)

module type FORMATTER = sig
  val format : int -> string
end

module BinaryFormatter : FORMATTER = struct
  let format n = 
    let rec to_binary n acc =
      if n = 0 then acc
      else to_binary (n / 2) (string_of_int (n mod 2) ^ acc)
    in
    if n = 0 then "0" else to_binary n ""
end

module HexFormatter : FORMATTER = struct
  let format n = Printf.sprintf "0x%x" n
end

module DecimalFormatter : FORMATTER = struct
  let format n = string_of_int n
end

let demonstrate_first_class_modules () =
  Printf.printf "\n=== FIRST-CLASS MODULES DEMONSTRATION ===\n";
  
  (* Pack modules as values *)
  let formatters = [
    ("binary", (module BinaryFormatter : FORMATTER));
    ("hex", (module HexFormatter : FORMATTER));
    ("decimal", (module DecimalFormatter : FORMATTER));
  ] in
  
  let number = 42 in
  
  (* Use different formatters *)
  List.iter (fun (name, formatter) ->
    let module F = (val formatter : FORMATTER) in
    Printf.printf "%s format of %d: %s\n" name number (F.format number)
  ) formatters;
  
  (* Dynamic module selection *)
  let get_formatter name =
    List.assoc_opt name formatters
  in
  
  (match get_formatter "binary" with
   | Some formatter ->
       let module F = (val formatter : FORMATTER) in
       Printf.printf "Selected binary formatter: %s\n" (F.format 10)
   | None ->
       Printf.printf "Formatter not found\n")

(* GADT (Generalized Algebraic Data Types):
   - More expressive than regular ADTs
   - Type information in constructors
   - Enable type-safe DSLs *)

type _ expr =
  | Int : int -> int expr
  | Bool : bool -> bool expr
  | Add : int expr * int expr -> int expr
  | Eq : 'a expr * 'a expr -> bool expr
  | If : bool expr * 'a expr * 'a expr -> 'a expr

let rec eval : type a. a expr -> a = function
  | Int n -> n
  | Bool b -> b
  | Add (e1, e2) -> eval e1 + eval e2
  | Eq (e1, e2) -> eval e1 = eval e2
  | If (cond, then_expr, else_expr) ->
      if eval cond then eval then_expr else eval else_expr

let demonstrate_gadts () =
  Printf.printf "\n=== GADTS DEMONSTRATION ===\n";
  
  (* Type-safe expressions *)
  let expr1 = Add (Int 5, Int 3) in
  let expr2 = Eq (Int 10, Add (Int 7, Int 3)) in
  let expr3 = If (Bool true, Int 42, Int 0) in
  
  Printf.printf "5 + 3 = %d\n" (eval expr1);
  Printf.printf "10 = 7 + 3 is %b\n" (eval expr2);
  Printf.printf "if true then 42 else 0 = %d\n" (eval expr3);
  
  (* Complex expression *)
  let complex_expr = 
    If (Eq (Add (Int 2, Int 3), Int 5), 
        Add (Int 10, Int 20), 
        Int 0) in
  
  Printf.printf "Complex expression result: %d\n" (eval complex_expr)

(* RUN ALL DEMONSTRATIONS *)
let run_all () =
  demonstrate_operators ();
  demonstrate_objects ();
  demonstrate_ppx_concepts ();
  demonstrate_first_class_modules ();
  demonstrate_gadts ()