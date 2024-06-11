(in-package :eichhorn)

(def-test element-at-test (progn
                           (assert-equal 'a (element-at '(a b a d) 1))
                           (assert-equal 'c (element-at '(a b c d) 3))
                           (assert-equal '() (element-at '() 3))))

(def-test reverse-list-test (progn
                             (assert-equal '(a c a b) (reverse-list '(b a c a)))
                             (assert-equal '() (reverse-list '()))
                             (assert-equal '(a) (reverse-list '(a)))))

(def-test palindromep-test (progn
                            (assert-equal '() (palindromep '(b a c a)))
                            (assert-equal '() (palindromep '(b a)))
                            (assert-equal 't (palindromep '(a c a)))
                            (assert-equal 't (palindromep '()))
                            (assert-equal 't (palindromep '(a)))))

(def-test replicator-test (progn
                           (assert-equal '() (replicator '(a c d) 0))
                           (assert-equal '(a c d) (replicator '(a c d) 1))
                           (assert-equal '(a a c c d d) (replicator '(a c d) 2))
                           (assert-equal '(a a a c c c d d d) (replicator '(a c d) 3))))

(def-test is-prime-test (progn
                         (assert-equal '() (is-prime 1))
                         (assert-equal t (is-prime 2))
                         (assert-equal t (is-prime 3))
                         (assert-equal '() (is-prime 4))
                         (assert-equal t (is-prime 5))
                         (assert-equal '() (is-prime 6))
                         (assert-equal t (is-prime 7))
                         (assert-equal '() (is-prime 8))
                         (assert-equal '() (is-prime 9))
                         (assert-equal '() (is-prime 10))
                         (assert-equal t (is-prime 11))))

(def-test my-gcd-test (progn
                       (assert-equal 1 (my-gcd 1 1))
                       (assert-equal 1 (my-gcd 1 2))
                       (assert-equal 1 (my-gcd 1 3))
                       (assert-equal 1 (my-gcd 1 4))
                       (assert-equal 1 (my-gcd 1 5))
                       (assert-equal 1 (my-gcd 1 6))
                       (assert-equal 1 (my-gcd 1 7))
                       (assert-equal 1 (my-gcd 1 8))
                       (assert-equal 1 (my-gcd 1 9))
                       (assert-equal 1 (my-gcd 1 10))
                       (assert-equal 1 (my-gcd 1 11))
                       (assert-equal 21 (my-gcd 252 105))))

(def-test prime-factors-test (progn
                              (assert-equal '(2) (prime-factors-wrapper 2))
                              (assert-equal '(2 2) (prime-factors-wrapper 4))
                              (assert-equal '(2 3) (prime-factors-wrapper 6))
                              (assert-equal '(3 3 5 7) (prime-factors-wrapper 315))))
