def solve_part_one(map)
    seeds = map[0].split(":")[1].split

    seed_to_soil_map = map[(map.index('seed-to-soil map:')+1)..map.index('soil-to-fertilizer map:')-2]
    soil_to_fertilizer_map = map[(map.index('soil-to-fertilizer map:')+1)..map.index('fertilizer-to-water map:')-2]
    fertilizer_to_water_map = map[(map.index('fertilizer-to-water map:')+1)..map.index('water-to-light map:')-2]
    water_to_light_map = map[(map.index('water-to-light map:')+1)..map.index('light-to-temperature map:')-2]
    light_to_temperature_map = map[(map.index('light-to-temperature map:')+1)..map.index('temperature-to-humidity map:')-2]
    temperature_to_humidity_map = map[(map.index('temperature-to-humidity map:')+1)..map.index('humidity-to-location map:')-2]
    humidity_to_location_map = map[(map.index('humidity-to-location map:')+1)..map.length-1]
    minimum_location = +1.0/0.0

    seeds.each do |seed|
        soil = get_map_id(seed, seed_to_soil_map)
        fertilizer = get_map_id(soil, soil_to_fertilizer_map)
        water = get_map_id(fertilizer, fertilizer_to_water_map)
        light = get_map_id(water, water_to_light_map)
        temperature = get_map_id(light, light_to_temperature_map)
        humidity = get_map_id(temperature, temperature_to_humidity_map)
        location = get_map_id(humidity, humidity_to_location_map)
        
        if location < minimum_location
            minimum_location = location
        end

    end

    minimum_location
end

def solve_part_two(map)
    seeds = map[0].split(":")[1].split

    seed_to_soil_map = map[(map.index('seed-to-soil map:')+1)..map.index('soil-to-fertilizer map:')-2]
    seed_to_soil_map_cache = {}
    soil_to_fertilizer_map = map[(map.index('soil-to-fertilizer map:')+1)..map.index('fertilizer-to-water map:')-2]
    soil_to_fertilizer_map_cache = {}
    fertilizer_to_water_map = map[(map.index('fertilizer-to-water map:')+1)..map.index('water-to-light map:')-2]
    fertilizer_to_water_map_cache = {}
    water_to_light_map = map[(map.index('water-to-light map:')+1)..map.index('light-to-temperature map:')-2]
    water_to_light_map_cache = {}
    light_to_temperature_map = map[(map.index('light-to-temperature map:')+1)..map.index('temperature-to-humidity map:')-2]
    light_to_temperature_map_cache = {}
    temperature_to_humidity_map = map[(map.index('temperature-to-humidity map:')+1)..map.index('humidity-to-location map:')-2]
    temperature_to_humidity_map_cache = {}
    humidity_to_location_map = map[(map.index('humidity-to-location map:')+1)..map.length-1]
    humidity_to_location_map_cache = {}
    minimum_location = +1.0/0.0

    seeds.each_slice(2) do |seed, counter|
        
        seed_to_soil_map.each do |map|
            values = map.split
            if values[1].to_i <= seed.to_i && values[1].to_i + values[2].to_i >= seed.to_i
                soil_id = values[0].to_i + (seed.to_i - values[1].to_i).abs
                break
            end
        end
=begin
        (0..counter.to_i).each do |i|
            real_seed = seed.to_i + i

            unless seed_to_soil_map_cache.key?(real_seed)
                seed_to_soil_map_cache[real_seed] = get_map_id(real_seed, seed_to_soil_map)
            end
            soil = seed_to_soil_map_cache[real_seed]

            unless soil_to_fertilizer_map_cache.key?(soil)
                soil_to_fertilizer_map_cache[soil] = get_map_id(soil, soil_to_fertilizer_map)
            end
            fertilizer = soil_to_fertilizer_map_cache[soil]

            unless fertilizer_to_water_map_cache.key?(fertilizer)
                fertilizer_to_water_map_cache[fertilizer] = get_map_id(fertilizer, fertilizer_to_water_map)
            end
            water = fertilizer_to_water_map_cache[fertilizer]

            unless water_to_light_map_cache.key?(water)
                water_to_light_map_cache[water] = get_map_id(water, water_to_light_map)
            end
            light = water_to_light_map_cache[water]

            unless light_to_temperature_map_cache.key?(light)
                light_to_temperature_map_cache[light] = get_map_id(light, light_to_temperature_map)
            end
            temperature = light_to_temperature_map_cache[light]

            unless temperature_to_humidity_map_cache.key?(temperature)
                temperature_to_humidity_map_cache[temperature] = get_map_id(temperature, temperature_to_humidity_map)
            end
            humidity = temperature_to_humidity_map_cache[temperature]

            unless humidity_to_location_map_cache.key?(humidity)
                humidity_to_location_map_cache[humidity] = get_map_id(humidity, humidity_to_location_map)
            end
            location = humidity_to_location_map_cache[humidity]
            
            if location < minimum_location
                minimum_location = location
            end
        end
=end
    end

    minimum_location
end

def get_map_id(seed, translate_map)
    soil_id = -1

    translate_map.each do |map|
        values = map.split
        if values[1].to_i <= seed.to_i && values[1].to_i + values[2].to_i >= seed.to_i
            soil_id = values[0].to_i + (seed.to_i - values[1].to_i).abs
            break
        end
    end

    if soil_id == -1
        soil_id = seed.to_i 
    end

    soil_id
end

def get_map_id_with_counter(seed, counter, translate_map)
    mapped = []
    
    translate_map.each do |map|
        values = map.split
        if values[1].to_i <= seed.to_i && values[1].to_i + values[2].to_i >= seed.to_i
            soil_id = values[0].to_i + (seed.to_i - values[1].to_i).abs
            break
        end
    end

    if soil_id == -1
        soil_id = seed.to_i 
    end

    mapped
end

# Files
p1_example = File.readlines("day5/p1_example.txt").map(&:chomp)
input = File.readlines("day5/input.txt").map(&:chomp)

# Part 1
#puts "Example Part 1: #{solve_part_one(p1_example)}"
#puts "Part 1: #{solve_part_one(input)}"

# Part 2
puts "Example Part 2: #{solve_part_two(p1_example)}"
puts "Part 2: #{solve_part_two(input)}"