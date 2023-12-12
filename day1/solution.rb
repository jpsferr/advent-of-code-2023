NUMBER_WORD_MAP = {
    'zero' => '0',
    'orez' => '0',
    'one' => '1',
    'eno' => '1',
    'two' => '2',
    'owt' => '2',
    'three' => '3',
    'eerht' => '3',
    'four' => '4',
    'ruof' => '4',
    'five' => '5',
    'evif' => '5',
    'six' => '6',
    'xis' => '6',
    'seven' => '7',
    'neves' => '7',
    'eight' => '8',
    'thgie' => '8',
    'nine' => '9',
    'enin' => '9'
}

REPLACE_REGEXP = Regexp.new(NUMBER_WORD_MAP.keys.join('|'))

def solve_part_one(input)
    sum_calibration_values = 0

    input.each do |line|
        line_first_digit = find_line_first_digit(line)
        line_last_digit = find_line_first_digit(line.reverse)

        sum_calibration_values = sum_calibration_values + Integer(line_first_digit + line_last_digit)
    end

    sum_calibration_values
end

def solve_part_two(input)
    sum_calibration_values = 0

    input.each do |line|
        line_first_digit = find_line_first_digit(line.gsub(REPLACE_REGEXP, NUMBER_WORD_MAP))
        line_last_digit = find_line_first_digit(line.reverse.gsub(REPLACE_REGEXP, NUMBER_WORD_MAP))

        sum_calibration_values = sum_calibration_values + Integer(line_first_digit + line_last_digit)
    end

    sum_calibration_values
end

def find_line_first_digit(line)
  line[/\d/] || '0'
end

# Files
p1_example = File.readlines("day1/p1_example.txt").map(&:chomp)
p2_example = File.readlines("day1/p2_example.txt").map(&:chomp)
input = File.readlines("day1/input.txt").map(&:chomp)

# Part 1
puts "Example Part 1: #{solve_part_one(p1_example)}"
puts "Part 1: #{solve_part_one(input)}"

# Part 2
puts "Example Part 2: #{solve_part_two(p2_example)}"
puts "Part 2: #{solve_part_two(input)}"