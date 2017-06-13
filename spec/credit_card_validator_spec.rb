require 'rspec'
require 'credit_card_validator'

RSpec.describe CreditCardValidator do
    context "given an empty credit card number" do
        it "should be invalid with an error message" do
            validator = CreditCardValidator.new
            expect(validator).to_not be_valid
            expect(validator.messages).to include(CreditCardValidator::EMPTY_STR)
        end
    end

    context "given invalid length strings" do 
        ["1234", "12345678901234567890"].each do |invalid_length_cc_number|
            it "#{invalid_length_cc_number.inspect} should be invalid" do
                validator = CreditCardValidator.new(invalid_length_cc_number)
                expect(validator).to_not be_valid
                expect(validator.messages).to include(CreditCardValidator::INVALID_LENGTH)
            end
        end
    end

    context "given a valid credit card number" do
        ["4012888888881881"].each do |valid_cc_number|
            it "#{valid_cc_number} shold be valid and there must not be any error message" do
                validator = CreditCardValidator.new(valid_cc_number)
                expect(validator).to be_valid
                expect(validator.messages).to be_empty
            end
        end
    end

    context "given an invalid credit card number" do
        ["4012888888881882"].each do |valid_cc_number|
            it "#{valid_cc_number} shold be invalid and there must be an error message" do
                validator = CreditCardValidator.new(valid_cc_number)
                expect(validator).to_not be_valid
                expect(validator.messages).to include(CreditCardValidator::INVALID_CARD_NUMBER)
            end
        end
    end

    context "given ill-formatted credit card numbers" do
        ["kjhfkjh", "1q2w3e4r5t6y7u8i", "1234-5678-9012-8374", "!@#TY&*", " "].each do |ill_formatted_cc_number|
            it "#{ill_formatted_cc_number} shold be invalid" do
                validator = CreditCardValidator.new(ill_formatted_cc_number)
                expect(validator).to_not be_valid
                expect(validator.messages).to include(CreditCardValidator::INVALID_FORMAT)
            end
        end
    end
end
