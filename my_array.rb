require_relative 'my_enumerable'
class Array
  include MyEnumerable

   def my_each
    self.length.times do |i|
      yield(self[i])
    end
  end
end
