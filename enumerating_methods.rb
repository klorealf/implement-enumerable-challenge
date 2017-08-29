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
  i = 0
  new_array = []
  while i < array.length
    new_array << yield(array[i])
    i += 1
  end
  new_array
end

def reject(array)
  i = 0
  new_array = []
  while i < array.length
    if yield(array[i]) == false
      new_array << array[i]
    end
    i += 1
  end
  new_array
end

def select(array)
  i = 0
  new_array = []
  while i < array.length
    if yield(array[i]) == true
      new_array << array[i]
    end
    i += 1
  end
  new_array
end

# Coding all? is optional.
def all?(array)
end

# Coding reduce is optional.
def reduce(array, starting_value = nil)
end
