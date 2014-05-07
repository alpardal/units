require_relative 'conversions'
require_relative 'quantity'

conversions = Conversions.new.add_conversion('m', 'cm', 100)
                             .add_conversion('cm', 'mm', 10)
                             .add_conversion('in', 'cm', 2.54)
                             .add_conversion('ft', 'in', 12)

meters = Quantity.new(1, 'm')
puts "#{meters} is the same as:"
puts "  #{meters.to('cm', conversions)}"
puts "  #{meters.to('mm', conversions)}"
puts "  #{meters.to('ft', conversions)}"
puts

centimeters = Quantity.new(180, 'cm')
puts "#{centimeters} is the same as:"
puts "  #{centimeters.to('mm', conversions)}"
puts "  #{centimeters.to('m', conversions)}"
puts

milimeters = Quantity.new(25.4, 'mm')
puts "#{milimeters} is the same as:"
puts "  #{milimeters.to('m', conversions)}"
puts "  #{milimeters.to('cm', conversions)}"
puts "  #{milimeters.to('in', conversions)}"
puts

puts "#{meters} + #{milimeters} = #{meters.add(milimeters, conversions)}"
feet = Quantity.new(2, 'ft')
puts "#{centimeters} + #{feet} = #{centimeters.add(feet, conversions)}"
