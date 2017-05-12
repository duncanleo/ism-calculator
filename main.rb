require 'optparse'

MINIMUM_BROKERAGE_FEE_OFFLINE = 40
MINIMUM_BROKERAGE_FEE_ONLINE = 25

PERCENTAGE_BROKERAGE_FEES_OFFLINE = [0.5, 0.25]
PERCENTAGE_BROKERAGE_FEES_ONLINE = [0.275, 0.18]
PERCENTAGE_CLEARING_FEE = 0.0325
PERCENTAGE_TRADING_ACCESS_FEE = 0.0075
PERCENTAGE_GST = 7.0

$options = {
	:online => false,
	:buyprice => 0.0,
	:quantity => 0
}

OptionParser.new do |opts|
	opts.banner = "Usage: main.rb [options"

	opts.on('-o', '--online', 'Online trade') { |v| $options[:online] = true }
	opts.on('-b', '--buyprice BUYPRICE', 'Buy Price') { |v| $options[:buyprice] = v.to_f }
	opts.on('-q', '--quantity QUANTITY', 'Quantity') { |v| $options[:quantity] = v.to_i }

end.parse!

$gross_consideration = $options[:quantity] * $options[:buyprice]

def brokerage_fee
	$options[:online] ? (
		PERCENTAGE_BROKERAGE_FEES_ONLINE.map{ |p| p / 100 * $gross_consideration }
																		.push(MINIMUM_BROKERAGE_FEE_ONLINE)
																		.max
	) : (
		PERCENTAGE_BROKERAGE_FEES_OFFLINE.map{ |p| p / 100 * $gross_consideration }
																		 .push(MINIMUM_BROKERAGE_FEE_OFFLINE)
																		 .max
	)
end

def clearing_fee
	$gross_consideration * PERCENTAGE_CLEARING_FEE / 100
end

def trading_access_fee
	$gross_consideration * PERCENTAGE_TRADING_ACCESS_FEE / 100
end

def gst
	(PERCENTAGE_GST / 100) * (brokerage_fee + clearing_fee + trading_access_fee)
end

puts "Brokerage Fee = $#{brokerage_fee}"
puts "Clearing Fee = $#{clearing_fee}"
puts "Trading Access Fee = $#{trading_access_fee}"
puts "GST = $#{gst}"

total = $gross_consideration + brokerage_fee + clearing_fee + trading_access_fee + gst
puts "Total = $%.2f" % total
