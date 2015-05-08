require_relative "spec_helper"

include MyArrayEnumerableBehaviorTestSetup

describe MyArray do
  describe '#my_each' do
    it 'iterates over each element, passing it to the supplied block' do
      my_array = MyArray.new
      my_array << 1
      my_array << 2

      expect { |block| my_array.my_each &block }.to yield_successive_args(1, 2)
    end
  end

  context "when it contains strings" do
    set_up_tests_for_my_array_of_strings

    it_behaves_like "a my_enumerable object", MyArrayOfStrings
  end

  context "when it contains numbers" do
    set_up_tests_for_my_array_of_numbers

    it_behaves_like "a my_enumerable object", MyArrayOfNumbers
  end
end
