# Implementing Enumerable Methods

## Summary
In this challenge, we're going to recreate the functionality in some of Ruby's most commonly used enumerable methods.  Where Ruby provides a`Enumerable#select` method, we're going to write a `MyEnumerable#my_select` method.

Going forward through DBC we'll be using Ruby's built-in enumerable methods, but creating these methods ourselves will help us to understand what's going on behind the scenes.  It will also give us practice writing methods that accept and yield to blocks.

This challenge assumes that we're at least somewhat familiar with Ruby's `Enumerable` module.  We won't be using it directly, but we should conceptually understand what it is and some of the behaviors that it provides for working with collections (e.g., arrays and hashes).  Some of the more critical points are detailed in the sections that follow.

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

* [Blocks and Yield in Ruby](http://stackoverflow.com/questions/3066703/blocks-and-yields-in-ruby)
* [The Building Blocks of Ruby](http://yehudakatz.com/2010/02/07/the-building-blocks-of-ruby/)


### Enumerable Relies on `#each`

The [Ruby docs](http://ruby-doc.org/core-2.1.0/Enumerable.html), provide the following description of the `Enumerable` module:

> The Enumerable mixin provides collection classes with several traversal and searching methods, and with the ability to sort. The class must provide a method each, which yields successive members of the collection.

Remember that the `Enumberable` module will often be referred to as a mixin.  It is designed to be be included in classes.  Ruby includes `Enumerable` in the `Array` and `Hash` classes.  We can include it in the classes that we write.  

To get access to everything Enumerable can offer in our own classes, we only need to implement an `#each` method in the class. This is a hint that all the methods in `Enumberable` must ultimately rely on `#each`. In other words, methods in `Enumerable` are implemented *in terms* of `#each`.

### `MyArray` and `MyEnumerable`

We're going to be working with a custom class, `MyArray` (see file `source/my_array.rb`).  It acts just like a normal array, but it has some additional behaviors.  For starters, the `MyArray` class includes the `MyEnumerable` module wherein we'll be defining our versions of the enumerable methods.

`MyArray` also defines an instance method: `#my_each`.  Similarly to how Ruby's enumerable methods depend on objects responding to `#each`, our enumerable methods are going to rely on objects having a `#my_each` method.  

We'll be writing our own enumerable methods in the `MyEnumerable` module (see file `source/my_enumerable.rb`).  Empty method definitions have been provided for us.  We need to code the behavior for each method.

### Do Not Use Enumerable Methods

`my_enumerable_spec.rb` contains tests for all the methods we'll be implementing. Focus on making one test pass at a time. Note that in the tests, the Ruby `Enumerable` methods themselves are banned, that would be too easy!

In defining our methods, we may call any method that begins with `my_`.  `MyArray#my_each` is already implemented for us, and we'll need to make use of it in the methods we write.  Some of the methods can be implemented in terms of *each other*. For example, `#my_select` and `#my_find` do similar things, can we leverage that?

##Releases



- [`#all?`](http://ruby-doc.org/core-2.0.0/Enumerable.html#method-i-all-3F) *optional*
- [`#find`](http://ruby-doc.org/core-2.0.0/Enumerable.html#method-i-find)
- [`#map`](http://ruby-doc.org/core-2.0.0/Enumerable.html#method-i-map)
- [`#reduce`](http://ruby-doc.org/core-2.0.0/Enumerable.html#method-i-reduce) *optional*
- [`#reject`](http://ruby-doc.org/core-2.0.0/Enumerable.html#method-i-reject)
- [`#select`](http://ruby-doc.org/core-2.0.0/Enumerable.html#method-i-select)



###Release 0 : Implement basic enumerable methods

Implement `#my_select`, `#my_reject`, `#my_find`.

###Release 1: Implement map

Let's get a little more interesting, implement `#my_map`.

##Stretch: Implement reduce & all?

Optional. Make the `pending` tests for `#my_reduce` and `#my_all?` active in the spec and create methods that satisfy the expectation.

##Resources

* [Enumerable Module](http://ruby-doc.org/core-2.1.0/Enumerable.html)
* [Blocks and Yield in Ruby](http://stackoverflow.com/questions/3066703/blocks-and-yields-in-ruby)
* [The Building Blocks of Ruby](http://yehudakatz.com/2010/02/07/the-building-blocks-of-ruby/)
