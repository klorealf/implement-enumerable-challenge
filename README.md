# Implementing Enumerable Methods

## Summary
In this challenge, we're going to recreate the functionality in some of Ruby's most commonly used enumerable methods.  Where Ruby provides an `Enumerable#select` method, we're going to write a `MyEnumerable#my_select` method.

Going forward through DBC we'll be using Ruby's built-in enumerable methods, but creating these methods ourselves will help us to understand what's going on behind the scenes.  It will also give us practice writing methods that yield to blocks.

This challenge assumes that we're at least somewhat familiar with Ruby's `Enumerable` module.  We won't be using it directly, but we should conceptually understand what it is and some of the behaviors that it provides for working with collections (e.g., arrays and hashes).  Some of the more critical points are detailed in the sections that follow.


### `MyArray` and `MyEnumerable`
We're going to be working with a custom class, `MyArray` (see file `source/my_array.rb`).  It acts just like a normal array, but it has some additional behaviors.  For starters, the `MyArray` class includes the `MyEnumerable` module wherein we'll be defining our versions of the enumerable methods.

`MyArray` also defines an instance method: `#my_each`.  Similarly to how Ruby's enumerable methods depend on objects responding to `#each`, our enumerable methods are going to rely on objects having a `#my_each` method.  

We'll be writing our own enumerable methods in the `MyEnumerable` module (see file `source/my_enumerable.rb`).  Empty method definitions have been provided for us.  We need to code the behavior for each method.


### Blocks
When we call most enumerable methods, we generally pass a block.  The enumerable methods themselves are pretty generic and are made to be used in different circumstances.  For example, `Enumerable#reject` will return a subset of a collection where some condition is not met.

Given a collection of numbers, I could use `#reject` to get a new collection where all of the even numbers were removed:

```ruby
[1,2,3].reject { |number| number.even? }
 => [1, 3]
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


### Testing Overview
The test setup for this challenge is more advanced than we're used to.  A good bit of the organization of the tests might seem incomprehensible today ... and for a little while even.  That's perfectly fine.  For today, we can still use the tests to give us feedback on whether or not our solutions are working.

We're new to testing and working with RSpec.  But, when we test a mixin like our `MyEnumerable` module, it's often helpful to use [shared examples](https://www.relishapp.com/rspec/rspec-core/docs/example-groups/shared-examples).  Defining shared examples creates a group of tests that can be used in other places.  We have shared examples called `"a my_enumerable object"` defined in `spec/support/my_enumerable_behaviors.rb`.  These describe the behaviors of objects that mix in the `MyEnumerable` module.  We use them in `spec/my_array.rb` to specify that a `MyArray` object `it_behaves_like "a my_enumerable object"`.  We could use this same shared examples group in any class that mixes in `MyEnumerable`.

```ruby
describe '#my_find', { release: 0 } do
  # Individual tests here ...
end
```
*Figure 2*.  Tagging an RSpec example group.

We'll also be working with [tags](https://www.relishapp.com/rspec/rspec-core/v/2-4/docs/command-line/tag-option).  Each challenge release will have its own tag, so that we can run only the tests tagged for the release we're working on.  In Figure 2, we can see that the example group `#my_find` has been given a tag:  `{ release: 0 }`.  As we'll see, this tag will allow us to run specific tests rather than the entire test suite.


##Releases
###Pre-Release: Test Objects
In our tests, we'll be working with two distinct objects.  Both of them are instances of our `MyArray` class.  Each is defined in the file `spec/support/my_array_enumerable_behavior_test_setup.rb`.  In addition to two helper methods for RSpec that help setup our tests, this file provides two constants which define the objects we'll be working with:

- `MyArrayOfStrings` which looks like `["a", "ab", "abc"]`.
- `MyArrayOfNumbers` which looks like `[1, 2, 3]`.

