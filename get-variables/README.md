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

## Entry point

```lisp
(exec (0 0)
    (, (DEF get-vars $get-vars-p $gv-t))
    (O
        (+ (exec (0 0) $get-vars-p $gv-t))
    )
)
```

---

### to TEST

```bash
mork run get_variables.metta --aux-path test-get-var.metta
```

### to RUN
```bash
mork run get_variables.metta 
```