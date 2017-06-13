class CreditCardValidator
    attr_accessor :cc_number
    attr_accessor :messages

    #constants
    LENGTH = 16
    EMPTY_STR = "Credit card number shout not be empty"
    INVALID_LENGTH = "Credit card number must be #{LENGTH} characters long"
    INVALID_FORMAT = "Credit card number is not formatted correctly"
    INVALID_CARD_NUMBER = "Credit card number is invalid"

    def initialize(number = '')
        @cc_number = number
        @messages = []
    end

    def valid?
        messages.push(EMPTY_STR) if @cc_number.empty?
        messages.push(INVALID_LENGTH) if @cc_number.length != LENGTH
        messages.push(INVALID_FORMAT) if @cc_number.scan(/^[0-9]+$/).empty? #only digits

        if messages.empty?
            messages.push(INVALID_CARD_NUMBER) if not valid_number?
        end

        #returns true if there are no error messages
        messages.empty?
    end

    private

    def valid_number?
        arr = @cc_number.chars
        arr.map!(&:to_i) #convert digits to integer

        #1. Double the value of every second digit beginning from the right. For
        #example [1,2,7,4] becomes [2,2,14,4].
        #To do that i reverse the array and double every odd index
        arr.reverse!
        arr.map!.with_index { |x, i| if i % 2 != 0 then x * 2 else x end }

        #2. Sum all the digits.
        #For example, [2,2,14,4] becomes 2+2+1+4+4 = 13
        #join back all numbers and split agaun to sum each member
        sum = arr.join.chars.map(&:to_i).reduce(:+)

        #3. Calculate the remainder when the sum is divided by 10.
        #For the above example, the remainder would be 3.
        remainder = sum % 10

        #4. If the result equals 0, the credit card number is valid.
        remainder == 0
    end
end
