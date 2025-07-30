# kotlin.MD

## Basic Principles

* Prefer idomatic Kotlin (don't write Kotlin code as if you were a Java developer)

* Prefer immutable data structures and functional programming patterns

* Avoid unnecessary vals/vars by using apply{} or also{} type constructs

* Don't forget to use with() to improve grouping of repeated access

* Parameterize tests where possible/practical

* Use infered typing where possible

## New Projects

* Setup ktlint!

## Exceptions

* require() throws IllegalArgumentException, so use it instead of manual checks that throw IllegalArgumentException

## Interfaces

* Don't forget the "fun" keyboard on interfaces with only one abstract member function

## Variables

* Don't use a var when a val will do (prefer immutability)

* Names of constants (properties marked with const, or top-level or object val properties with no custom get function that hold deeply immutable data) should use all uppercase, underscore-separated names following the screaming snake case convention

## InputOutput

* Don't forget to use useLines with stream readers (when it makes sense)

## Tests

* Use descriptive backtick method names in tests
