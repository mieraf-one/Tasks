(DEF get-constant
    (, (GET-IS-EXP $id $ph 0)
        (GET-IS-VAR $id $ph 0)
        (GET-HEAD $id $ph)
        (GET-TAIL $id $pt)
        (GET-WALK $id $idx-ptrn $collector $stack)
        (DEF take-first $take-first-p $tf-t)
    )
    (O
        (- (GET-WALK $id $idx-ptrn $collector
                $stack))

        (+ (GET-WALK $id $pt $collector $stack))

        (- (GET-IS-EXP $id $ph 0))
        (- (GET-IS-VAR $id $ph 0))
        (- (GET-HEAD $id $ph))
        (- (GET-TAIL $id $pt))

        (+ (exec (0 0) $take-first-p $tf-t))
    )
)


(DEF get-nested
    (, (GET-IS-EXP $id $ph 1)
        (GET-IS-VAR $id $ph 0)
        (GET-HEAD $id $ph)
        (GET-TAIL $id $pt)
        (GET-WALK $id $idx-ptrn $collector $stack)
        (DEF take-first $take-first-p $tf-t)
    )
    (O
        (- (GET-WALK $id $idx-ptrn $collector
                $stack))

        (+ (GET-WALK $id $ph ()
                (($collector $pt) $stack)))

        (- (GET-IS-EXP $id $ph 1))
        (- (GET-IS-VAR $id $ph 0))
        (- (GET-HEAD $id $ph))
        (- (GET-TAIL $id $pt))

        (+ (exec (0 0) $take-first-p $tf-t))
    )
)


(DEF get-var
    (, (GET-IS-EXP $id $ph 0)
        (GET-IS-VAR $id $ph 1)
        (GET-HEAD $id $ph)
        (GET-TAIL $id $pt)
        (GET-WALK $id $idx-ptrn $collector $stack)
        (DEF take-first $take-first-p $tf-t)
    )
    (O
        (- (GET-WALK $id $idx-ptrn $collector
                $stack))
        (pure (GET-WALK $id $pt $new-collector $stack) $new-collector
            (cons ('($ph $collector)))
        )

        (- (GET-IS-EXP $id $ph 0))
        (- (GET-IS-VAR $id $ph 1))
        (- (GET-HEAD $id $ph))
        (- (GET-TAIL $id $pt))

        (+ (exec (0 0) $take-first-p $tf-t))
    )
)


(DEF check-var
    (, (GET-HEAD $id $ph)
        (GET-TAIL $id $pt)
        (DEF get-var $get-var-p $gv-t)
        (DEF get-nested $get-nested-p $gn-t)
        (DEF get-constant $get-constant-p $gc-t)

    )
    (O
        (pure (GET-IS-VAR $id $ph $is-var) $is-var
            (i8_to_string (is_var (' $ph)))
        )

        (pure (GET-IS-EXP $id $ph $is-exp) $is-exp
            (i8_to_string (is_exp (' $ph)))
        )

        (+ (exec (0 2) $get-var-p $gv-t))
        (+ (exec (0 2) $get-nested-p $gn-t))
        (+ (exec (0 2) $get-constant-p $gc-t))
    )
)

(DEF take-first
    (, (GET-WALK $id () $collector (($old-collector $old-tail) $old-stack))
        (DEF take-first $take-first-p $tf-t)
    )
    (O
        (- (GET-WALK $id () $collector (($old-collector $old-tail) $old-stack)))

        (pure (GET-WALK $id $old-tail $new-collector $old-stack) $new-collector
            (append ('($collector $old-collector)))
        )

        (+ (exec (0 0) $take-first-p $tf-t))
    )

)


(DEF take-first
    (, (GET-WALK $id () $collector ())
    )
    (O
        (- (GET-WALK $id () $collector ()))
        (pure (GET-VARS $id $vars) $vars
            (reverse (' $collector))
        )
    )

)


(DEF take-first
    (, (GET-WALK $id $idx-ptrn $collector $stack)
        (DEF check-var $check-var-p $cv-t)
    )
    (O
        (pure (GET-HEAD $id $ph) $ph
            (car-atom (' $idx-ptrn))
        )

        (pure (GET-TAIL $id $pt) $pt
            (cdr-atom (' $idx-ptrn))
        )

        (+ (exec (0 1) $check-var-p $cv-t))
    )

)


(DEF get-vars
    (, (INDEXED-PATTERN $id $idx-ptrn)
        (DEF take-first $take-first-p $tf-t)
    )
    (O
        (+ (GET-WALK $id $idx-ptrn ()
                ()))

        (- (INDEXED-PATTERN $id $idx-ptrn))
        (+ (exec (0 0) $take-first-p $tf-t))
    )
)


(exec (0 0)
    (, (DEF get-vars $get-vars-p $gv-t))
    (O
        (+ (exec (0 0) $get-vars-p $gv-t))
    )
)
