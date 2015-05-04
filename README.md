# Implementing Enumerable Methods

## Summary
In this challenge, we're going to recreate the functionality in some of Ruby's most commonly used enumerable methods.  While going forward, we'll be using Ruby's built-in enumerable methods, creating these methods ourselves will help us to understand what's going on behind the scenes.

Ruby provides a module, `Enumerable`, that provides methods for working with collections (e.g., arrays and hashes).  We might see this module referred to as the *Enumerable mixin* because the module is *mixed into* the `Array` and `Hash` classes.  By saying that the module is mixed into these classes, we just mean that each class includes the module.  

If we're not familiar with this module already, we'll want to be; it provides ready-made solutions to a lot of common tasks when working with collections.  

By familiarizing ourselves with and utilizing the methods provided in the `Enumerable` module, we are able to write more succinct, more idiomatic Ruby.  Consider [`Enumerable#max`](http://ruby-doc.org/core-2.0.0/Enumerable.html#method-i-max).  We can use this method when we want to determine the maximum value in a collection.  For example, given a collection of numbers, we might want to know which number is the largest.

Using `Enumerable#max?`, we could write ...

```ruby
largest_number = [99, 45, 98, 34, 17].max
```

Without it, we might end up writing something like ...

```ruby
largest_number = 0

[99, 45, 98, 34, 17].each do |number|
  largest_number = number if number > largest_number
end
```

## Blocks




## Relying on `#each`


The [Ruby docs](http://ruby-doc.org/core-2.1.0/Enumerable.html), provide the following description of the module:

> The Enumerable mixin provides collection classes with several traversal and searching methods, and with the ability to sort. The class must provide a method each, which yields successive members of the collection.




As the documentation above states, to get access to everything Enumerable can offer in your own classes you only need to implement `#each`. This is a hint that all the methods in Enumberable must ultimately rely on `#each`. In other words, methods in Enumerable are implemented _in terms_ of `#each`.

Your task is to implement `#my_select`, `#my_reject`, `#my_find`, `#my_map` and (optionally) `#my_reduce`.

You may use any method that begins with `my_`. `#my_each` is already implemented for you (you'll need it), but you'll need to write the others. Some of these methods can be implemented in terms of _each other_. For example, `#my_select` and `#my_find` do similar things, can you leverage that fact?

`my_enumerated_code_spec.rb` contains tests for all the methods you'll be implementing. Focus on making one test pass at a time. Note that the Enumerable methods themselves are banned, that would be too easy!

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
