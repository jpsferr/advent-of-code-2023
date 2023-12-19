INSTRUCTION_TO_INDEX = {
    'L' => 0,
    'R' => 1
}

def solve_part_one(map)
    map_hash = {}
    steps = 0
    current_location = 'AAA'
    instructions = map[0].split('')
    (2..map.length-1).each do |i|
        map_split = map[i].split(' = ')
        key = map_split[0]
        locations = map_split[1].delete('()').split(', ')
        map_hash[map_split[0]] = [locations[0], locations[1]]
    end

    while current_location != 'ZZZ'
        instruction = instructions[steps%instructions.length]
        current_location = map_hash[current_location][INSTRUCTION_TO_INDEX[instruction]]
        steps += 1
    end

    steps
end

def solve_part_two(map)
    map_hash = {}
    steps_array = []
    instructions = map[0].split('')

    (2..map.length-1).each do |i|
        map_split = map[i].split(' = ')
        key = map_split[0]
        locations = map_split[1].delete('()').split(', ')
        map_hash[map_split[0]] = [locations[0], locations[1]]
    end

    current_locations = map_hash.select{|key,value| key.end_with?("A")}.keys

    current_locations.each do |location|
        steps_array.push(find_final_location(location, map_hash, instructions))
    end

    steps_array.inject { |acc, steps| acc.lcm(steps)} 
end

def find_final_location(current_location, map_hash, instructions)
    steps = 0
    while !current_location.end_with?('Z')
        instruction = instructions[steps%instructions.length]
        current_location = map_hash[current_location][INSTRUCTION_TO_INDEX[instruction]]
        steps += 1
    end
    steps
end

# Files
p1_example = File.readlines("day8/p1_example.txt").map(&:chomp)
p2_example = File.readlines("day8/p2_example.txt").map(&:chomp)
input = File.readlines("day8/input.txt").map(&:chomp)

# Part 1
puts "Example Part 1: #{solve_part_one(p1_example)}"
puts "Part 1: #{solve_part_one(input)}"

# Part 2
puts "Example Part 2: #{solve_part_two(p2_example)}"
puts "Part 2: #{solve_part_two(input)}"
