// Rust Borrow Checker Learning Examples
// This file contains progressively complex examples to understand ownership, borrowing, and lifetimes

fn main() {
    println!("=== Rust Borrow Checker Learning Examples ===\n");
    
    // Example 1: Basic Ownership
    ownership_basics();
    
    // Example 2: Borrowing Rules
    borrowing_rules();
    
    // Example 3: Mutable vs Immutable References
    mutable_references();
    
    // Example 4: Lifetimes
    lifetime_examples();
    
    // Example 5: Complex Scenarios
    complex_scenarios();
}

// 1. Basic Ownership - Move semantics
fn ownership_basics() {
    println!("1. OWNERSHIP BASICS");
    
    // String owns its data
    let s1 = String::from("hello");
    let s2 = s1; // s1 is moved to s2, s1 is no longer valid
    
    // This would cause a compile error:
    // println!("s1: {}", s1); // ERROR: borrow of moved value
    
    println!("s2: {}", s2); // OK
    
    // Copy types (like integers) don't move
    let x = 5;
    let y = x; // x is copied, both are valid
    println!("x: {}, y: {}", x, y); // OK
    
    println!();
}

// 2. Borrowing Rules
fn borrowing_rules() {
    println!("2. BORROWING RULES");
    
    let s = String::from("hello");
    
    // Immutable borrow
    let r1 = &s; // OK
    let r2 = &s; // OK - multiple immutable borrows allowed
    
    println!("r1: {}, r2: {}", r1, r2);
    
    // After immutable borrows are done, we can have mutable borrow
    let r3 = &mut s.clone(); // Using clone to avoid borrow conflicts
    r3.push_str(" world");
    println!("r3: {}", r3);
    
    println!();
}

// 3. Mutable vs Immutable References
fn mutable_references() {
    println!("3. MUTABLE VS IMMUTABLE REFERENCES");
    
    let mut s = String::from("hello");
    
    // Only one mutable reference allowed at a time
    let r1 = &mut s;
    r1.push_str(" world");
    println!("r1: {}", r1);
    
    // Now r1 is done, we can create another mutable reference
    let r2 = &mut s;
    r2.push_str("!");
    println!("r2: {}", r2);
    
    // Demonstrating the borrow checker preventing data races
    demonstrate_borrow_checker();
    
    println!();
}

fn demonstrate_borrow_checker() {
    let mut data = vec![1, 2, 3, 4, 5];
    
    // This is safe - we borrow, use, and return
    let first = &data[0];
    println!("First element: {}", first);
    
    // After immutable borrow is done, we can mutably borrow
    data.push(6);
    println!("Data after push: {:?}", data);
    
    // The borrow checker prevents this scenario:
    // let r = &data[0];        // immutable borrow
    // data.push(7);            // ERROR: cannot mutably borrow while immutably borrowed
    // println!("r: {}", r);    // immutable borrow used here
}

// 4. Lifetimes
fn lifetime_examples() {
    println!("4. LIFETIMES");
    
    // Basic lifetime example
    let string1 = String::from("abcd");
    let string2 = "xyz";
    
    let result = longest(&string1, string2);
    println!("The longest string is: {}", result);
    
    // Lifetime with structs
    let novel = String::from("Call me Ishmael. Some years ago...");
    let first_sentence = novel.split('.').next().expect("Could not find a '.'");
    let excerpt = ImportantExcerpt {
        part: first_sentence,
    };
    println!("Excerpt: {}", excerpt.part);
    
    println!();
}

// Function with lifetime annotations
fn longest<'a>(x: &'a str, y: &'a str) -> &'a str {
    if x.len() > y.len() {
        x
    } else {
        y
    }
}

// Struct with lifetime annotations
struct ImportantExcerpt<'a> {
    part: &'a str,
}

// 5. Complex Scenarios
fn complex_scenarios() {
    println!("5. COMPLEX SCENARIOS");
    
    // Scenario 1: Vec and references
    vec_and_references();
    
    // Scenario 2: Closures and borrowing
    closures_and_borrowing();
    
    // Scenario 3: Multiple mutable borrows (not allowed)
    // demonstrate_multiple_mutable_borrows(); // This would fail compilation
    
    println!();
}

fn vec_and_references() {
    println!("Vec and References:");
    
    let mut vec = vec![1, 2, 3];
    
    // This works - we borrow, use, and done
    {
        let first = &vec[0];
        println!("First: {}", first);
    } // first goes out of scope
    
    // Now we can modify
    vec.push(4);
    println!("Vec after push: {:?}", vec);
    
    // Iterator example that shows borrowing
    let sum: i32 = vec.iter().sum();
    println!("Sum: {}", sum);
    
    // We can still use vec after iter() because iter() only borrows
    vec.push(5);
    println!("Vec after another push: {:?}", vec);
}

fn closures_and_borrowing() {
    println!("Closures and Borrowing:");
    
    let mut list = vec![1, 2, 3];
    println!("Before closure: {:?}", list);
    
    // Closure that borrows mutably
    let mut closure = || {
        list.push(4);
    };
    
    // We can call the closure
    closure();
    
    // But we can't use list while closure exists and might be called again
    // println!("List: {:?}", list); // This would be an error
    
    // After closure is done, we can use list
    drop(closure); // Explicitly drop the closure
    println!("After closure: {:?}", list);
    
    // Move closure example
    let list2 = vec![1, 2, 3];
    let move_closure = move || {
        println!("From move closure: {:?}", list2);
    };
    
    // list2 is moved into closure, can't use it anymore
    // println!("List2: {:?}", list2); // This would be an error
    
    move_closure();
}

// This function would fail compilation - demonstrating borrow checker
/*
fn demonstrate_multiple_mutable_borrows() {
    let mut s = String::from("hello");
    
    let r1 = &mut s; // First mutable borrow
    let r2 = &mut s; // Second mutable borrow - ERROR!
    
    println!("{}, {}", r1, r2);
}
*/