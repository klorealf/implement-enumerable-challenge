# Implementing Enumerable

##Learning Competencies

* Write basic Enumerable methods by hand
* Use composition to create more complex behavior from simple sub-components
* Utilize blocks in Ruby methods

##Summary

> The Enumerable mixin provides collection classes with several traversal and searching methods, and with the ability to sort. The class must provide a method each, which yields successive members of the collection.
—[Ruby Enumerable](http://ruby-doc.org/core-2.1.0/Enumerable.html)

As the documentation above states, to get access to everything Enumerable can offer in your own classes you only need to implement `#each`. This is a hint that all the methods in Enumberable must ultimately rely on `#each`. In other words, methods in Enumerable are implemented _in terms_ of `#each`.

We're going to implement our own versions of some popular Enumerable methods. Doing this yourself will help you understand precisely what's going on behind the scenes.

Your task is to implement `#my_select`, `#my_reject`, `#my_find`, `#my_map` and (optionally) `#my_reduce`.

You may use any method that begins with `my_`. `#my_each` is already implemented for you (you'll need it), but you'll need to write the others. Some of these methods can be implemented in terms of _each other_. For example, `#my_select` and `#my_find` do similar things, can you leverage that fact?

`my_enumerated_code_spec.rb` contains tests for all the methods you'll be implementing. Focus on making one test pass at a time. Note that the Enumerable methods themselves are banned, that would be too easy!

##Releases

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
