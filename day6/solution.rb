def solve_part_one(stats)
    times = stats[0].split(':')[1].split
    distances = stats[1].split(':')[1].split
    victory = 1

    (0..times.length).each do |race|
        wins = 0
        (0..times[race].to_i).each do |hold|
            if (times[race].to_i - hold) * hold > distances[race].to_i
                wins += 1
            end
        end

        if wins > 0
            victory *= wins
        end

    end

    victory
end

def solve_part_two(stats)
    time = stats[0].split(':')[1].delete(' ')
    distance = stats[1].split(':')[1].delete(' ')

    wins = 0
    (0..time.to_i).each do |hold|
        if (time.to_i - hold) * hold > distance.to_i
            wins += 1
        end
    end

    wins
end

# Files
p1_example = File.readlines("day6/p1_example.txt").map(&:chomp)
input = File.readlines("day6/input.txt").map(&:chomp)

# Part 1
puts "Example Part 1: #{solve_part_one(p1_example)}"
puts "Part 1: #{solve_part_one(input)}"

# Part 2
puts "Example Part 2: #{solve_part_two(p1_example)}"
puts "Part 2: #{solve_part_two(input)}"
