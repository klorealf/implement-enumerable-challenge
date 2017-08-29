#each is already implemented as an example, check the test for it too!
def each(array)
  i = 0
  while i < array.length
     yield(array[i])
    i += 1
  end
end

def find(array)
  i = 0
  while i < array.length
    if yield(array[i])
     return array[i]
    else
      i += 1
    end
  end
end
#strings = ['a', 'ab', 'abc']
#result = find(strings) { |string| string }
#p result

def map(array)
  res_array = Array.new(array.length, 0)
  i = 0
  while i < array.length
     res_array[i] = yield(array[i])
    i += 1
  end
  return res_array
end

def reject(array)
  res_array = []
  i = 0
  while i < array.length
    if yield(array[i]) == false
      res_array << array[i]
    end
  i += 1
  end
  return res_array
end

def select(array)
  res_array = []
  i = 0
  while i < array.length
    if yield(array[i]) == true
      res_array << array[i]
    end
  i += 1
  end
  return res_array
end

def prod(array)
  prod = 1
  array.each do |elm|
    prod = prod * elm
  end
  return prod
end

# Coding all? is optional.
def all?(array)
  nb_elts = array.length
  aux_array = Array.new(nb_elts, 0)
  i = 0
  while i < nb_elts
    if yield(array[i])
      aux_array[i] = 1
    end
    i += 1
  end

  if prod(aux_array) == 1
    return true
  else
    return false
  end

end

# Coding reduce is optional.
def reduce(array, starting_value = nil)
end
