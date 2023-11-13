# Stores the units and their details in a hash
def read_units_from_file(filename)
  units = {}
  File.open(filename, 'r') do |file|
    file.each_line do |line|
      unit_name, weight, price, daily_amount = line.chomp.split(',')
      units[unit_name] = {
        weight: weight.to_f,
        price: price.to_f,
        daily_amount: daily_amount.to_f
      }
    end
  end
  units
end

# Displays the units and their details
def display_units(units)
  units.each do |unit_name, details|
    puts "Unit name: #{unit_name}, Weight: #{details[:weight]}, Price: #{details[:price]}, Daily amount: #{details[:daily_amount]}"
  end
end

# Gets the unit details from the user and returns them as a hash
def get_unit_details_from_user
  puts "Enter the unit name: "
  unit_name = gets.chomp
  puts "Enter the unit weight: "
  unit_weight = gets.chomp.to_f
  puts "Enter the unit price: "
  unit_price = gets.chomp.to_f
  puts "Enter the amount taken daily: "
  daily_amount = gets.chomp.to_f
  { unit_name => { weight: unit_weight, price: unit_price, daily_amount: daily_amount } }
end

# Writes the units and their details to a file
def write_units_to_file(units, filename)
  File.open(filename, 'w') do |file|
    units.each do |unit_name, details|
      file.puts "#{unit_name},#{details[:weight]},#{details[:price]},#{details[:daily_amount]}"
    end
  end
end

# Main script
def main_script
  puts "Do you want to read from the file or create new entries? (read/new)"
  action = gets.chomp.downcase

  units = action == 'read' ? read_units_from_file('units.txt') : {}

  display_units(units)

  if action == 'read'
    puts "Do you want to add more units? (yes/no)"
    answer = gets.chomp.downcase
    return if answer != 'yes'
  end

  loop do
    units.merge!(get_unit_details_from_user)
    puts "Do you want to add another unit? (yes/no)"
    break if gets.chomp.downcase != 'yes'
  end

  write_units_to_file(units, 'units.txt')
end

# Run the script
main_script
