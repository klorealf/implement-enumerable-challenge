require_relative('my_enumerated_code')

describe Array do
  let(:sample_array) { [1,2,3,4,5] }

  before :each do
    banned_methods = Enumerable.public_instance_methods + [:each]
    banned_methods.each do |method|
      expect(sample_array).to_not receive(method)
    end
  end

  describe '#my_each' do
    it 'should iterate through each element' do
      dest = []
      sample_array.my_each {|element| dest << element}
      expect(dest).to eq(sample_array)
    end
  end

  describe '#my_select' do
    it 'should produce a new array of elements matching the condition' do
      evens = sample_array.my_select { |element| element.even? }
      expect(evens).to eq([2,4])
    end
  end

  describe '#my_reject' do
    it "should produce a new array of elements that don't match the condition" do
      odds = sample_array.my_reject { |element| element.even? }
      expect(odds).to eq([1,3,5])
    end
  end

  describe '#my_find' do
    it 'should find the first element matching the condition' do
      four = sample_array.my_find { |element| element == 4 }
      expect(four).to eq(4)
    end
  end

  describe '#my_map' do
    it 'should produce a new array with the block applied to each element' do
      doubles = sample_array.my_map { |element| element * 2 }
      expect(doubles).to eq([2,4,6,8,10])
    end
  end

  pending '#my_reduce' do
    it 'should reduce an array using block' do
      sum = sample_array.my_reduce(0) { |total, element| total + element }
      expect(sum).to eq(15)
    end
  end

  pending '#my_all?' do
    it 'should return true if block is true for all elements' do
      expect(sample_array.my_all? {|element| element.is_a? Fixnum}).to be(true)
      expect(sample_array.my_all? {|element| element.is_a? String}).to be(false)
    end
  end
end
