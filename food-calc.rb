# frozen_string_literal: true
require 'colorize'

YES = 'yes'
NO = 'no'
READ = 'read'
NEW = 'new'

# Stores the units and their details in a hash
def read_units_from_file(filename)
  units = {}
  File.open(filename, 'r') do |file|
    file.each_line do |line|
      unit_name, weight, price, daily_amount, daily_price = line.chomp.split(',')
      units[unit_name] = {
        weight: weight.to_f,
        price: price.to_f,
        daily_amount: daily_amount.to_f,
        daily_price: daily_price.to_f
      }
    end
  end
  units
rescue Errno::ENOENT
  puts 'The file does not exist. Starting with an empty units list.'
  {}
end

# Displays the units and their details
def display_units(units)
  # Print table headers
  printf("%-20s %-10s %-10s %-15s %-15s\n", "Unit Name", "Weight", "Price", "Daily Amount", "Daily Price")
  printf("\e[34m%-20s %-10s %-10s %-15s %-15s\n\e[0m", "-"*20, "-"*10, "-"*10, "-"*15, "-"*15) # this will print the line under headers

  # Print each unit
  units.each do |unit_name, details|
    printf("%-20s %-10s %-10s %-15s %-15s\n",
           unit_name,
           details[:weight],
           details[:price],
           details[:daily_amount],
           details[:daily_price])
  end
end

# Gets the unit details from the user and returns them as a hash
def get_unit_details_from_user
  puts 'Enter the unit name: '
  unit_name = gets.chomp
  puts 'Enter the unit weight: '
  unit_weight = gets.chomp.to_f
  puts 'Enter the unit price: '
  unit_price = gets.chomp.to_f
  puts 'Enter the amount taken daily: '
  daily_amount = gets.chomp.to_f
  daily_price = ((unit_price.to_f * daily_amount.to_f) / unit_weight.to_f).ceil
  puts "The daily price: #{daily_price}"

  { unit_name => { weight: unit_weight, price: unit_price, daily_amount: daily_amount, daily_price: daily_price } }
end

# Writes the units and their details to a file
def write_units_to_file(units, filename)
  File.open(filename, 'w') do |file|
    units.each do |unit_name, details|
      file.puts "#{unit_name},#{details[:weight]},#{details[:price]},#{details[:daily_amount]},#{details[:daily_price]}"
    end
  end
end

# Calculates the full price for the units
def calculate_full_price(units)
  units.values.sum { |details| details[:daily_price] }
end

# Main script
def main_script
  puts "\nWelcome to our units manager!\nYou can either read existing units from a file or create new ones.".green
  puts "Do you want to read from the file or create new entries? (#{READ}/#{NEW})"
  user_choice = gets.chomp.downcase
  units = {}

  if user_choice == READ
    units = read_units_from_file('units.txt')
    display_units(units)
    puts "The full price: #{calculate_full_price(units)}".red
    puts 'Do you want to add more units? (yes/no)'
    add_more_units = gets.chomp.downcase
    return if add_more_units != YES
  end

  loop do
    units.merge!(get_unit_details_from_user)
    puts 'Do you want to add another unit? (yes/no)'
    if gets.chomp.downcase != YES
      puts "The full price: #{calculate_full_price(units)}"
      break
    end
  end

  write_units_to_file(units, 'units.txt')
end

# Run the script
main_script