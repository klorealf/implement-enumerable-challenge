# Implementing Enumerable Methods

## Summary
In this challenge, we're going to recreate the functionality of some of Ruby's more commonly used enumerable methods.  The behaviors that we will be working with are common across different languages, not just Ruby.  We want to be familiar with how programmers commonly work with collections of objects, like arrays.

Going forward through DBC we'll be using Ruby's built-in enumerable methods, but creating similar methods ourselves will help us to understand what's going on behind the scenes.  It will also give us practice writing methods that yield to blocks.

This challenge assumes that we're at least somewhat familiar with Ruby's `Enumerable` module.  We won't be using it directly, but we should conceptually understand what it is and some of the behaviors that it provides for working with collections (e.g., arrays and hashes).  Some of the more critical points are detailed in the sections that follow.


### Blocks
When we call most enumerable methods, we generally pass a block.  The enumerable methods themselves are pretty generic and are made to be used in different circumstances.  For example, `Enumerable#reject` will return a subset of a collection where some condition is not met.

Given a collection of numbers, we could use `#reject` to get a new collection where all of the even numbers were removed:

```ruby
[1,2,3].reject { |number| number.even? }
# => [1, 3]
```
*Figure 1*.  Example using `Enumerable#reject`.

But we could also use `#reject` with a collection of arrays to reject the arrays with more than five elements.  Or with a collection of ... well, a collection of any objects ...

We use the blocks to define the specifics for how the enumerable method should run.  Each element in the collection is passed to the block, and the block is evaluated.  In Figure 1, `1`, `2`, and `3` were each passed to the block as `number`.  Of course, each method will do something different with the values returned from the block.

As we write our versions of the enumerable methods, we'll want to understand how blocks are passed to methods and referenced in the method definitions.  These links might prove helpful if these concepts are new or a refresher is in order.

* [Methods can Implicitly Take a Block](http://www.skorks.com/2013/04/ruby-ampersand-parameter-demystified/#theimplicitblock)
* [Blocks and Yield in Ruby](http://stackoverflow.com/questions/3066703/blocks-and-yields-in-ruby)
* [The Building Blocks of Ruby](http://yehudakatz.com/2010/02/07/the-building-blocks-of-ruby/)


### Restrictions:  Do Not Use Most Array and Enumerable Methods
```ruby
numbers = [1, 6, 3, 7, 9]
# => [1, 6, 3, 7, 9]
numbers[2]
# => 3
numbers.length
# => 5
```
*Figure 2*. Accessing an element at a specific array index and getting the length of an array.

In this challenge, we're not going to utilize much of Ruby's built-in array functionality.  We'll only be permitted to call two methods on array objects:  `#[]` and `#length` (see Figure 2 for example usage).  Do not use Ruby's built-in `#each` method or any of the other `Array` and `Enumerable` instance methods.  We are free to use other Ruby keywords and methods (e.g., `loop`, `while`, `#times`, etc.).


##Releases
###Pre-Release: Test Objects
In our tests, we'll be working with two distinct objects.  Both of them are arrays.

- `strings` which looks like `['a', 'ab', 'abc']`
- `numbers` which looks like `[1, 2, 3]`

Usually, we want to have one expectation written per test example.  In most of our tests we'll have two expectations:  one for working with our `strings` object and one for working with `numbers`.  We're doing this to help ensure that we aren't unknowingly writing enumerable methods that only work in one specific context.  (see `spec/enumerating_methods_spec.rb`)


### Release 0: Find
```ruby
numbers = [4, 5, 6]
# => [4, 5, 6]
find(numbers) { |n| n > 4 }
# => 5
```
*Figure 3*.  Example usage of the find method we'll write.

We'll work through the enumerable behaviors one at a time, beginning with searching for a single element in a collection.  We are going to mimic the behavior of Ruby's [`Enumerable#find`](http://ruby-doc.org/core-2.0.0/Enumerable.html#method-i-find) method.  What does the Ruby method do?  We'll want to mimic that behavior in our method (see Figure 3).

```
$ rspec --example "find"
```
*Figure 4*. Running only the tests defined in the `'find'` example group.

Tests for the behavior of the `find` method have been written. These tests are organized within an example group with the description `"find"` (see Line 20 in `spec/enumerating_methods_spec.rb `).  We can run only these tests by specifying the name of the example group when running RSpec (see Figure 4).


### Release 1: Map
```ruby
numbers = [4, 5, 6]
# => [4, 5, 6]
map(numbers) { |n| n.to_s + 'a' }
# => ['4a', '5a', '6a']
```
*Figure 5*.  Example usage of the map method we'll write.

Tests for the behavior of the `map` method have been written to mimic the behavior of Ruby's [`Enumerable#map`](http://ruby-doc.org/core-2.0.0/Enumerable.html#method-i-map).


### Release 2: Select
```ruby
numbers = [4, 5, 6]
# => [4, 5, 6]
select(numbers) { |n| n < 6 }
# => [4, 5]
```
*Figure 7*.  Example usage of the map method we'll write.

Tests for the behavior of the `select` method have been written to mimic the behavior of Ruby's [`Enumerable#select`](http://ruby-doc.org/core-2.0.0/Enumerable.html#method-i-select).


### Release 3: Reject
```ruby
numbers = [4, 5, 6]
# => [4, 5, 6]
reject(numbers) { |n| n < 5 }
# => [5, 6]
```
*Figure 6*.  Example usage of the map method we'll write.

Tests for the behavior of the `reject` method have been written to mimic the behavior of Ruby's [`Enumerable#reject`](http://ruby-doc.org/core-2.0.0/Enumerable.html#method-i-reject).


### Release 4: All?  *(optional)*
```ruby
numbers = [4, 5, 6]
# => [4, 5, 6]
all?(numbers) { |n| n < 6 }
# => false
all?(numbers) { |n| n < 7 }
# => true
```
*Figure 8*.  Example usage of the map method we'll write.

Tests for the behavior of the `all?` method have been written to mimic the behavior of Ruby's [`Enumerable#all?`](http://ruby-doc.org/core-2.0.0/Enumerable.html#method-i-all-3F).


### Release 5: Reduce *(optional)*
```ruby
numbers = [4, 5, 6]
# => [4, 5, 6]
reduce(numbers) { |aggregate, n| aggregate + n }
# => 15
```
*Figure 9*.  Example usage of the map method we'll write.

Tests for the behavior of the `reduce` method have been written to mimic the behavior of Ruby's [`Enumerable#reduce`](http://ruby-doc.org/core-2.0.0/Enumerable.html#method-i-reduce).  The Ruby method can be called in four different ways with different combinations of arguments. Our method will only be callable one way; remember we want to understand the basic concept of what it means to reduce a collection.


##Conclusion
We've worked through writing homemade versions of just a sample of Ruby's enumerable methods, and we should understand what each of them does.  These particular methods happen to be some that we'll commonly see and use, so we want to be very familiar with them.  After completing this challenge, we should, in particular, definitely know what the `#find`, `#select`, and `#map` methods do.  These are methods we'll use very regularly, and we need to know them inside and out.  Before moving on to the next challenge, make sure we understand the methods covered in this challenge.
