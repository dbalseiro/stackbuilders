#!/usr/local/bin/ruby
require './lib/credit_card_validator'

ARGV.each do |cc|
    validator = CreditCardValidator.new(cc)
    if validator.valid?
        puts "Credit card #{cc} is valid"
    else
        puts "Credit card #{cc} is not valid"
        puts validator.messages
    end
end
