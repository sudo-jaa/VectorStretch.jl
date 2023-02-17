# VectorStretch.jl
A simple library for stretching vectors of numbers, and comparing the shape similarity of vectors of arbitrary lengths.

## What's included?
A few new functions are introduced: 
- `interpolate()` has several methods that allow you to interpolate between various `<:Number`s. This includes Vector interpolation that allows you to find the value at non-integer indicies.
- `vector_expand()` allows you to create a new Vector that is "stretched" to a specified length, maintaining the shape and proportions of the original vector. 
- `similarity()` allows you to determine the cosine similarity of two Vectors of arbitrary length. The shortest vector passed in will get stretched to the length of the second, and then the comparison will be run.


### To Do
- [ ] Add unit tests!
- [x] Allow vector iterpolation by adding a method to `indexat`
- [ ] More approaches to vector similarity
- [ ] Make it easier to pass in easing functions to vector interpolation
- [ ] Make it possible to normalise values in these arrays before running a similarity comparison for pure shape differences
