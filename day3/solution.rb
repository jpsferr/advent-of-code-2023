def solve_part_one(matrix)
    row_index = 0
    column_index = 0
    has_symbol = false
    sum_of_number = 0
    number = ''
    
    while row_index <= matrix.length - 1
        while column_index <= matrix[row_index].length - 1
            if is_number(matrix[row_index][column_index])
                number += matrix[row_index][column_index]
                matrix[row_index][column_index] = 'x'
                if !has_symbol
                    has_symbol = safe_is_symbol(matrix, row_index, column_index-1) || # left
                                    safe_is_symbol(matrix, row_index, column_index+1) || # right
                                    safe_is_symbol(matrix, row_index+1, column_index) || # up
                                    safe_is_symbol(matrix, row_index-1, column_index) || # down
                                    safe_is_symbol(matrix, row_index+1, column_index+1) || # up and right
                                    safe_is_symbol(matrix, row_index+1, column_index-1) || # up and left
                                    safe_is_symbol(matrix, row_index-1, column_index+1) || # down and right
                                    safe_is_symbol(matrix, row_index-1, column_index-1) # down and left
                    
                end

            else
                if has_symbol
                    sum_of_number += Integer(number)
                end

                number = ''
                has_symbol = false
            end

            column_index += 1
        end

        if has_symbol
            sum_of_number += Integer(number)
        end

        column_index = 0

        row_index += 1
    end

    sum_of_number
end

def safe_is_symbol(matrix, row, col)
    return false unless row.between?(0, matrix.length - 1) && col.between?(0, matrix[row].length - 1)
    is_symbol(matrix[row][col])
end

def is_symbol(char)
    !char&.match(/\A[a-zA-Z0-9.]\z/)
end

def is_number(char)
    char&.match(/\A[0-9]\z/)
end

# Files
p1_example = File.readlines("day3/p1_example.txt")
input = File.readlines("day3/input.txt").map(&:chomp)

# Part 1
puts "Example Part 1: #{solve_part_one(p1_example)}"
puts "Part 1: #{solve_part_one(input)}"