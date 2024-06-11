(in-package :eichhorn)
  
(def-function factorial (n)
  "Computes the factorial n! of an integer number n"
  (cond ((<= n 1) 1)
        (else (* n (factorial (- n 1))))))

(def-function triangular (n)
  "Computes the triangular number of an integer number n"
  (cond ((<= n 1) 1)
        (else (+ n (triangular (- n 1))))))

(def-function fibonacci (n)
  "Computes the fibonacci number of an integer number n"
  (cond ((= n 0) 0) ((= n 1) 1)
        (else (+ (fibonacci (- n 1)) (fibonacci (- n 2))))))

; Ported from: https://rosettacode.org/wiki/Ackermann_function#Rust
; TODO: Understand what the ackermann function actually does
(def-function ackermann (m n)
  "Ackermann function"
  (cond
   ((= m 0) (+ n 1))
   ((= n 0) (ackermann (- m 1) 1))
   (else (ackermann (- m 1) (ackermann m (- n 1))))
   )
  )