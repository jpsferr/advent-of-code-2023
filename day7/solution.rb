CARD_TO_VALUE = {
    '2' => 2,
    '3' => 3,
    '4' => 4,
    '5' => 5,
    '6' => 6,
    '7' => 7,
    '8' => 8,
    '9' => 9,
    'T' => 10,
    'J' => 11,
    'Q' => 12,
    'K' => 13,
    'A' => 14
}

CARD_TO_VALUE_P2 = {
    'J' => 1,
    '2' => 2,
    '3' => 3,
    '4' => 4,
    '5' => 5,
    '6' => 6,
    '7' => 7,
    '8' => 8,
    '9' => 9,
    'T' => 10,
    'Q' => 11,
    'K' => 12,
    'A' => 13
}

TYPE_TO_VALUE = {
    'H' => 1,
    'P' => 2,
    '2P' => 3,
    '3K' => 4,
    'FH' => 5,
    '4K' => 6,
    '5K' => 7
}

def solve_part_one(cards)
    card_evaluation = {}
    card_rank = cards.length
    result = 0
    cards.each do |play|
        hand = play.split[0]
        bid = play.split[1].to_i
        card_evaluation[hand] = define_hand(hand).push(bid)
    end

    # Because Ruby will compare an array, the below code will work. If the first element is the same then it will compare the second.
    card_evaluation = card_evaluation.sort_by{|key, value| value}.reverse.to_h

    card_evaluation.each do |key, value|
        result += value[6] * card_rank
        card_rank -= 1
    end

    result
end

def solve_part_two(cards)
    card_evaluation = {}
    card_rank = cards.length
    result = 0
    cards.each do |play|
        hand = play.split[0]
        bid = play.split[1].to_i
        card_evaluation[hand] = define_hand_p2(hand).push(bid)
    end

    # Because Ruby will compare an array, the below code will work. If the first element is the same then it will compare the second.
    card_evaluation = card_evaluation.sort_by{|key, value| value}.reverse.to_h

    card_evaluation.each do |key, value|
        result += value[6] * card_rank
        card_rank -= 1
    end

    result
end

def define_hand(hand)
    hand_map = {}
    result = []
    hand.each_char do |card|
        result.push(CARD_TO_VALUE[card])
        if hand_map.has_key?(card)
            hand_map[card] += 1
        else
            hand_map[card] = 1
        end
    end

    hand_map = hand_map.sort_by { |k, v| v }.reverse
    highest = hand_map[0][1]

    case highest
    when 5
        result.unshift(TYPE_TO_VALUE['5K'])
    when 4
        result.unshift(TYPE_TO_VALUE['4K'])
    when 3
        second_highest = hand_map[1][1]
        if second_highest == 2
            result.unshift(TYPE_TO_VALUE['FH'])
        else
            result.unshift(TYPE_TO_VALUE['3K'])
        end
    when 2
        second_highest = hand_map[1][1]
        if second_highest == 2
            result.unshift(TYPE_TO_VALUE['2P'])
        else
            result.unshift(TYPE_TO_VALUE['P'])
        end
    else
        result.unshift(TYPE_TO_VALUE['H'])
    end
end

def define_hand_p2(hand)
    hand_map = {}
    result = []
    hand.each_char do |card|
        result.push(CARD_TO_VALUE_P2[card])
        if hand_map.has_key?(card)
            hand_map[card] += 1
        else
            hand_map[card] = 1
        end
    end
    jokers = 0
    if hand_map.has_key?('J')
        jokers = hand_map['J']
    end 

    hand_map = hand_map.sort_by { |k, v| v }.reverse
 
    highest = 0
    if jokers == 5
        highest = jokers
    elsif hand_map[0][0] == 'J'
        highest = hand_map[1][1] + jokers
    else
        highest = hand_map[0][1] + jokers
    end

    case
    when highest >= 5
        result.unshift(TYPE_TO_VALUE['5K'])
    when highest == 4
        result.unshift(TYPE_TO_VALUE['4K'])
    when highest == 3
        second_highest = hand_map[1][1]
        if second_highest == 2
            result.unshift(TYPE_TO_VALUE['FH'])
        else
            result.unshift(TYPE_TO_VALUE['3K'])
        end
    when highest == 2
        second_highest = hand_map[1][1]
        if second_highest == 2
            result.unshift(TYPE_TO_VALUE['2P'])
        else
            result.unshift(TYPE_TO_VALUE['P'])
        end
    else
        result.unshift(TYPE_TO_VALUE['H'])
    end
end

# Files
p1_example = File.readlines("day7/p1_example.txt").map(&:chomp)
p2_example = File.readlines("day7/p2_example.txt").map(&:chomp)
input = File.readlines("day7/input.txt").map(&:chomp)

# Part 1
puts "Example Part 1: #{solve_part_one(p1_example)}"
puts "Part 1: #{solve_part_one(input)}"

# Part 2
puts "Example Part 2: #{solve_part_two(p2_example)}"
puts "Part 2: #{solve_part_two(input)}"