We'll be running tests on these two objects in parallel.  We're doing this to help ensure that we aren't unknowingly writing enumerable methods that only work in one particular context.  In `spec/my_array_spec.rb`, we'll notice that two contexts are set up:  `when it contains strings` and `when it contains numbers`.  Each context runs the same general tests, only with different expectations.


### Release 0: Write the `#my_find` method

| my_array             | block                         | expected result |
| :------------------- | :---------------------------- | :-------------- |
| `["a", "ab", "abc"]` | `{ |string| string =~ /ab/ }` | `"ab"`          |
| `["a", "ab", "abc"]` | `{ |string| string.empty? }`  | `nil `          |
| `[1, 2, 3]`          | `{ |number| number > 1 }`     | `2`             |
| `[1, 2, 3]`          | `{ |number| number.zero? }`   | `nil`           |

*Table 1*.  Test expectations for `#my_find`.

Tests for the behavior of the `#my_find` method have been written to mimic the behavior of Ruby's [`Enumerable#find`](http://ruby-doc.org/core-2.0.0/Enumerable.html#method-i-find).  An overview of the expectations is represented in Table 1.  

To run the tests for just the `#my_find` method, on the command line navigate to the `/source` directory and then run:

```
rspec --tag release:0
```


### Release 1: Write the `#my_map` method

| my_array             | block                          | expected result   |
| :------------------- | :----------------------------- | :---------------- |
| `["a", "ab", "abc"]` | `{ |string| string[0] }`       | `["a", "a", "a"]` |
| `[1, 2, 3]`          | `{ |number| number - number }` | `[0, 0, 0]`       |

*Table 2*.  Test expectations for `#my_map`.

Tests for the behavior of the `#my_map` method have been written to mimic the behavior of Ruby's [`Enumerable#map`](http://ruby-doc.org/core-2.0.0/Enumerable.html#method-i-map).  An overview of the expectations is represented in Table 2.  

To run the tests for just the `#my_map` method, on the command line navigate to the `/source` directory and then run:

```
rspec --tag release:1
```

### Release 2: Write the `#my_reject` method

| my_array             | block                            | expected result |
| :------------------- | :------------------------------- | :-------------- |
| `["a", "ab", "abc"]` | `{ |string| string.length < 3 }` | `["abc"]`       |
| `[1, 2, 3]`          | `{ |number| number < 3 }`        | `[3]`           |

*Table 3*.  Test expectations for `#my_reject`.

Tests for the behavior of the `#my_reject` method have been written to mimic the behavior of Ruby's [`Enumerable#reject`](http://ruby-doc.org/core-2.0.0/Enumerable.html#method-i-reject).  An overview of the expectations is represented in Table 3.  

To run the tests for just the `#my_reject` method, on the command line navigate to the `/source` directory and then run:

```
rspec --tag release:2
```


### Release 3: Write the `#my_select` method

| my_array             | block                            | expected result |
| :------------------- | :------------------------------- | :-------------- |
| `["a", "ab", "abc"]` | `{ |string| string.length < 3 }` | `["a", "ab"]`   |
| `[1, 2, 3]`          | `{ |number| number < 3 }`        | `[1, 2]`        |

*Table 4*.  Test expectations for `#my_select`.

Tests for the behavior of the `#my_select` method have been written to mimic the behavior of Ruby's [`Enumerable#select`](http://ruby-doc.org/core-2.0.0/Enumerable.html#method-i-select).  An overview of the expectations is represented in Table 4.  

To run the tests for just the `#my_select` method, on the command line navigate to the `/source` directory and then run:

```
rspec --tag release:3
```


### Release 4 (*optional*): Write the `#my_all?` method
If choosing to write the `#my_all?` method, we'll need to make a change to the file `spec/support/my_enumerable_behaviors.rb`.  Reading through the tests, after the description of the behaviors of `#my_find`, `#my_map`, `#my_reject`, and `#my_select` we'll see an example group for `#my_all?`.  Only, instead of being organized by the `describe` method, it's organized by `pending`.  Switch `pending` to `describe` and we'll be ready to begin.

