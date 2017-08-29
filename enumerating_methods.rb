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
    return array[i] if yield(array[i])
    i += 1
  end
end


def map(array)
  arr = []
  i = 0
  while i < array.length
    arr << yield(array[i])
    i += 1
  end
  arr
end

def reject(array)
   arr = []
  i = 0
  while i < array.length
   arr << array[i] unless yield(array[i])
    i += 1
  end
  arr
end

def select(array)
     arr = []
  i = 0
  while i < array.length
   arr << array[i] if yield(array[i])
    i += 1
  end
  arr
end

# Coding all? is optional.
def all?(array)
end

# Coding reduce is optional.
def reduce(array, starting_value = nil)
end
