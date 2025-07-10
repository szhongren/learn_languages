(* CS3110 Advanced Topics: Memoization and Monads *)

type math_error = Division_by_zero | Negative_sqrt

type 'a lazy_memo = {
  mutable computed: bool;
  mutable value: 'a;
  computation: unit -> 'a;
}

(* Remove cyclic type - will simplify the stream example *)

(* MEMOIZATION:
   - Technique to cache function results
   - Improves performance for expensive recursive computations
   - Trade space for time complexity *)

let demonstrate_memoization () =
  Printf.printf "\n=== MEMOIZATION DEMONSTRATION ===\n";
  
  (* Naive Fibonacci - exponential time complexity *)
  let rec fib_naive n =
    if n <= 1 then n
    else fib_naive (n - 1) + fib_naive (n - 2)
  in
  
  (* Memoized Fibonacci using hash table *)
  let fib_memo = 
    let cache = Hashtbl.create 100 in
    let rec fib n =
      match Hashtbl.find_opt cache n with
      | Some result -> result
      | None ->
          let result = 
            if n <= 1 then n
            else fib (n - 1) + fib (n - 2)
          in
          Hashtbl.add cache n result;
          result
    in
    fib
  in
  
  (* Generic memoization function *)
  let memoize f =
    let cache = Hashtbl.create 100 in
    fun x ->
      match Hashtbl.find_opt cache x with
      | Some result -> result
      | None ->
          let result = f x in
          Hashtbl.add cache x result;
          result
  in
  
  (* Using generic memoization *)
  let rec expensive_function n =
    if n <= 1 then 1
    else expensive_function (n - 1) + expensive_function (n - 2) + n
  in
  
  let memoized_expensive = memoize expensive_function in
  
  (* Timing comparison *)
  let time_function f x =
    let start = Sys.time () in
    let result = f x in
    let elapsed = Sys.time () -. start in
    (result, elapsed)
  in
  
  let n = 35 in
  Printf.printf "Computing Fibonacci(%d)...\n" n;
  
  let (result1, time1) = time_function fib_naive n in
  Printf.printf "Naive Fibonacci: %d (%.6f seconds)\n" result1 time1;
  
  let (result2, time2) = time_function fib_memo n in
  Printf.printf "Memoized Fibonacci: %d (%.6f seconds)\n" result2 time2;
  
  Printf.printf "Speedup: %.2fx\n" (time1 /. time2);
  
  (* Demonstrating cache behavior *)
  Printf.printf "\nCache behavior:\n";
  Printf.printf "First call to memoized_expensive(10): %d\n" (memoized_expensive 10);
  Printf.printf "Second call to memoized_expensive(10): %d (cached)\n" (memoized_expensive 10);
  
  (* Memoization with multiple arguments *)
  let memoize2 f =
    let cache = Hashtbl.create 100 in
    fun x y ->
      let key = (x, y) in
      match Hashtbl.find_opt cache key with
      | Some result -> result
      | None ->
          let result = f x y in
          Hashtbl.add cache key result;
          result
  in
  
  let rec ackermann m n =
    if m = 0 then n + 1
    else if n = 0 then ackermann (m - 1) 1
    else ackermann (m - 1) (ackermann m (n - 1))
  in
  
  let memoized_ackermann = memoize2 ackermann in
  
  Printf.printf "Ackermann(3, 4): %d\n" (memoized_ackermann 3 4);
  Printf.printf "Ackermann(3, 5): %d (reuses cached values)\n" (memoized_ackermann 3 5)

(* MONADS:
   - Design pattern for handling computations with context
   - Provides structure for chaining operations
   - Common examples: Option, Result, State, IO *)

module Option = struct
  type 'a t = 'a option
  
  let return x = Some x
  
  let bind opt f =
    match opt with
    | Some x -> f x
    | None -> None
  
  let (>>=) = bind
  let (let*) = bind
end

module Result = struct
  type ('a, 'e) t = ('a, 'e) result
  
  let return x = Ok x
  
  let bind result f =
    match result with
    | Ok x -> f x
    | Error e -> Error e
  
  let (>>=) = bind
  let (let*) = bind
end

