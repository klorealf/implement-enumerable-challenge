require_relative "spec_helper"

describe MyArray do
  # This ensures that solutions do not make use of
  # Ruby's built in each method and enumerable methods.
  before(:each) do
    banned_methods = Enumerable.public_instance_methods + [:each]
    banned_methods.each do |banned_method|
      allow_any_instance_of(MyArray).to receive(banned_method) { raise "You used the Ruby method #{banned_method}; Do not use Ruby's built-in Enumearble methods or #each." }
    end
  end

  describe 'my_each' do
    it 'iterates over each element, passing it to the supplied block' do
      my_array = MyArray.new
      my_array << 1
      my_array << 2

      expect { |block| my_array.my_each &block }.to yield_successive_args(1, 2)
    end
  end

  describe 'behaviors from the MyEnumerable module' do
    before(:all) do
      raise 'MyArray class must implement my_each for the MyEnumerable module to work' unless MyArray.new.respond_to?(:my_each)
    end

    # Create a MyArray object that looks like ['a', 'ab', 'abc']
    let(:strings) do
      strings = MyArray.new
      strings << 'a'
      strings << 'ab'
      strings << 'abc'
      strings
    end

    # Create a MyArray object that looks like [1, 2, 3]
    let(:numbers) do
      numbers = MyArray.new
      numbers << 1
      numbers << 2
      numbers << 3
      numbers
    end

    describe 'my find method' do
      it 'returns the first element for which the block returns truthy' do
        found_string = strings.my_find { |string| string =~ /ab/ }
        expect(found_string).to eq 'ab'

        found_number = numbers.my_find { |number| number > 1 }
        expect(found_number).to eq 2
      end

      it 'returns nothing if no element matches the condition' do
        found_string = strings.my_find { |string| string.empty? }
        expect(found_string).to be_nil

        found_number = numbers.my_find { |number| number.zero? }
        expect(found_number).to be_nil
      end
    end

    describe 'my map method' do
      it 'produces a new array containing the results of running the block for each element' do
        mapped_strings = strings.my_map { |string| string[0] }
        expect(mapped_strings).to match_array ['a', 'a', 'a']

        mapped_numbers = numbers.my_map { |number| number - number }
        expect(mapped_numbers).to match_array [0, 0, 0]
      end
    end

    describe 'my reject method' do
      it "produces a new array containing the elements for which the block returns falsey" do
        non_rejected_strings = strings.my_reject { |string| string.length < 3 }
        expect(non_rejected_strings).to match_array ['abc']

        non_rejected_numbers = numbers.my_reject { |number| number > 2 }
        expect(non_rejected_numbers).to match_array [1, 2]
      end
    end

    describe 'my select method' do
      it 'produces a new array containing the elements for which the block returns truthy' do
        selected_strings = strings.my_select { |string| string.length < 3 }
        expect(selected_strings).to match_array ['a', 'ab']

        selected_numbers = numbers.my_select { |number| number > 2 }
        expect(selected_numbers).to match_array [3]
      end
    end

    describe 'my all? method' do
      it 'returns true if block returns a truthy value for all elements' do
        boolean_for_strings = strings.my_all? { |string| string.length < 10 }
        expect(boolean_for_strings).to be true

        boolean_for_numbers = numbers.my_all? { |number| number < 10 }
        expect(boolean_for_numbers).to be true
      end

      it 'returns false if block returns a falsey value for at least one element' do
        boolean_for_strings = strings.my_all? { |string| string.length < 3 }
        expect(boolean_for_strings).to be false

        boolean_for_numbers = numbers.my_all? { |number| number < 1 }
        expect(boolean_for_numbers).to be false
      end

      it 'relies on the truthiness of the block' do
        boolean_for_strings = strings.my_all? { |string| 'a truthy value' }
        expect(boolean_for_strings).to be true

        boolean_for_numbers = numbers.my_all? { |number| nil }
        expect(boolean_for_numbers).to be false
      end
    end

    describe 'my reduce method' do
      it "aggregates a value when only a block is passed" do
        aggregated_strings = strings.my_reduce { |aggregate, string| aggregate + string }
        expect(aggregated_strings).to eq 'aababc'

        aggregated_numbers = numbers.my_reduce { |aggregate, number| aggregate * number }
        expect(aggregated_numbers).to eq 6
      end

      it "aggregates a value when a starting value and block are passed" do
        aggregated_strings = strings.my_reduce('ZZZ') { |aggregate, string| aggregate + string }
        expect(aggregated_strings).to eq 'ZZZaababc'

        aggregated_numbers = numbers.my_reduce(100) { |aggregate, number| aggregate * number }
        expect(aggregated_numbers).to eq 600
      end

      it 'does not not change the my_array object' do
        expect { strings.my_reduce { |aggregate, string| aggregate + string } }.to_not change { strings }
      end
    end
  end
end
