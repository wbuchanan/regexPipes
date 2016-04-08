# Pipe friendly grep wrappers
Got tired with writing the same functions repeatedly to allow `grep` functions
to be called with pipe operators, so I wrapped them all and put the data object
parameters in the first position of the argument list.


```R

