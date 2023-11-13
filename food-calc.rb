
puts "Enter the unit weight: "
unit_weight = gets.chomp.to_f
puts "The unit weight: #{unit_weight} "
puts ''

puts "Enter the unit price: "
unit_price = gets.chomp.to_f
puts "The unit pric: #{unit_price} "
puts ''


puts "Enter the amount taken daily: "
amount_taken_daily = gets.chomp.to_f
puts "The amount taken daily: #{amount_taken_daily} "


daily_price = (unit_price * amount_taken_daily) / unit_weight


puts "The daily price is #{daily_price}"
