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
    end
    i += 1
  end
end

def map(array)
  c_d = []
  i = 0
  while i < array.length
    c_d << yield(array[i])
    i += 1
  end
  c_d
end

def reject(array)
  c_d = []
  i = 0
  while i < array.length
    c_d << (array[i]) if !yield(array[i])
    i += 1
  end
  c_d
end

def select(array)
  c_d = []
  i = 0
  while i < array.length
    c_d << (array[i]) if yield(array[i])
    i += 1
  end
  c_d
end

# Coding all? is optional.
def all?(array)
end

# Coding reduce is optional.
def reduce(array, starting_value = nil)
end
