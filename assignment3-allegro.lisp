(in-package :eichhorn)

; ([( \t])(defun |car |rest |null |append |cdr |cons |equal |format |error |progn |cond |if |let |list |rem )
; $1cl:$2


(def-function element-at (input-list index)
              (cl:if (<= index 1) (cl:car input-list)
                     (element-at (cl:rest input-list) (- index 1))))

(def-function reverse-list (input-list)
              (cl:if (cl:null input-list) '()
                     (cl:append (reverse-list (cl:rest input-list)) (cl:list (cl:car input-list)))))

(def-function palindromep (input-list)
              (if
               (cl:equal input-list (reverse-list input-list))
               t '()))

(def-function repeat (element count) (cond
                                      ((<= count 0) '())
                                      ((= count 1) (cl:list element))
                                      (t (cl:append (cl:list element) (repeat element (- count 1))))))

(def-function replicator (input-list count)
              (cl:if (cl:null input-list) '()
                     (cl:append (repeat (cl:car input-list) count) (replicator (cl:rest input-list) count))))

(def-function is-divisible-by (a b) (cl:equal 0 (cl:rem a b)))

(def-function bruteforce-prime (maybe-prime current-divider) (cond
                                                              ((<= current-divider 1) t)
                                                              ((is-divisible-by maybe-prime current-divider) '())
                                                              (t (bruteforce-prime maybe-prime (- current-divider 1)))))

(def-function is-prime (maybe-prime) (cond
                                      ((<= maybe-prime 1) '())
                                      (t (bruteforce-prime maybe-prime (- maybe-prime 1)))))

(def-function my-gcd (a b) (cond
                            ((= a b) a)
                            ((< a b) (my-gcd a (- b a)))
                            ((> a b) (my-gcd b (- a b)))))

(def-function next-divider (tested-number current-divider) (cond
                                                            ((is-divisible-by tested-number current-divider) current-divider)
                                                            (t (next-divider tested-number (+ current-divider 1)))))


(def-function prime-factors (a current-divider) (cond
                                                 ((is-prime a) (cl:list a))
                                                 (t (cl:let ((b (next-divider a current-divider)))
                                                      (cl:if (= a b)
                                                             '()
                                                             (cl:append (cl:list b) (prime-factors (/ a b) b)))))))
(def-function prime-factors-wrapper (a) (prime-factors a 2))