| my_array             | block                            | expected result |
| :------------------- | :------------------------------- | :-------------- |
| `["a", "ab", "abc"]` | `{ |string| string.length < 10 }`| `true`          |
| `["a", "ab", "abc"]` | `{ |string| string.length < 3 }` | `false`         |
| `["a", "ab", "abc"]` | `{ |string| "a truthy value" }`  | `true`          |
| `["a", "ab", "abc"]` | `{ |string| nil }`               | `false`         |
| `[1, 2, 3]`          | `{ |number| number < 10 }`       | `true`          |
| `[1, 2, 3]`          | `{ |number| number < 3 }`        | `false`         |
| `[1, 2, 3]`          | `{ |string| "a truthy value" }`  | `true`          |
| `[1, 2, 3]`          | `{ |string| nil }`               | `false`         |

*Table 5*.  Test expectations for `#my_all?`.

Tests for the behavior of the `#my_all?` method have been written to mimic the behavior of Ruby's [`Enumerable#all?`](http://ruby-doc.org/core-2.0.0/Enumerable.html#method-i-all-3F).  An overview of the expectations is represented in Table 5.

To run the tests for just the `#my_all?` method, on the command line navigate to the `/source` directory and then run:

```
rspec --tag release:4
```


### Release 5 (*optional*): Write the `#my_reduce?` method

Writing `#my_reduce` should be a fairly significant step up in difficulty from writing the other enumerable methods, and any attempts should be time-boxed.  We'll definitely want to understand how Ruby's [`Enumerable#reduce`](http://ruby-doc.org/core-2.0.0/Enumerable.html#method-i-reduce) method works, so we know what we're getting into.  

For starters, we'll want to be able to call the method passing arguments and a block in four different ways:

- with just a block
- with just the name of a method, represented as a symbol
- with a starting value and a block
- with a starting value and the name of a method


If choosing to write the `#my_reduce?` method, we'll need to make a change to the file `spec/support/my_enumerable_behaviors.rb`. The examples for `#my_reduce` are organized by by the `pending` method.  Switch `pending` to `describe` and we'll be ready to begin.

| my_array             | arguments   | block                        | expected result |
| :------------------- | :---------- | :--------------------------- | :-------------- |
| `["a", "ab", "abc"]` |             | `{ |memo, str| memo + str }` | `"aababc"`      |
| `["a", "ab", "abc"]` | `:+`        |                              | `"aababc"`      |
| `["a", "ab", "abc"]` | `"ZZZ"`     | `{ |memo, str| memo + str }` | `"ZZZaababc"`   |
| `["a", "ab", "abc"]` | `"ZZZ", :+` |                              | `"ZZZaababc"`   |
| `[1, 2, 3]`          |             | `{ |memo, num| memo * num }` | `6`             |
| `[1, 2, 3]`          | `:*`        |                              | `6`             |
| `[1, 2, 3]`          | `100`       | `{ |memo, num| memo * num }` | `600`           |
| `[1, 2, 3]`          | `100, :*`   |                              | `600`           |

*Table 6*.  Test expectations for `#my_reduce`.

Tests for the behavior of the `#my_reduce` method have been written to mimic the behavior of Ruby's [`Enumerable#reduce`](http://ruby-doc.org/core-2.0.0/Enumerable.html#method-i-reduce).  An overview of the expectations is represented in Table 6.

To run the tests for just the `#my_reduce` method, on the command line navigate to the `/source` directory and then run:

```
rspec --tag release:5
```


##Conclusion
We've worked through writing homemade versions of just a sample of Ruby's enumerable methods, and we should understand what each of them do.  These particular methods happen to be some that we'll commonly see and use, so we want to be very familiar with them.  After completing this challenge, we should, in particular, definitely know what the `#find`, `#select`, and `#map` methods do.  These are methods we'll use very regularly, and we need to know them inside and out.  Before moving on to the next challenge, make sure we understand the methods covered in this challenge.