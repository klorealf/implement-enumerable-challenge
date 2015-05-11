shared_examples "a my_enumerable object" do |object|
  before :all do
    raise "Host class must implement my_each" unless object.respond_to?(:my_each)
  end

  # This ensures that your solutions do not make use of
  # Ruby's built in enumerable methods and the each method.
  before :each do
    banned_methods = Enumerable.public_instance_methods + [:each]
    banned_methods.each do |banned_method|
      allow(object).to receive(banned_method) { raise "You used the Ruby method #{banned_method}; Do not use Ruby's built-in Enumearble methods or #each." }
    end
  end


  describe '#my_find', { release: 0 } do
    it 'finds the first element matching the condition' do
      expect(object.my_find &found_find_block).to eq expected_find_result
    end

    it 'returns nothing if no element matches the condition' do
      expect(object.my_find &not_found_find_block).to eq nil
    end
  end

  describe '#my_map', { release: 1 } do
    it 'produces a new array with the block applied to each element' do
      expect(object.my_map &map_block).to eq expected_map_result
    end
  end

  describe '#my_reject', { release: 2 } do
    it "produces a new array of elements that don't match the condition" do
      expect(object.my_reject &reject_block).to match_array expected_reject_result
    end
  end

  describe '#my_select', { release: 3 } do
    it 'produces a new array of elements matching the condition' do
      expect(object.my_select &select_block).to match_array expected_select_result
    end
  end

  pending '#my_all?', { release: 4 } do
    it 'returns true if block is true for all elements' do
      expect(object.my_all? &yes_all_block).to be true
    end

    it 'returns false if block is false for at least one element' do
      expect(object.my_all? &no_not_all_block).to be false
    end

    it 'relies on the truthiness of the block' do
      expect(object.my_all? &truthy_yes_all_block).to be true
      expect(object.my_all? &falsey_no_not_all_block).to be false
    end
  end

  pending '#my_reduce', { release: 5 } do
    it "aggregates a value when only a block is passed" do
      aggregate = object.my_reduce &reduce_block
      expect(aggregate).to eq expected_reduce_result_with_no_starting_aggregate
    end

    it "aggregates a value when only method name is passed" do
      aggregate = object.my_reduce(reduce_method)
      expect(aggregate).to eq expected_reduce_result_with_no_starting_aggregate
    end

    it "aggregates a value when a starting value and block are passed" do
      aggregate = object.my_reduce reduce_starting_aggregate, &reduce_block
      expect(aggregate).to eq expected_reduce_result_with_starting_aggregate
    end

    it "aggregates a value when a starting value and method name are passed" do
      aggregate = object.my_reduce(reduce_starting_aggregate, reduce_method)
      expect(object.my_reduce(reduce_starting_aggregate, reduce_method)).to eq expected_reduce_result_with_starting_aggregate
    end
  end
end
