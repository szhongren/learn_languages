// Rust Practice Exercises - Focus on Borrow Checker

fn main() {
    println!("=== Rust Practice Exercises ===\n");
    
    // Exercise 1: Fix the ownership issue
    println!("Exercise 1: Fix ownership");
    exercise_1();
    
    // Exercise 2: Fix borrowing conflicts
    println!("\nExercise 2: Fix borrowing");
    exercise_2();
    
    // Exercise 3: Work with lifetimes
    println!("\nExercise 3: Lifetimes");
    exercise_3();
    
    // Exercise 4: Vector and references
    println!("\nExercise 4: Vector operations");
    exercise_4();
    
    // Exercise 5: Closures and capturing
    println!("\nExercise 5: Closures");
    exercise_5();
}

// Exercise 1: Fix ownership issues
fn exercise_1() {
    // Problem: This code has ownership issues
    // Fix it without cloning unless necessary
    
    let s1 = String::from("hello");
    let s2 = s1; // s1 is moved here
    
    // Fix: Use references instead of moving
    let s3 = String::from("world");
    let s4 = &s3; // Borrow instead of move
    
    println!("s2: {}, s4: {}", s2, s4);
    println!("s3 is still accessible: {}", s3);
}

// Exercise 2: Fix borrowing conflicts
fn exercise_2() {
    let mut data = vec![1, 2, 3, 4, 5];
    
    // Problem: Multiple mutable borrows
    // Fix: Use scope or reorganize code
    
    {
        let first_mut = &mut data[0];
        *first_mut += 10;
        println!("Modified first element: {}", first_mut);
    } // first_mut goes out of scope
    
    // Now we can borrow again
    data.push(6);
    println!("Data after modifications: {:?}", data);
}

// Exercise 3: Work with lifetimes
fn exercise_3() {
    let string1 = String::from("long string is long");
    let result;
    
    {
        let string2 = String::from("xyz");
        result = longest(&string1, &string2);
        println!("The longest string is: {}", result);
    }
    
    // This would be an error if result tried to reference string2
    // because string2 goes out of scope
}

fn longest<'a>(x: &'a str, y: &'a str) -> &'a str {
    if x.len() > y.len() {
        x
    } else {
        y
    }
}

// Exercise 4: Vector operations without borrow conflicts
fn exercise_4() {
    let mut numbers = vec![1, 2, 3, 4, 5];
    
    // Calculate sum without holding references
    let sum = numbers.iter().sum::<i32>();
    println!("Sum: {}", sum);
    
    // Now we can modify the vector
    numbers.push(6);
    
    // Find max without conflicts
    let max = numbers.iter().max().copied().unwrap_or(0);
    println!("Max after push: {}", max);
    
    // Transform elements
    for item in numbers.iter_mut() {
        *item *= 2;
    }
    
    println!("After doubling: {:?}", numbers);
}

// Exercise 5: Closures and capturing
fn exercise_5() {
    let mut counter = 0;
    
    {
        let mut increment = || {
            counter += 1;
            println!("Counter: {}", counter);
        };
        
        increment();
        increment();
    } // closure goes out of scope
    
    // Now counter is accessible again
    println!("Final counter: {}", counter);
    
    // Move closure example
    let data = vec![1, 2, 3];
    let process = move || {
        println!("Processing: {:?}", data);
        data.len()
    };
    
    let len = process();
    println!("Length: {}", len);
    
    // data is no longer accessible here
    // println!("Data: {:?}", data); // This would be an error
}