require_relative '../enumerating_methods'

describe 'enumerating behaviors' do

  # The only Ruby methods we may call on an array are :length and :[] to get an element at a specific index
  banned_methods = Enumerable.instance_methods(false) + Array.instance_methods(false) - [:[], :length]

  let(:strings) { ['a', 'ab', 'abc'] }
  let(:numbers) { [1, 2, 3] }

  # This ensures that solutions do not make use of
  # Ruby's built in each method and enumerable methods.
  before(:each) do
    banned_methods.each do |banned_method|
      allow(strings).to receive(banned_method) { raise "We may not use the Ruby method ##{banned_method} in our solution." }
      allow(numbers).to receive(banned_method) { raise "We may not use the Ruby method ##{banned_method} in our solution." }
    end
  end

  describe 'finding an element' do
    it 'returns the first element for which the block returns truthy' do
      found_string = find(strings) { |string| string =~ /ab/ }
      expect(found_string).to eq 'ab'

      found_number = find(numbers) { |number| number > 1 }
      expect(found_number).to eq 2
    end

    it 'returns nil if no element matches the condition' do
      found_string = find(strings) { |string| string.empty? }
      expect(found_string).to be_nil

      found_number = find(numbers) { |number| number.zero? }
      expect(found_number).to be_nil
    end
  end

  describe 'mapping values' do
    it 'produces a new array containing the results of running the block for each element' do
      mapped_strings = map(strings) { |string| string.upcase }
      expect(mapped_strings).to eq ['A', 'AB', 'ABC']

      mapped_numbers = map(numbers) { |number| number * 2 }
      expect(mapped_numbers).to eq [2, 4, 6]
    end
  end

  describe 'rejecting values' do
    it 'produces a new array containing the elements for which the block returns falsey' do
      non_rejected_strings = reject(strings) { |string| string.length < 3 }
      expect(non_rejected_strings).to match_array ['abc']

      non_rejected_numbers = reject(numbers) { |number| number > 2 }
      expect(non_rejected_numbers).to match_array [1, 2]
    end
  end

  describe 'selecting values' do
    it 'produces a new array containing the elements for which the block returns truthy' do
      selected_strings = select(strings) { |string| string.length < 3 }
      expect(selected_strings).to match_array ['a', 'ab']

      selected_numbers = select(numbers) { |number| number > 2 }
      expect(selected_numbers).to match_array [3]
    end
  end

  describe 'determing if all elements meet a condition' do
    it 'returns true if block returns a truthy value for all elements' do
      boolean_for_strings = all?(strings) { |string| string.length < 10 }
      expect(boolean_for_strings).to be true

      boolean_for_numbers = all?(numbers) { |number| number < 10 }
      expect(boolean_for_numbers).to be true
    end

    it 'returns false if block returns a falsey value for at least one element' do
      boolean_for_strings = all?(strings) { |string| string.length < 3 }
      expect(boolean_for_strings).to be false

      boolean_for_numbers = all?(numbers) { |number| number < 1 }
      expect(boolean_for_numbers).to be false
    end

    it 'relies on the truthiness of the block' do
      boolean_for_strings = all?(strings) { |string| 'a truthy value' }
      expect(boolean_for_strings).to be true

      boolean_for_numbers = all?(numbers) { |number| nil }
      expect(boolean_for_numbers).to be false
    end
  end

  describe 'aggregating values' do
    it "aggregates a value" do
      aggregated_strings = reduce(strings) { |aggregate, string| aggregate + string }
      expect(aggregated_strings).to eq 'aababc'

      aggregated_numbers = reduce(numbers) { |aggregate, number| aggregate * number }
      expect(aggregated_numbers).to eq 6
    end

    it 'does not not change the collection' do
      expect { reduce(strings) { |aggregate, string| aggregate + string } }.to_not change { strings }
    end
  end
end
