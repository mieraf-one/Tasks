# Get Variables

Extract variables from an indexed pattern and return only the variable list.

This utility accepts a pattern with an ID and supports nested and n-ary patterns.

## Examples

```lisp
(INDEXED-PATTERN p1 (Inheritance (var 0) (var 1)))
;; => (GET-VAR p1 ((var 0) (var 1)))

(INDEXED-PATTERN p2 (Know (var 0) (Inheritance (var 1) (var 2))))
;; => (GET-VAR p2 ((var 0) (var 1) (var 2)))
```