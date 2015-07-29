# Implementing Enumerable Methods

## Summary
In this challenge, we're going to recreate the functionality in some of Ruby's most commonly used enumerable methods.  Where Ruby provides an `Enumerable#select` method, we're going to write a `MyEnumerable#my_select` method.

Going forward through DBC we'll be using Ruby's built-in enumerable methods, but creating these methods ourselves will help us to understand what's going on behind the scenes.  It will also give us practice writing methods that yield to blocks.

This challenge assumes that we're at least somewhat familiar with Ruby's `Enumerable` module.  We won't be using it directly, but we should conceptually understand what it is and some of the behaviors that it provides for working with collections (e.g., arrays and hashes).  Some of the more critical points are detailed in the sections that follow.


### `MyArray` and `MyEnumerable`
We're going to be working with a custom class, `MyArray` (see file `my_array.rb`).  It acts just like a normal array, but it has some additional behaviors.  For starters, the `MyArray` class includes the `MyEnumerable` module wherein we'll be defining our versions of the enumerable methods.

`MyArray` also defines an instance method: `#my_each`.  Similarly to how Ruby's enumerable methods depend on objects responding to `#each`, our enumerable methods are going to rely on objects having a `#my_each` method.

We'll be writing our own enumerable methods in the `MyEnumerable` module (see file `source/my_enumerable.rb`).  Empty method definitions have been provided for us.  We need to code the behavior for each method.


### Blocks
When we call most enumerable methods, we generally pass a block.  The enumerable methods themselves are pretty generic and are made to be used in different circumstances.  For example, `Enumerable#reject` will return a subset of a collection where some condition is not met.

Given a collection of numbers, I could use `#reject` to get a new collection where all of the even numbers were removed:

```ruby
[1,2,3].reject { |number| number.even? }
# => [1, 3]
```
*Figure 1*.  Example using `Enumerable#reject`.

But I could also use `#reject` with a collection of arrays to reject the arrays with more than five elements.  Or with a collection of ... well, a collection of any objects ...

We use the blocks to define the specifics for how the enumerable method should run.  Each element in the collection is passed to the block, and the block is evaluated.  In Figure 1, `1`, `2`, and `3` were each passed to the block as `number`.  Of course, each method will do something different with the values returned from the block.

As we write our versions of the enumerable methods, we'll want to understand how blocks are passed to methods and referenced in the method definitions.  These links might prove helpful if these concepts are new or a refresher is in order.

* [Methods can Implicitly Take a Block](http://www.skorks.com/2013/04/ruby-ampersand-parameter-demystified/#theimplicitblock)
* [Blocks and Yield in Ruby](http://stackoverflow.com/questions/3066703/blocks-and-yields-in-ruby)
* [The Building Blocks of Ruby](http://yehudakatz.com/2010/02/07/the-building-blocks-of-ruby/)


### Do Not Use Enumerable Methods
Do not use Ruby's built-in `#each` method or the actual `Enumerable` methods.  In defining our methods, we may call any method that begins with `my_`.  In other words, the methods we're writing ourselves.  `MyArray#my_each` is already implemented for us, and we'll want to make use of it in the methods we write.  Some of the methods can be implemented in terms of *each other*. For example, `#my_select` and `#my_find` do similar things, can we leverage that?


##Releases
###Pre-Release: Test Objects
In our tests, we'll be working with two distinct objects.  Both of them are instances of our `MyArray` class.

- `strings` which looks like `['a', 'ab', 'abc']`
- `numbers` which looks like `[1, 2, 3]`

Usually, we want to have one expectation written per test example.  In most of our tests we'll have two expectations:  one for working with our `strings` object and one for working with `numbers`.  We're doing this to help ensure that we aren't unknowingly writing enumerable methods that only work in one specific context.  (see `spec/my_array_spec.rb`)


### Release 0: Write the `#my_find` method
```
$ rspec --example "my find method"
```
*Figure 2*. Running only the tests defined in the `'my find method'` example group.

We'll work through the enumerable behaviors one at a time, beginning with finding a single element in a collection.  We are going to mimic the behavior of Ruby's [`Enumerable#find`](http://ruby-doc.org/core-2.0.0/Enumerable.html#method-i-find) method.  What does the Ruby method do?

Tests for the behavior of the `#my_find` method have been written. These tests are organized within an example group with the description `my find method` (see Line 46 in `spec/my_array_spec.rb`).  We can run only these tests by specifying the name of the example group when running RSpec (see Figure 2).


### Release 1: Write the `#my_map` method
```
$ rspec --example "my map method"
```
*Figure 3*. Running only the tests defined in the `'my map method'` example group.


Tests for the behavior of the `#my_map` method have been written to mimic the behavior of Ruby's [`Enumerable#map`](http://ruby-doc.org/core-2.0.0/Enumerable.html#method-i-map).


### Release 2: Write the `#my_reject` method
```
$ rspec --example "my reject method"
```
*Figure 4*. Running only the tests defined in the `'my reject method'` example group.

Tests for the behavior of the `#my_reject` method have been written to mimic the behavior of Ruby's [`Enumerable#reject`](http://ruby-doc.org/core-2.0.0/Enumerable.html#method-i-reject).


### Release 3: Write the `#my_select` method
```
$ rspec --example "my select method"
```
*Figure 5*. Running only the tests defined in the `'my select method'` example group.

Tests for the behavior of the `#my_select` method have been written to mimic the behavior of Ruby's [`Enumerable#select`](http://ruby-doc.org/core-2.0.0/Enumerable.html#method-i-select).


### Release 4 (*optional*): Write the `#my_all?` method
```
$ rspec --example "my all? method"
```
*Figure 6*. Running only the tests defined in the `'my all? method'` example group.

Tests for the behavior of the `#my_all?` method have been written to mimic the behavior of Ruby's [`Enumerable#all?`](http://ruby-doc.org/core-2.0.0/Enumerable.html#method-i-all-3F).


### Release 5 (*optional*): Write the `#my_reduce?` method
```
$ rspec --example "my reduce method"
```
*Figure 7*. Running only the tests defined in the `'my reduce method'` example group.

Tests for the behavior of the `#my_reduce` method have been written to mimic the behavior of Ruby's [`Enumerable#reduce`](http://ruby-doc.org/core-2.0.0/Enumerable.html#method-i-reduce).  We'll be writing a simplified version.  The Ruby method can be called in four different ways with different combinations of arguments.  Our method will be callable in only two different, related ways.


##Conclusion
We've worked through writing homemade versions of just a sample of Ruby's enumerable methods, and we should understand what each of them does.  These particular methods happen to be some that we'll commonly see and use, so we want to be very familiar with them.  After completing this challenge, we should, in particular, definitely know what the `#find`, `#select`, and `#map` methods do.  These are methods we'll use very regularly, and we need to know them inside and out.  Before moving on to the next challenge, make sure we understand the methods covered in this challenge.
