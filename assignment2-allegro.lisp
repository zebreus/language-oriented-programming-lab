(in-package :eichhorn)

(def-function has-list (list)
  (and
   list
   (or
    (cl:listp (first list))
    (has-list (rest list)))))

(def-function flatten (nested-list)
  (if (cl:listp nested-list)
      (cl:mapcan 'flatten nested-list)
      (list nested-list)))


(def-function flatten-b (nested-list)
  (cond
   ((not nested-list) '())
   ((not (cl:listp nested-list)) (list nested-list))
   (t (append
        (flatten-b (first nested-list))
        (flatten-b (rest nested-list))))))

(def-function increment-second-if-key-matches (pair key)
  (list (first pair) (if (equal (first pair) key)
                         (+ (second pair) 1)
                         (second pair))))

(def-function increment-or-add-key-in-list (list key)
  (if (cl:assoc key list)
      (cl:mapcar #'(lambda (x) (increment-second-if-key-matches x key)) list)
      (append (list (list key 1)) list)))

(def-function occurrences (flat-list)
  (reverse (reduce #'increment-or-add-key-in-list flat-list :initial-value '())))

(def-function intersperse (seperator list)
  (if (not list)
      '()
      (append (list (cl:car list)) (cl:mapcan #'(lambda (x) (list seperator x)) (rest list)))))

(def-function has-number (list)
  (cl:some #'cl:numberp (flatten list)))

(def-function update-minimum-or-maximum (accumulator value)
  (let
      ((min (first accumulator)) (max (second accumulator)))
    (list
     (if (< value min)
         value
         min)
     (if (> value max)
         value
         max))))

(def-function min-max (list-of-numbers)
  (if (not list-of-numbers)
      '()
      (reduce #'update-minimum-or-maximum list-of-numbers :initial-value (list (first list-of-numbers) (first list-of-numbers)))))

(def-function min-max-lib (list-of-numbers)
  (if (not list-of-numbers)
      '()
      (list (apply #'min list-of-numbers) (apply #'max list-of-numbers))))

(def-function update-minimum-or-maximum-or-default (min-max value)
  (if min-max
      (update-minimum-or-maximum min-max value)
      (list value value)))

(def-function min-max-rec (list-of-numbers)
  (if (not list-of-numbers)
      '()
      (let
          ((rest-min-max (min-max-rec (rest list-of-numbers))))
        (update-minimum-or-maximum-or-default rest-min-max (first list-of-numbers)))))
