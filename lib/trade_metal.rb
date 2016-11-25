class TradeMetal
 
  attr_accessor :coin_name, :unit_price
  @@metals = []
 
  def initialize(coin_name, unit_price)
    @coin_name = coin_name
    @unit_price = unit_price
    @@metals << self
  end
 
  def self.get_trade_metal(question)
    literals = question.split
    @@metals.detect {|trademetal| literals.include? trademetal.coin_name}
  end
end