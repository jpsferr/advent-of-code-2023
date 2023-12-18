def solve_part_one(games)

    sum_points = 0

    games.each do |game|
        game_split = game.split(':')
        numbers = game_split[1].split('|')
        my_numbers = numbers[0].split
        winning_numbers = numbers[1].split
        points = 0

        correct_numbers = my_numbers.length - (my_numbers - winning_numbers).length

        if correct_numbers == 1
            points += 1
        elsif correct_numbers > 1
            points += 2**(correct_numbers - 1)
        end

        sum_points += points
    end
    
    sum_points
end

def solve_part_two(games)

    game_hash = { }
    sum_total_games = 0

    games.each do |game|
        game_split = game.split(':')
        game_id = Integer(game_split[0].split[1])
        numbers = game_split[1].split('|')
        my_numbers = numbers[0].split
        winning_numbers = numbers[1].split
        multiplier = 1

        if game_hash.has_key?(game_id)
            game_hash[game_id] += 1
        else
            game_hash[game_id] = 1
        end

        if game_hash.has_key?(game_id)
            multiplier = game_hash[game_id]
            sum_total_games += game_hash[game_id]
        else
            sum_total_games += 1
        end

        correct_numbers = my_numbers.length - (my_numbers - winning_numbers).length

        (1..correct_numbers).each do |i|
            won_id = game_id + i
            if game_hash.has_key?(won_id)
                game_hash[won_id] += multiplier
            else
                game_hash[won_id] = multiplier
            end
        end

    end

    sum_total_games
end

# Files
p1_example = File.readlines("day4/p1_example.txt").map(&:chomp)
p2_example = File.readlines("day4/p2_example.txt").map(&:chomp)
input = File.readlines("day4/input.txt").map(&:chomp)

# Part 1
puts "Example Part 1: #{solve_part_one(p1_example)}"
puts "Part 1: #{solve_part_one(input)}"

# Part 2
puts "Example Part 2: #{solve_part_two(p1_example)}"
puts "Part 2: #{solve_part_two(input)}"