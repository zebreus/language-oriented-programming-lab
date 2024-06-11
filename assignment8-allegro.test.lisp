(in-package :eichhorn)


(<--- (person ?name ?gender)
      "
Fact with parameters:
?name : atom - unique name of a person
?gender : atom - either male or female
")

(<- (person Martin male))
(<- (person Herbert male))
(<- (person Rudolf male))
(<- (person Sarah female))
(<- (person Franz male))
(<- (person Marga female))
(<- (person Gutrun female))
(<- (person Jacqueline female))
(<- (person Mary female))
(<- (person Grandgrand female))

(<--- (parent ?p1 ?p2)
      "
Fact with parameters:
?p1  : atom - name of a person (parent)
?p2 : atom - name of a person (child)
")

(<- (parent Grandgrand Martin))
(<- (parent Martin Herbert))
(<- (parent Martin Rudolf))
(<- (parent Martin Franz))
(<- (parent Martin Sarah))
(<- (parent Marga Herbert))
(<- (parent Marga Rudolf))
(<- (parent Marga Franz))
(<- (parent Marga Sarah))


(<- (parent Herbert Jacqueline))
(<- (parent Herbert Gutrun))
(<- (parent Mary Jacqueline))
(<- (parent Mary Gutrun))


(def-test
 persons-are-defined
 (progn
  (assert-equal 'male (first (query ?gender (person Herbert ?gender))))))

(def-test
 parent-works
 (progn
  (assert-true (cl:member 'Martin (query ?parent (parent ?parent Herbert))))
  (assert-true (cl:member 'Marga (query ?parent (parent ?parent Herbert))))
  (assert-false (cl:member 'Mary (query ?parent (parent ?parent Herbert))))))

(def-test
 father-works
 (progn
  (assert-true (cl:member 'Martin (query ?father (father ?father Herbert))))
  (assert-false (cl:member 'Marga (query ?father (father ?father Herbert))))
  (assert-false (cl:member 'Mary (query ?father (father ?father Herbert))))))

(def-test
 mother-works
 (progn
  (assert-false (cl:member 'Martin (query ?mother (mother ?mother Herbert))))
  (assert-true (cl:member 'Marga (query ?mother (mother ?mother Herbert))))
  (assert-false (cl:member 'Mary (query ?mother (mother ?mother Herbert))))))

(def-test
 sibling-works
 (progn
  (assert-true (prove (sibling Herbert Franz)))
  (assert-true (prove (sibling Herbert Rudolf)))
  (assert-true (prove (sibling Herbert Sarah)))
  (assert-true (prove (sibling Rudolf Franz)))
  (assert-true (prove (sibling Rudolf Sarah)))
  (assert-true (prove (sibling Franz Sarah)))
  (assert-true (prove (sibling Jacqueline Gutrun)))
  (assert-false (prove (sibling Jacqueline Franz)))))

(def-test
 brother-works
 (progn
  (assert-true (prove (brother Herbert Franz)))
  (assert-true (prove (brother Herbert Rudolf)))
  (assert-true (prove (brother Rudolf Franz)))
  (assert-false (prove (brother Rudolf Sarah)))
  (assert-false (prove (brother Jacqueline Gutrun)))
  (assert-false (prove (brother Jacqueline Franz)))))

(def-test
 grandfather-works
 (progn
  (assert-true (cl:member 'Martin (query ?grandfather (grandfather ?grandfather Jacqueline))))
  (assert-true (cl:member 'Martin (query ?grandfather (grandfather ?grandfather Gutrun))))
  (assert-false (cl:member 'Marga (query ?grandfather (grandfather ?grandfather Jacqueline))))
  (assert-false (cl:member 'Marga (query ?grandfather (grandfather ?grandfather Gutrun))))))

(def-test
 uncle-works
 (progn
  (assert-true (prove (uncle Franz Jacqueline)))
  (assert-true (prove (uncle Franz Gutrun)))
  (assert-true (prove (uncle Rudolf Jacqueline)))
  (assert-true (prove (uncle Rudolf Gutrun)))
  (assert-false (prove (uncle Franz Sarah)))
  (assert-false (prove (uncle Rudolf Sarah)))
  (assert-false (prove (uncle Jacqueline Gutrun)))
  (assert-false (prove (uncle Jacqueline Franz)))))

(def-test
 niece-works
 (progn
  (assert-true (prove (niece Jacqueline Franz)))
  (assert-true (prove (niece Jacqueline Rudolf)))
  (assert-true (prove (niece Jacqueline Sarah)))
  (assert-true (prove (niece Gutrun Franz)))
  (assert-true (prove (niece Gutrun Rudolf)))
  (assert-true (prove (niece Gutrun Sarah)))
  (assert-false (prove (nephew Gutrun Sarah)))
  (assert-false (prove (nephew Gutrun Franz)))
  (assert-false (prove (niece Franz Sarah)))
  (assert-false (prove (niece Rudolf Sarah)))))

(def-test
 ancestor-works
 (progn
  (assert-true (prove (ancestor Grandgrand Martin)))
  (assert-true (prove (ancestor Grandgrand Jacqueline)))
  (assert-false (prove (ancestor Martin Grandgrand)))
  (assert-true (prove (ancestor Martin Jacqueline)))
  (assert-true (prove (ancestor Martin Jacqueline)))))