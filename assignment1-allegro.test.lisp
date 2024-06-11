(in-package :eichhorn)

(def-test factorial-test
  (assert-equal 1 (factorial 1))
  (assert-equal 120 (factorial 5))
)

(def-test fibonacci-test
    (assert-equal 0 (fibonacci 0))
  (assert-equal 1 (fibonacci 1))
  (assert-equal 1 (fibonacci 2))
  (assert-equal 2 (fibonacci 3))
  (assert-equal 3 (fibonacci 4))
  (assert-equal 5 (fibonacci 5))
  (assert-equal 8 (fibonacci 6))
  )