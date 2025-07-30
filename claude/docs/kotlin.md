# kotlin.MD

## Basic Principles

* Prefer idomatic Kotlin (don't write Kotlin code as if you were a Java developer)

* Avoid unnecessary vals/vars by using apply{} or also{} type constructs

* Parameterize tests where possible/practical

## Variables

* Don't use a var when a val will do (prefer immutability)

* Names of constants (properties marked with const, or top-level or object val properties with no custom get function that hold deeply immutable data) should use all uppercase, underscore-separated names following the screaming snake case convention