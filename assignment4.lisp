; Assignment 1
(defun sort-asc-length-sublists (list) (sort list '< :key 'length))
(defun sort-desc-length-sublists (list) (sort list
                                            (lambda (a b) (> (length a) (length b)))))
(defun sort-lexicographic (list) (sort list
                                     (lambda (a b) (string< a b))))
(defun sort-asc-abs (list) "Something something test comment" (sort list
                                                                  (lambda (a b) (< (abs a) (abs b)))))
(defun sort-desc-inverse (list) (sort list
                                    (lambda (a b) (> (/ 1/1 a) (/ 1/1 b)))))

; Helper functions for 2.6
(defun filter (f filter-list)
  (if (null filter-list)
      '()
      (append
        (if (funcall f (car filter-list)) (list (car filter-list)) '())
        (filter f (cdr filter-list)))))
(defun is-divisible-by (a b) (equal 0 (rem a b)))
(defun factorial (n)
  "Computes the factorial n! of an integer number n"
  (cond ((<= n 1) 1)
        (t (* n (factorial (- n 1))))))

; Assignment 2.1 to 2.5
(defun find-nonempty-list (list) (find '() list :key 'null))
(defun find-list-longer-than-3 (list) (find t list :key (lambda (element) (<= 3 (length element)))))
(defun find-list-longer-than-n (list n) (find t list :key (lambda (element) (<= n (length element)))))
(defun find-list-with-even-number-of-elements (list) (find t list :key (lambda (element) (is-divisible-by (length element) 2))))
(defun find-divisible-member (list n) (find t list :key (lambda (element) (is-divisible-by element n))))

; Assignment 2.6
(defun filter-even (list) (filter (lambda (x) (= 0 (mod x 2))) list))
(defun filter-greater (list min) (filter (lambda (x) (< min x)) list))
(defun filter-divisors (list divider) (filter (lambda (x) (is-divisible-by x divider)) list))
(defun collect-factorials (list) (mapcar 'factorial list))
(defun multiply-all (list factor) (mapcar (lambda (x) (* x factor)) list))
(defun sum-of-squares (list) (reduce (lambda (accumulator value) (+ accumulator value)) (mapcar (lambda (x) (* x x)) list) :initial-value 0))

(defun multimap (function list count) (if (>= 0 count)
                                          list
                                          (mapcar function (multimap function list (- count 1)))))

(defun call-multiply (fn thing count) (if (>= 0 count)
                                          thing
                                          (call-multiply fn (funcall fn thing) (- count 1))))

(defun call-all (functions accumulator) (if functions
                                            (call-all (cdr functions) (funcall (car functions) accumulator))
                                            accumulator))


; (defun make-list-with-elements (value count) (multimap (lambda (x) (cons value x)) '() count))
(defun make-list-with-elements (value count) (call-multiply (lambda (x) (cons value x)) '() count))
(defun nth-element (index list) (car (call-multiply #'rest list (- index 1))))


(defun assert-true (name test) (if (not test) (error (format T "Test ~s failed" name))))
(defun assert-false (name test) (if test (error (format T "Test ~s failed" name))))
(defun assert-equal (name a b) (if (not (equal a b)) (error (format T "Test ~s failed: ~s is not equal to ~s" name a b))))

; Assignment 1
(defun sort-test () (progn
                     (assert-equal "Test A" '(() () (1 2) (1 2 3)) (sort-asc-length-sublists (list '() '(1 2 3) '() '(1 2))))
                     (assert-equal "Test B" '((1 2 3) (1 2) () ()) (sort-desc-length-sublists (list '() '(1 2 3) '() '(1 2))))
                     (assert-equal "Test C" '("Mary" "Paul" "Peter") (sort-lexicographic (list "Peter" "Paul" "Mary")))
                     (assert-equal "Test D" '(0 -1 3 4 5 -6) (sort-asc-abs (list -6 -1 0 3 4 5)))
                     (assert-equal "Test E" '(0.1 2 6 -5 -0.25) (sort-desc-inverse (list -5 -0.25 0.1 2 6)))))

; Assignment 2.1 to 2.5
(defun functional-test-a () (progn
                             (assert-equal "Test A" '(a b) (find-nonempty-list '(() () (a b))))
                             (assert-equal "Test B" '(this is boring) (find-list-longer-than-3 '(() () (a b) (this is boring))))
                             (assert-equal "Test C" '(I have to) (find-list-longer-than-n '(() (why) (tf do) (I have to) (define testcases myself ?)) 3))
                             (assert-equal "Test D" '() (find-list-with-even-number-of-elements '(())))
                             (assert-equal "Test E" '(d e f g) (find-list-with-even-number-of-elements '((a) (d e f g))))
                             (assert-equal "Test F" 6 (find-divisible-member '(1 6 3 4) 2))))

; Assignment 2.6
(defun functional-test () (progn
                           (assert-equal "Test A" '(-2 0 2 4) (filter-even '(-2 -1 0 1 2 3 4 5)))
                           (assert-equal "Test B" '(3 4 5) (filter-greater '(-2 -1 0 1 2 3 4 5) 2))
                           (assert-equal "Test C" '(-2 0 2 4) (filter-divisors '(-2 -1 0 1 2 3 4 5) 2))
                           (assert-equal "Test D" '(1 2 6 24) (collect-factorials '(1 2 3 4)))
                           (assert-equal "Test E" '(-4 -2 0 2 4 6 8 10) (multiply-all '(-2 -1 0 1 2 3 4 5) 2))
                           (assert-equal "Test F" 60 (sum-of-squares '(-2 -1 0 1 2 3 4 5)))))

; Assignment 3 - misread
(defun multimap-test () (progn
                         (assert-equal "Test A" '(1 2 3 4) (multimap (lambda (x) (+ x 1)) '(1 2 3 4) 0))
                         (assert-equal "Test B" '(2 3 4 5) (multimap (lambda (x) (+ x 1)) '(1 2 3 4) 1))
                         (assert-equal "Test B" '(6 7 8 9) (multimap (lambda (x) (+ x 1)) '(1 2 3 4) 5))
                         (assert-equal "Test C" '(1 16 81 256) (multimap (lambda (x) (* x x)) '(1 2 3 4) 2))))

; Assignment 3
(defun call-multiply-usage-test () (progn
                                    (assert-equal "Test A" '() (make-list-with-elements 'blah 0))
                                    (assert-equal "Test B" '(blah) (make-list-with-elements 'blah 1))
                                    (assert-equal "Test C" '(blah blah blah blah blah) (make-list-with-elements 'blah 5))
                                    (assert-equal "Test D" 'd (nth-element 4 '(a b c d e f)))))

; Assignment 3
(defun call-multiply-extra-test () (progn
                                    (assert-equal "Test A" 6 (call-multiply (lambda (x) (+ x 1)) 1 5))
                                    (assert-equal "Test B" 32 (call-multiply (lambda (x) (+ x x)) 1 5))
                                    (assert-equal "Test C" 1 (call-multiply (lambda (x) (* x x)) 1 5))
                                    (assert-equal "Test C" 4294967296 (call-multiply (lambda (x) (* x x)) 2 5))
                                    (assert-equal "Test D" 1 (call-multiply (lambda (x) (expt x x)) 1 5))
                                    (assert-equal "Test E" 1 (call-multiply (lambda (x) (/ 1 x)) 1 5))))

(defun add-one (x) (+ x 1))
(defun add-two (x) (+ x 2))
(defun sub-one (x) (- x 1))


(defun call-all-test () (progn
                         (assert-equal "Test A" 0 (call-all '() 0))
                         (assert-equal "Test B" 2 (call-all (list #'add-one #'sub-one #'add-two) 0))
                         ;
                         ))

(sort-test)
(functional-test-a)
(functional-test)
(multimap-test)
(call-multiply-usage-test)
(call-multiply-extra-test)
(call-all-test)

; (reduce ())

; 1. Add initial value to in front of the list
; 2. If that list is empty call the function without parameters
; 3. If that list is one element long, dont call the function
; 4. Else call the function with the first two elements 

; if the list is empty call the function 