(* Advanced Data Structures in OCaml *)

(* MAPS:
   - Maps are immutable key-value data structures
   - Keys must be ordered (comparable)
   - Efficient lookup, insertion, and deletion
   - Implemented as balanced binary trees *)

module StringMap = Map.Make(String)

let demonstrate_maps () =
  Printf.printf "\n=== MAPS DEMONSTRATION ===\n";
  
  (* Create and populate a map *)
  let ages = StringMap.empty
    |> StringMap.add "Alice" 30
    |> StringMap.add "Bob" 25
    |> StringMap.add "Charlie" 35 in
  
  (* Lookup values *)
  (match StringMap.find_opt "Alice" ages with
   | Some age -> Printf.printf "Alice is %d years old\n" age
   | None -> Printf.printf "Alice not found\n");
  
  (* Check if key exists *)
  Printf.printf "Map contains Bob: %b\n" (StringMap.mem "Bob" ages);
  
  (* Update existing key *)
  let updated_ages = StringMap.add "Alice" 31 ages in
  Printf.printf "Alice's new age: %d\n" (StringMap.find "Alice" updated_ages);
  
  (* Remove key *)
  let without_bob = StringMap.remove "Bob" ages in
  Printf.printf "Map contains Bob after removal: %b\n" (StringMap.mem "Bob" without_bob);
  
  (* Iterate over map *)
  Printf.printf "All ages: ";
  StringMap.iter (fun name age -> Printf.printf "%s:%d " name age) ages;
  Printf.printf "\n";
  
  (* Map transformation *)
  let doubled_ages = StringMap.map (fun age -> age * 2) ages in
  Printf.printf "Doubled ages: ";
  StringMap.iter (fun name age -> Printf.printf "%s:%d " name age) doubled_ages;
  Printf.printf "\n"

(* SETS:
   - Sets are collections of unique elements
   - Elements must be ordered (comparable)
   - Efficient membership testing and set operations
   - Implemented as balanced binary trees *)

module IntSet = Set.Make(Int)

let demonstrate_sets () =
  Printf.printf "\n=== SETS DEMONSTRATION ===\n";
  
  (* Create and populate sets *)
  let set1 = IntSet.of_list [1; 2; 3; 4; 5] in
  let set2 = IntSet.of_list [4; 5; 6; 7; 8] in
  
  (* Membership testing *)
  Printf.printf "Set1 contains 3: %b\n" (IntSet.mem 3 set1);
  Printf.printf "Set1 contains 10: %b\n" (IntSet.mem 10 set1);
  
  (* Set operations *)
  let union_set = IntSet.union set1 set2 in
  let inter_set = IntSet.inter set1 set2 in
  let diff_set = IntSet.diff set1 set2 in
  
  let print_set name set =
    Printf.printf "%s: {%s}\n" name 
      (String.concat "; " (List.map string_of_int (IntSet.elements set))) in
  
  print_set "Set1" set1;
  print_set "Set2" set2;
  print_set "Union" union_set;
  print_set "Intersection" inter_set;
  print_set "Difference (Set1 - Set2)" diff_set;
  
  (* Set size *)
  Printf.printf "Set1 size: %d\n" (IntSet.cardinal set1);
  
  (* Filter set *)
  let evens = IntSet.filter (fun x -> x mod 2 = 0) set1 in
  print_set "Even numbers from Set1" evens

(* HASH TABLES:
   - Hash tables are mutable key-value data structures
   - Fast average-case performance for lookup/insertion
   - Keys can be any type with a hash function
   - Not ordered *)

let demonstrate_hash_tables () =
  Printf.printf "\n=== HASH TABLES DEMONSTRATION ===\n";
  
  (* Create hash table *)
  let student_grades = Hashtbl.create 10 in
  
  (* Add entries *)
  Hashtbl.add student_grades "Alice" 95;
  Hashtbl.add student_grades "Bob" 87;
  Hashtbl.add student_grades "Charlie" 92;
  
  (* Lookup values *)
  (match Hashtbl.find_opt student_grades "Alice" with
   | Some grade -> Printf.printf "Alice's grade: %d\n" grade
   | None -> Printf.printf "Alice not found\n");
  
  (* Check membership *)
  Printf.printf "Bob in table: %b\n" (Hashtbl.mem student_grades "Bob");
  
  (* Replace value *)
  Hashtbl.replace student_grades "Alice" 96;
  Printf.printf "Alice's new grade: %d\n" (Hashtbl.find student_grades "Alice");
  
  (* Remove entry *)
  Hashtbl.remove student_grades "Bob";
  Printf.printf "Bob in table after removal: %b\n" (Hashtbl.mem student_grades "Bob");
  
  (* Iterate over hash table *)
  Printf.printf "All grades: ";
  Hashtbl.iter (fun name grade -> Printf.printf "%s:%d " name grade) student_grades;
  Printf.printf "\n";
  
  (* Convert to list *)
  let grade_list = Hashtbl.fold (fun name grade acc -> (name, grade) :: acc) student_grades [] in
  Printf.printf "As list: [%s]\n" 
    (String.concat "; " (List.map (fun (n, g) -> Printf.sprintf "(%s,%d)" n g) grade_list))

