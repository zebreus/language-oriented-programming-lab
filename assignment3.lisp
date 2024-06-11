(defun element-at (input-list index)
  (if (<= index 1) (car input-list)
      (element-at (rest input-list) (- index 1))))

(defun reverse-list (input-list)
  (if (null input-list) '()
      (append (reverse-list (rest input-list)) (list (car input-list)))))

(defun palindromep (input-list)
  (equal input-list (reverse-list input-list)))

(defun repeat (element count) (cond
                               ((<= count 0) '())
                               (t (append (list element) (repeat element (- count 1))))))

(defun replicator (input-list count)
  (if (null input-list) '()
      (append (repeat (car input-list) count) (replicator (rest input-list) count))))

(defun is-divisible-by (a b) (equal 0 (rem a b)))

(defun bruteforce-prime (maybe-prime current-divider) (cond
                                                       ((<= current-divider 1) t)
                                                       ((is-divisible-by maybe-prime current-divider) '())
                                                       (t (bruteforce-prime maybe-prime (- current-divider 1)))))

(defun is-prime (maybe-prime) (cond
                               ((<= maybe-prime 1) '())
                               (t (bruteforce-prime maybe-prime (- maybe-prime 1)))))

(defun my-gcd (a b) (cond
                     ((= a b) a)
                     ((< a b) (my-gcd a (- b a)))
                     ((> a b) (my-gcd b (- a b)))))

(defun next-divider (tested-number current-divider) (cond
                                                     ((is-divisible-by tested-number current-divider) current-divider)
                                                     (t (next-divider tested-number (+ current-divider 1)))))

(defun prime-factors (a &optional (current-divider 2)) (cond
                                                        ((is-prime a) (list a))
                                                        (t (let ((b (next-divider a current-divider)))
                                                             (if (= a b)
                                                                 '()
                                                                 (cons b (prime-factors (/ a b) b)))))))

(defun assert-true (name test) (if (not test) (error (format T "Test ~s failed" name))))
(defun assert-false (name test) (if test (error (format T "Test ~s failed" name))))
(defun assert-equal (name a b) (if (not (equal a b)) (error (format T "Test ~s failed: ~s is not equal to ~s" name a b))))

(defun element-at-test () (progn
                           (assert-equal "Test A" 'a (element-at '(a b a d) 1))
                           (assert-equal "Test B" 'c (element-at '(a b c d) 3))
                           (assert-equal "Test C" '() (element-at '() 3))))

(defun reverse-list-test () (progn
                             (assert-equal "Test A" '(a c a b) (reverse-list '(b a c a)))
                             (assert-equal "Test B" '() (reverse-list '()))
                             (assert-equal "Test C" '(a) (reverse-list '(a)))))

(defun palindromep-test () (progn
                            (assert-equal "Test A" '() (palindromep '(b a c a)))
                            (assert-equal "Test B" '() (palindromep '(b a)))
                            (assert-equal "Test C" 't (palindromep '(a c a)))
                            (assert-equal "Test D" 't (palindromep '()))
                            (assert-equal "Test E" 't (palindromep '(a)))))

(defun replicator-test () (progn
                           (assert-equal "Test A" '() (replicator '(a c d) 0))
                           (assert-equal "Test B" '(a c d) (replicator '(a c d) 1))
                           (assert-equal "Test C" '(a a c c d d) (replicator '(a c d) 2))
                           (assert-equal "Test D" '(a a a c c c d d d) (replicator '(a c d) 3))))

(defun is-prime-test () (progn
                         (assert-equal "Test 1" '() (is-prime 1))
                         (assert-equal "Test 2" t (is-prime 2))
                         (assert-equal "Test 3" t (is-prime 3))
                         (assert-equal "Test 4" '() (is-prime 4))
                         (assert-equal "Test 5" t (is-prime 5))
                         (assert-equal "Test 6" '() (is-prime 6))
                         (assert-equal "Test 7" t (is-prime 7))
                         (assert-equal "Test 8" '() (is-prime 8))
                         (assert-equal "Test 9" '() (is-prime 9))
                         (assert-equal "Test 10" '() (is-prime 10))
                         (assert-equal "Test 11" t (is-prime 11))))

(defun my-gcd-test () (progn
                       (assert-equal "Test 1" 1 (my-gcd 1 1))
                       (assert-equal "Test 2" 1 (my-gcd 1 2))
                       (assert-equal "Test 3" 1 (my-gcd 1 3))
                       (assert-equal "Test 4" 1 (my-gcd 1 4))
                       (assert-equal "Test 5" 1 (my-gcd 1 5))
                       (assert-equal "Test 6" 1 (my-gcd 1 6))
                       (assert-equal "Test 7" 1 (my-gcd 1 7))
                       (assert-equal "Test 8" 1 (my-gcd 1 8))
                       (assert-equal "Test 9" 1 (my-gcd 1 9))
                       (assert-equal "Test 10" 1 (my-gcd 1 10))
                       (assert-equal "Test 11" 1 (my-gcd 1 11))
                       (assert-equal "Test 12" 21 (my-gcd 252 105))))

(defun prime-factors-test () (progn
                              (assert-equal "Test 1" '(2) (prime-factors 2))
                              (assert-equal "Test 2" '(2 2) (prime-factors 4))
                              (assert-equal "Test 3" '(2 3) (prime-factors 6))
                              (assert-equal "Test 4" '(3 3 5 7) (prime-factors 315))))


(element-at-test)
(reverse-list-test)
(palindromep-test)
(replicator-test)
(is-prime-test)
(my-gcd-test)
(prime-factors-test)