module State = struct
  type ('a, 's) t = 's -> ('a * 's)
  
  let return x = fun s -> (x, s)
  
  let bind m f = fun s ->
    let (x, s') = m s in
    f x s'
  
  let (>>=) = bind
  let (let*) = bind
  
  let get = fun s -> (s, s)
  let put s = fun _ -> ((), s)
  
  let run_state m initial_state = m initial_state
end

let demonstrate_monads () =
  Printf.printf "\n=== MONADS DEMONSTRATION ===\n";
  
  (* Safe division using Option monad *)
  let safe_div x y =
    if y = 0 then None else Some (x / y)
  in
  
  let safe_compute x y z =
    Option.bind (safe_div x y) (fun result1 ->
    Option.bind (safe_div result1 z) (fun result2 ->
    Option.return result2))
  in
  
  let safe_compute_syntax x y z =
    let open Option in
    let* result1 = safe_div x y in
    let* result2 = safe_div result1 z in
    return result2
  in
  
  Printf.printf "Option Monad examples:\n";
  
  (match safe_compute 20 4 2 with
   | Some result -> Printf.printf "20 / 4 / 2 = %d\n" result
   | None -> Printf.printf "Division failed\n");
  
  (match safe_compute 20 0 2 with
   | Some result -> Printf.printf "20 / 0 / 2 = %d\n" result
   | None -> Printf.printf "Division by zero!\n");
  
  (match safe_compute_syntax 30 5 3 with
   | Some result -> Printf.printf "30 / 5 / 3 = %d (using let* syntax)\n" result
   | None -> Printf.printf "Division failed\n");
  
  (* Result Monad (for error handling) *)
  let safe_div_result x y =
    if y = 0 then Error Division_by_zero else Ok (x / y)
  in
  
  let complex_computation x y =
    let open Result in
    let* result1 = safe_div_result x y in
    let* result2 = safe_div_result result1 2 in
    return result2
  in
  
  Printf.printf "\nResult Monad examples:\n";
  
  (match complex_computation 24 6 with
   | Ok result -> Printf.printf "24 / 6 / 2 = %d\n" result
   | Error Division_by_zero -> Printf.printf "Error: Division by zero\n"
   | Error Negative_sqrt -> Printf.printf "Error: Negative square root\n");
  
  (match complex_computation 24 0 with
   | Ok result -> Printf.printf "24 / 0 / 2 = %d\n" result
   | Error Division_by_zero -> Printf.printf "Error: Division by zero\n"
   | Error Negative_sqrt -> Printf.printf "Error: Negative square root\n");
  
  (* State Monad (for stateful computations) *)
  let increment = 
    let open State in
    let* count = get in
    put (count + 1)
  in
  
  let decrement = 
    let open State in
    let* count = get in
    put (count - 1)
  in
  
  let get_count = State.get in
  
  let counter_program = 
    let open State in
    let* () = increment in
    let* () = increment in
    let* () = increment in
    let* () = decrement in
    get_count
  in
  
  let (final_count, final_state) = State.run_state counter_program 0 in
  Printf.printf "\nState Monad example:\n";
  Printf.printf "Final count: %d, Final state: %d\n" final_count final_state;
  
  (* List Monad (for non-deterministic computations) *)
  let list_bind xs f = List.concat_map f xs in
  let list_return x = [x] in
  
  let choose_number = [1; 2; 3] in
  let choose_operation = [(fun x -> x * 2); (fun x -> x + 10)] in
  
  let non_deterministic_computation =
    list_bind choose_number (fun num ->
    list_bind choose_operation (fun op ->
    list_return (op num)))
  in
  
  Printf.printf "\nList Monad (non-deterministic computation):\n";
  Printf.printf "All possible results: [%s]\n" 
    (String.concat "; " (List.map string_of_int non_deterministic_computation))

(* ADVANCED MEMOIZATION TECHNIQUES *)

let demonstrate_advanced_memoization () =
  Printf.printf "\n=== ADVANCED MEMOIZATION TECHNIQUES ===\n";
  
  (* Lazy evaluation with memoization *)
  let _make_lazy f =
    { computed = false; value = Obj.magic (); computation = f }
  in
  
  let _force lazy_val =
    if not lazy_val.computed then (
      lazy_val.value <- lazy_val.computation ();
      lazy_val.computed <- true
    );
    lazy_val.value
  in
  
  (* Simplified stream example without cyclic types *)
  let rec fibonacci_generator a b n =
    if n <= 0 then []
    else a :: fibonacci_generator b (a + b) (n - 1)
  in
  
  let first_10_fibs = fibonacci_generator 0 1 10 in
  
  Printf.printf "First 10 Fibonacci numbers from memoized stream:\n";
  Printf.printf "[%s]\n" (String.concat "; " (List.map string_of_int first_10_fibs));
  
  (* Automatic memoization with weak references *)
  let weak_memoize f =
    let cache = Weak.create 1000 in
    let hash_func x = Hashtbl.hash x mod 1000 in
    fun x ->
      let index = hash_func x in
      match Weak.get cache index with
      | Some (cached_x, result) when cached_x = x -> result
      | _ ->
          let result = f x in
          Weak.set cache index (Some (x, result));
          result
  in
  
  let expensive_string_function s =
    (* Simulate expensive computation *)
    String.uppercase_ascii s ^ "_processed"
  in
  
  let memoized_string_func = weak_memoize expensive_string_function in
  
  Printf.printf "\nWeak memoization example:\n";
  Printf.printf "First call: %s\n" (memoized_string_func "hello");
  Printf.printf "Second call: %s (cached)\n" (memoized_string_func "hello");
  
  (* Timed memoization (cache expiration) *)
  let timed_memoize ~ttl f =
    let cache = Hashtbl.create 100 in
    fun x ->
      let current_time = Unix.time () in
      match Hashtbl.find_opt cache x with
      | Some (result, timestamp) when current_time -. timestamp < ttl ->
          result
      | _ ->
          let result = f x in
          Hashtbl.replace cache x (result, current_time);
          result
  in
  
  let time_sensitive_function _x =
    Printf.sprintf "computed_at_%.2f" (Unix.time ())
  in
  
  let timed_memo_func = timed_memoize ~ttl:1.0 time_sensitive_function in
  
  Printf.printf "\nTimed memoization (1 second TTL):\n";
  Printf.printf "First call: %s\n" (timed_memo_func "test");
  Printf.printf "Second call: %s (cached)\n" (timed_memo_func "test");
  
  (* Wait a bit and call again *)
  Unix.sleep 1;
  Printf.printf "After 1 second: %s (recomputed)\n" (timed_memo_func "test")

(* RUN ALL DEMONSTRATIONS *)
let run_all () =
  demonstrate_memoization ();
  demonstrate_monads ();
  demonstrate_advanced_memoization ()