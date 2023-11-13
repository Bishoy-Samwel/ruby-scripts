# Initialize units hash
units = {}

puts "Do you want to read from the file or create new entries? (read/new)"
action = gets.chomp.downcase

if action == 'read'
  # Open the file for reading
  File.open('units.txt', 'r') do |file|
    # Read each line from the file
    file.each_line do |line|
      # Parse the unit details
      unit_name, weight, price, daily_amount = line.chomp.split(',')

      # Store the unit details
      units[unit_name] = {
        weight: weight.to_f,
        price: price.to_f,
        daily_amount: daily_amount.to_f
      }
    end
  end

  # Initialize total cost
  total_cost = 0

  # Calculate the total cost
  units.each do |unit_name, details|
    daily_price = (details[:price] * details[:daily_amount]) / details[:weight]
    total_cost += daily_price
  end

  # Print the total cost
  puts "The total daily price for all units is #{total_cost}"

else
  loop do
    # Get the unit details from the user
    puts "Enter the unit name: "
    unit_name = gets.chomp
    puts "The unit name: #{unit_name}"
    puts ''

    puts "Enter the unit weight: "
    unit_weight = gets.chomp.to_f
    puts "The unit weight: #{unit_weight}"
    puts ''

    puts "Enter the unit price: "
    unit_price = gets.chomp.to_f
    puts "The unit price: #{unit_price}"
    puts ''

    puts "Enter the amount taken daily: "
    amount_taken_daily = gets.chomp.to_f
    puts "The amount taken daily: #{amount_taken_daily}"
    puts ''

    # Store the unit details
    units[unit_name] = {
      weight: unit_weight,
      price: unit_price,
      daily_amount: amount_taken_daily
    }

    # Ask user if they want to add another unit
    puts "Do you want to add another unit? (yes/no)"
    answer = gets.chomp.downcase

    # Break the loop if the answer is 'no'
    break if answer != 'yes'
  end

  # Open a file for writing
  File.open('units.txt', 'w') do |file|
    # Write each unit and its details to the file
    units.each do |unit_name, details|
      file.puts "#{unit_name},#{details[:weight]},#{details[:price]},#{details[:daily_amount]}"
    end
  end
end
