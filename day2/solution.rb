COLOUR_NUMBER_CUBES = {
    'red' => 12,
    'green' => 13,
    'blue' => 14,
}

def solve_part_one(input)
    sum_id = 0

    input.each do |line|
        line_split = line.split(':')
        game_id = Integer(line_split[0].split("Game ")[1])

        if is_game_valid(line_split[1])
            sum_id += game_id
        end
    end

    sum_id
end

def is_game_valid(game)

    game.split("; ").each do |round|
        round.split(", ").each do |draw|
            number = Integer(draw.split[0])
            colour = draw.split[1]
            if number > COLOUR_NUMBER_CUBES[colour]
                return false
            end

        end
    end

    return true
end

def solve_part_two(input)
    sum_power = 0

    input.each do |line|
        line_split = line.split(':')
        sum_power += get_multiplication_of_fewest_cubes(line_split[1])
    end

    sum_power
end

def get_multiplication_of_fewest_cubes(game)
    game_minimum_cubes = {}

    game.split("; ").each do |round|
        round.split(", ").each do |draw|
            number = Integer(draw.split[0])
            colour = draw.split[1]
            if game_minimum_cubes.key?(colour)
                if number > game_minimum_cubes[colour]
                    game_minimum_cubes[colour] = number
                end
            else
                game_minimum_cubes[colour] = number
            end
        end
    end
    power = game_minimum_cubes.values.inject(1) { |total, colour_min_number| total * colour_min_number }
end

# Files
p1_example = File.readlines("day2/p1_example.txt").map(&:chomp)
input = File.readlines("day2/input.txt").map(&:chomp)

# Part 1
puts "Example Part 1: #{solve_part_one(p1_example)}"
puts "Part 1: #{solve_part_one(input)}"

# Part 2
puts "Example Part 2: #{solve_part_two(p1_example)}"
puts "Part 2: #{solve_part_two(input)}"