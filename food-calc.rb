# Initialize total cost
total_cost = 0

loop do
  # Get the unit weight from the user
  puts "Enter the unit weight: "
  unit_weight = gets.chomp.to_f
  puts "The unit weight: #{unit_weight}"
  puts ''

  # Get the unit price from the user
  puts "Enter the unit price: "
  unit_price = gets.chomp.to_f
  puts "The unit price: #{unit_price}"
  puts ''

  # Get the amount taken daily from the user
  puts "Enter the amount taken daily: "
  amount_taken_daily = gets.chomp.to_f
  puts "The amount taken daily: #{amount_taken_daily}"
  puts ''

  # Calculate the daily price
  daily_price = (unit_price * amount_taken_daily) / unit_weight 

  # Add to total cost
  total_cost += daily_price

  # Print the result
  puts "The daily price for this unit is #{daily_price}"
  puts "The total daily price so far is #{total_cost}"
  puts ''

  # Ask user if they want to add another unit
  puts "Do you want to add another unit? (yes/no)"
  answer = gets.chomp.downcase

  # Break the loop if the answer is 'no'
  break if answer != 'yes'
end

# Print the total cost
puts "The total daily price for all units is #{total_cost}"
