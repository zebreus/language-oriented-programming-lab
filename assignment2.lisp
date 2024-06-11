(defun has-list (input-list) (and
                              input-list
                              (or
                               (listp (first input-list))
                               (has-list (rest input-list)))))

(defun flatten (nested-list) (if
                              (listp nested-list) (mapcan 'flatten nested-list)
                              (list nested-list)))

(defun flatten-b (nested-list) (cond
                                ((not nested-list) '())
                                ((not (listp nested-list)) (list nested-list))
                                ; ((not (has-list nested-list)) nested-list)
                                (t (append (flatten-b (first nested-list)) (flatten-b (rest nested-list))))))

(defun increment-second-if-key-matches (pair key) (list (first pair) (if (equal (first pair) key) (+ (second pair) 1) (second pair))))

(defun increment-or-add-key-in-list (list key) (if (assoc key list)
                                                   (mapcar #'(lambda (x) (increment-second-if-key-matches x key)) list)
                                                   (append (list (list key 1)) list)))

(defun occurrences (flat-list) (reverse (reduce #'increment-or-add-key-in-list flat-list :initial-value '())))

(defun intersperse (seperator list) (if (not list) '() (append (list (car list)) (mapcan #'(lambda (x) (list seperator x)) (rest list)))))

(defun has-number (list) (some 'numberp (flatten list)))

(defun update-minimum-or-maximum (accumulator value) (let
                                                         ((min (first accumulator)) (max (second accumulator)))
                                                       (list (if (< value min) value min) (if (> value max) value max))))

(defun min-max (list-of-numbers) (if (not list-of-numbers) '() (reduce #'update-minimum-or-maximum list-of-numbers :initial-value (list (first list-of-numbers) (first list-of-numbers)))))

(defun min-max-lib (list-of-numbers) (if (not list-of-numbers) '() (list (apply #'min list-of-numbers) (apply #'max list-of-numbers))))

(defun update-minimum-or-maximum-or-default (min-max value) (if min-max (update-minimum-or-maximum min-max value) (list value value)))
(defun min-max-rec (list-of-numbers) (if (not list-of-numbers) '() (let ((rest-min-max (min-max-rec (rest list-of-numbers))))
                                                                     (update-minimum-or-maximum-or-default rest-min-max (first list-of-numbers)))))

(defun assert-true (name test) (if (not test) (error (format T "Test ~s failed" name))))
(defun assert-false (name test) (if test (error (format T "Test ~s failed" name))))
(defun assert-equal (name a b) (if (not (equal a b)) (error (format T "Test ~s failed: ~s is not equal to ~s" name a b))))

(defun has-list-test ()
  (progn (assert-false "A" (has-list '(a b c)))
         (assert-true "B" (has-list '((a) b)))
         (assert-true "C" (has-list '(a b (c))))
         (assert-false "D" (has-list '()))
         (assert-true "E" (has-list '(a () c)))
         (assert-true "F" (has-list '(() a)))
         (assert-true "G" (has-list '(())))
         'has-list-tests-passed))

(defun flatten-test ()
  (progn (assert-equal "flatten seems to work" '(a b c d e f) (flatten '(((a) b) c (d e) (((f)))))) 'flatten-tests-passed))

(defun occurrences-test () (progn
                            (assert-equal "Test A" '((a 4) (b 1) (d 2) (c 3)) (occurrences '(a b a d a c d c a c)))
                            (assert-equal "Test B" '((nil 3) (a 1) (b 2)) (occurrences '(nil a b nil b nil)))
                            (assert-equal "Test C" 'nil (occurrences 'nil))))

(defun intersperse-test () (progn
                            (assert-equal "A" '(a - b - c - d) (intersperse '- '(a b c d)))
                            (assert-equal "B" '(a - b) (intersperse '- '(a b)))
                            (assert-equal "C" '(a) (intersperse '- '(a)))
                            (assert-equal "D" 'nil (intersperse '- 'nil))
                            (assert-equal "E" '(nil - b - c) (intersperse '- '(nil b c)))
                            (assert-equal "F" '(a - nil - c) (intersperse '- '(a nil c)))
                            (assert-equal "G" '(nil) (intersperse '- '(nil)))
                            (assert-equal "H" '(a - a - b) (intersperse '- '(a a b)))))

(defun has-number-test () (progn
                           (assert-false "A" (has-number 'nil))
                           (assert-true "B" (has-number '(1)))
                           (assert-false "C" (has-number '(a)))
                           (assert-true "D" (has-number '(a (1))))
                           (assert-false "E" (has-number '(a (a))))
                           (assert-true "F" (has-number '((a 1) c d)))
                           'has-number-tests-passed))

(defun min-max-test () (progn
                        (assert-equal "A" '(1 4) (min-max (list 1 2 3 4)))
                        (assert-equal "B" '(1 10) (min-max (list 3 1 8 2 10)))
                        (assert-equal "C" '(10 10) (min-max (list 10)))
                        (assert-equal "D" '(-8 -5) (min-max (list -5 -8)))
                        (assert-equal "E" nil (min-max nil))))

(has-list-test)
(flatten-test)
(occurrences-test)
(intersperse-test)
(has-number-test)
(min-max-test)
