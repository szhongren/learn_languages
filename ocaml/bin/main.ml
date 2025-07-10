open Learn_ocaml

let print_section title =
  Printf.printf "\n%s\n" (String.make 60 '=');
  Printf.printf "%s\n" title;
  Printf.printf "%s\n\n" (String.make 60 '=')

let () =
  print_section "OCaml Learning Examples - Comprehensive Tour";
  
  print_section "1. BASICS - Core Language Features";
  Basics.run_all ();
  
  print_section "2. DATA STRUCTURES - Records, Variants, Arrays";
  Data_structures.run_all ();
  
  print_section "3. MODULES - Organization and Functors";
  Modules.run_all ();
  
  print_section "4. ADVANCED DATA STRUCTURES - Maps, Sets, Hash Tables";
  Advanced_data_structures.run_all ();
  
  print_section "5. ADVANCED TOPICS - Operators, Objects, PPX, GADTs";
  Advanced_topics.run_all ();
  
  print_section "6. RUNTIME & COMPILER - Memory, GC, Performance";
  Runtime_compiler.run_all ();
  
  print_section "7. CS3110 TOPICS - Memoization and Monads";
  Memoization_monads.run_all ();
  
  print_section "OCaml Learning Examples - Complete!";
  Printf.printf "All working examples have been executed successfully.\n";
  Printf.printf "Review the output above to understand OCaml's features.\n\n"
