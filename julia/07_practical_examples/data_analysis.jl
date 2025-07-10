# Practical Data Analysis Example

println("=== Data Analysis Example ===")

# Simulated dataset
data = [
    Dict("name" => "Alice", "age" => 25, "salary" => 50000, "department" => "Engineering"),
    Dict("name" => "Bob", "age" => 30, "salary" => 60000, "department" => "Marketing"),
    Dict("name" => "Charlie", "age" => 35, "salary" => 70000, "department" => "Engineering"),
    Dict("name" => "Diana", "age" => 28, "salary" => 55000, "department" => "Sales"),
    Dict("name" => "Eve", "age" => 32, "salary" => 65000, "department" => "Marketing"),
    Dict("name" => "Frank", "age" => 29, "salary" => 58000, "department" => "Engineering"),
    Dict("name" => "Grace", "age" => 27, "salary" => 52000, "department" => "Sales"),
    Dict("name" => "Henry", "age" => 33, "salary" => 72000, "department" => "Engineering"),
]

println("Employee Data Analysis")
println("=" ^ 50)

# Basic statistics
ages = [person["age"] for person in data]
salaries = [person["salary"] for person in data]

println("Basic Statistics:")
println("Total employees: $(length(data))")
println("Average age: $(round(sum(ages) / length(ages), digits=1))")
println("Average salary: \$$(round(sum(salaries) / length(salaries), digits=2))")
println("Age range: $(minimum(ages)) - $(maximum(ages))")
println("Salary range: \$$(minimum(salaries)) - \$$(maximum(salaries))")

# Department analysis
departments = unique([person["department"] for person in data])
println("\nDepartment Analysis:")
for dept in departments
    dept_employees = filter(p -> p["department"] == dept, data)
    dept_count = length(dept_employees)
    dept_avg_salary = sum(p["salary"] for p in dept_employees) / dept_count
    println("$dept: $dept_count employees, avg salary: \$$(round(dept_avg_salary, digits=2))")
end

# Age groups
println("\nAge Group Analysis:")
young = filter(p -> p["age"] < 30, data)
middle = filter(p -> 30 <= p["age"] < 35, data)
senior = filter(p -> p["age"] >= 35, data)

println("Under 30: $(length(young)) employees")
println("30-34: $(length(middle)) employees")
println("35+: $(length(senior)) employees")

# Salary analysis
println("\nSalary Analysis:")
high_earners = filter(p -> p["salary"] > 60000, data)
println("High earners (>60k): $(length(high_earners)) employees")
for person in high_earners
    println("  $(person["name"]): \$$(person["salary"])")
end

# Correlation analysis (simple)
println("\nAge vs Salary Correlation:")
age_salary_pairs = [(p["age"], p["salary"]) for p in data]
n = length(age_salary_pairs)
mean_age = sum(ages) / n
mean_salary = sum(salaries) / n

numerator = sum((age - mean_age) * (salary - mean_salary) for (age, salary) in age_salary_pairs)
denominator = sqrt(sum((age - mean_age)^2 for age in ages)) * sqrt(sum((salary - mean_salary)^2 for salary in salaries))
correlation = numerator / denominator

println("Correlation coefficient: $(round(correlation, digits=3))")

# Data filtering and sorting
println("\nTop 3 Earners:")
sorted_by_salary = sort(data, by=p -> p["salary"], rev=true)
for i in 1:3
    person = sorted_by_salary[i]
    println("$(i). $(person["name"]): \$$(person["salary"]) ($(person["department"]))")
end

# Data transformation
println("\nData Transformation:")
data_with_bonus = map(data) do person
    bonus = person["salary"] * 0.1
    merge(person, Dict("bonus" => bonus, "total_compensation" => person["salary"] + bonus))
end

println("Total compensation (salary + 10% bonus):")
for person in data_with_bonus
    println("$(person["name"]): \$$(person["total_compensation"])")
end

# Summary report
println("\nSummary Report:")
println("=" ^ 30)
total_salaries = sum(salaries)
total_bonuses = sum(p["bonus"] for p in data_with_bonus)
println("Total salary budget: \$$(total_salaries)")
println("Total bonus budget: \$$(total_bonuses)")
println("Total compensation budget: \$$(total_salaries + total_bonuses)")
println("Most common department: $(departments[1])")
println("Analysis complete!")

# File I/O example
println("\nSaving analysis to file...")
open("analysis_results.txt", "w") do file
    println(file, "Employee Analysis Results")
    println(file, "=" ^ 30)
    println(file, "Total employees: $(length(data))")
    println(file, "Average age: $(round(sum(ages) / length(ages), digits=1))")
    println(file, "Average salary: \$$(round(sum(salaries) / length(salaries), digits=2))")
    println(file, "Total budget: \$$(total_salaries + total_bonuses)")
end
println("Results saved to analysis_results.txt")

# Clean up
rm("analysis_results.txt")
println("Temporary file removed")