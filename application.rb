require './lib/merchant_guide_to_galaxy'
require './lib/trade_metal'
require './lib/translation'

puts "Test Output:"
File.open("#{Dir.pwd}/input/data.txt", "r").each_line do |line|
  obj=MerchantGuideToGalaxy.new(line)
  obj.compute_line
end