(* SEQUENCES:
   - Sequences are lazy, potentially infinite streams
   - Elements computed on demand
   - Memory efficient for large or infinite data
   - Composable with functional operations *)

let demonstrate_sequences () =
  Printf.printf "\n=== SEQUENCES DEMONSTRATION ===\n";
  
  (* Create sequence from list *)
  let _seq1 = List.to_seq [1; 2; 3; 4; 5] in
  
  (* Infinite sequence *)
  let naturals = Seq.unfold (fun n -> Some (n, n + 1)) 1 in
  
  (* Transform sequences *)
  let even_squares = naturals
    |> Seq.filter (fun x -> x mod 2 = 0)
    |> Seq.map (fun x -> x * x)
    |> Seq.take 5 in
  
  Printf.printf "First 5 even squares: [%s]\n"
    (String.concat "; " (List.map string_of_int (List.of_seq even_squares)));
  
  (* Fibonacci sequence *)
  let fibonacci = 
    let rec fib_seq a b () = 
      Seq.Cons (a, fib_seq b (a + b)) in
    fib_seq 0 1 in
  
  let first_10_fib = fibonacci |> Seq.take 10 |> List.of_seq in
  Printf.printf "First 10 Fibonacci numbers: [%s]\n"
    (String.concat "; " (List.map string_of_int first_10_fib));
  
  (* Sequence operations *)
  let nums = List.to_seq [1; 2; 3; 4; 5; 6; 7; 8; 9; 10] in
  let sum = Seq.fold_left (+) 0 nums in
  let exists_greater_than_5 = List.to_seq [1; 2; 3; 4; 5; 6] |> Seq.exists (fun x -> x > 5) in
  
  Printf.printf "Sum of 1-10: %d\n" sum;
  Printf.printf "Exists element > 5: %b\n" exists_greater_than_5

(* ADDITIONAL ADVANCED STRUCTURES *)

(* Queue - FIFO data structure *)
let demonstrate_queues () =
  Printf.printf "\n=== QUEUES DEMONSTRATION ===\n";
  
  let q = Queue.create () in
  
  (* Add elements *)
  Queue.add 1 q;
  Queue.add 2 q;
  Queue.add 3 q;
  
  Printf.printf "Queue length: %d\n" (Queue.length q);
  
  (* Peek at front *)
  Printf.printf "Front element: %d\n" (Queue.peek q);
  
  (* Remove elements *)
  while not (Queue.is_empty q) do
    Printf.printf "Dequeued: %d\n" (Queue.take q)
  done

(* Stack - LIFO data structure *)
let demonstrate_stacks () =
  Printf.printf "\n=== STACKS DEMONSTRATION ===\n";
  
  let s = Stack.create () in
  
  (* Push elements *)
  Stack.push 1 s;
  Stack.push 2 s;
  Stack.push 3 s;
  
  Printf.printf "Stack length: %d\n" (Stack.length s);
  
  (* Peek at top *)
  Printf.printf "Top element: %d\n" (Stack.top s);
  
  (* Pop elements *)
  while not (Stack.is_empty s) do
    Printf.printf "Popped: %d\n" (Stack.pop s)
  done

(* Buffer - mutable string buffer *)
let demonstrate_buffers () =
  Printf.printf "\n=== BUFFERS DEMONSTRATION ===\n";
  
  let buf = Buffer.create 16 in
  
  (* Add content *)
  Buffer.add_string buf "Hello, ";
  Buffer.add_string buf "world!";
  Buffer.add_char buf '\n';
  
  Printf.printf "Buffer contents: %s" (Buffer.contents buf);
  Printf.printf "Buffer length: %d\n" (Buffer.length buf);
  
  (* Clear buffer *)
  Buffer.clear buf;
  Printf.printf "Buffer length after clear: %d\n" (Buffer.length buf)

(* RUN ALL DEMONSTRATIONS *)
let run_all () =
  demonstrate_maps ();
  demonstrate_sets ();
  demonstrate_hash_tables ();
  demonstrate_sequences ();
  demonstrate_queues ();
  demonstrate_stacks ();
  demonstrate_buffers ()