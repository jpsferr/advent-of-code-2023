def solve_part_one(file)
    sum_answer = 0
    file.each do |line|
        numbers = line.split(' ').map(&:to_i)
        all_different = true
        level_array = [].push(numbers)
        answer = 0
        while all_different
            numbers = numbers.each_cons(2).map { |a,b| b-a }
            level_array.push(numbers)
            all_different = (numbers.uniq.size > 1)
        end

        (level_array.length-1).downto(0) { |i| answer += level_array[i].last }

        sum_answer += answer
    end

    sum_answer
end

def solve_part_two(file)
    sum_answer = 0
    file.each do |line|
        numbers = line.split(' ').map(&:to_i)
        all_different = true
        level_array = [].push(numbers)
        answer = 0
        while all_different
            numbers = numbers.each_cons(2).map { |a,b| b-a }
            level_array.push(numbers)
            all_different = (numbers.uniq.size > 1)
        end

        (level_array.length-1).downto(0) { |i| answer = level_array[i].first - answer }
        sum_answer += answer
    end

    sum_answer
end


# Files
p1_example = File.readlines("day9/p1_example.txt").map(&:chomp)
input = File.readlines("day9/input.txt").map(&:chomp)

# Part 1
puts "Example Part 1: #{solve_part_one(p1_example)}"
puts "Part 1: #{solve_part_one(input)}"

# Part 2
puts "Example Part 2: #{solve_part_two(p1_example)}"
puts "Part 2: #{solve_part_two(input)}"
