(in-package :eichhorn)

;;; rule predicates


(<--- (father ?p1 ?p2)
      "
Rule with parameters:
?p1 : atom - name of a person (father)
?p2 : atom - name of a person (child)

is satisfied if ?p1 is a male parent of ?p2
")
(<- (father ?father ?child)
    (parent ?father ?child)
    (person ?father male))


(<--- (mother ?p1 ?p2)
      "
Rule with parameters:
?p1 : atom - name of a person (mother)
?p2 : atom - name of a person (child)

is satisfied if ?p1 is a female parent of ?p2
")

(<- (mother ?mother ?child)
    (parent ?mother ?child)
    (person ?mother female))

(<--- (child ?p1 ?p2)
      "
Rule with parameters:
?p1  : atom - name of a person (child)
?p2 : atom - name of a person (parent)

is satisfied if ?p2 is a parent of ?p1
")
(<- (child ?child ?parent)
    (parent ?parent ?child))


(<--- (son ?p1 ?p2)
      "
Rule with parameters:
?p1: atom - name of a person (son)
?p2: atom - name of a person (parent)

is satisfied if ?p1 is a male child of ?p2
")
(<- (son ?parent ?son)
    (parent ?parent ?son)
    (person ?son male))


(<--- (daughter ?p1 ?p2)
      "
Rule with parameters:
?p1  : atom - name of a person (daughter)
?p2 : atom - name of a person (parent)

is satisfied if ?p1 is a female child of ?p2
")
(<- (daugther ?parent ?daugther)
    (parent ?parent ?daugther)
    (person ?daugther female))


(<--- (sibling ?p1 ?p2)
      "
Rule with parameters:
?p1  : atom - name of a person
?p2 : atom - name of a person

is satisfied if ?p1 and ?p2 have the same parents but are different
")
(<- (sibling ?child ?sibling)
    (parent ?parent1 ?child)
    (parent ?parent1 ?sibling)

    (parent ?parent2 ?child)
    (parent ?parent2 ?sibling)
    (not (= ?parent1 ?parent2))
    (not (= ?child ?sibling)))

(<--- (brother ?p1 ?p2)
      "
Rule with parameters:
?p1  : atom - name of a person (brother)
?p2 : atom - name of a person (sibling)

is satisfied if ?p1 is a male sibling of ?p2
")
(<- (brother ?child ?brother)
    (sibling ?child ?brother)
    (person ?brother male))


(<--- (sister ?p1 ?p2)
      "
Rule with parameters:
?p1  : atom - name of a person (sister)
?p2 : atom - name of a person (sibling)

is satisfied if ?p1 is a female sibling of ?p2
")
(<- (sister ?child ?sister)
    (sibling ?child ?sister)
    (person ?sister female))


(<--- (grandparent ?p1 ?p2)
      "
Rule with parameters:
?p1 : atom - name of a person (grandparent)
?p2 : atom - name of a person (grandchild)

is satisfied if ?p1 is grandparent of ?p2
")
(<- (grandparent ?grandparent ?grandchild)
    (parent ?parent ?grandchild)
    (parent ?grandparent ?parent))


(<--- (grandfather ?p1 ?p2)
      "
Rule with parameters:
?p1 : atom - name of a person (grandfather)
?p2 : atom - name of a person (grandchild)

is satisfied if ?p1 is the grandfather of ?p2
")
(<- (grandfather ?grandfather ?grandchild)
    (grandparent ?grandfather ?grandchild)
    (person ?grandfather male))


(<--- (grandmother ?p1 ?p2)
      "
Rule with parameters:
?p1 : atom - name of a person (grandmother)
?p2 : atom - name of a person (grandchild)

is satisfied if ?p1 is the grandmother of ?p2
")
(<- (grandmother ?grandmother ?grandchild)
    (grandparent ?grandmother ?grandchild)
    (person ?grandmother male))


(<--- (uncle ?p1 ?p2)
      "
Rule with parameters:
?p1 : atom - name of a person (uncle)
?p2 : atom - name of a person (nephew or niece)

is satisfied if ?p1 is the uncle of ?p2
")
(<- (uncle ?uncle ?nephew)
    (parent ?parent ?nephew)
    (brother ?uncle ?parent))


(<--- (aunt ?aunt ?niece)
      "
Rule with parameters:
?p1 : atom - name of a person (aunt)
?p2 : atom - name of a person (nephew or niece)

is satisfied if ?p1 is the aunt of ?p2
")
(<- (aunt ?aunt ?niece)
    (parent ?parent ?niece)
    (sister ?aunt ?parent))


(<--- (nephew ?p1 ?p2)
      "
Rule with parameters:
?p1 : atom - name of a person (nephew)
?p2 : atom - name of a person (aunt or uncle)

is satisfied if ?p1 is a nephew of ?p2
")
(<- (nephew ?nephew ?unclish)
    (person ?nephew male)
    (parent ?parent ?nephew)
    (sibling ?unclish ?parent))

(<--- (niece ?p1 ?p2)
      "
Rule with parameters:
?p1 : atom - name of a person (niece)
?p2 : atom - name of a person (aunt or uncle)

is satisfied if ?p1 is a niece of ?p2
")
(<- (niece ?niece ?unclish)
    (person ?niece female)
    (parent ?parent ?niece)
    (sibling ?unclish ?parent))


(<--- (cousin ?p1 ?p2)
      "
Rule with parameters:
?p1 : atom - name of a person
?p2 : atom - name of a person

is satisfied if ?p1 and ?p2 are cousins
")
(<- (cousin ?cousin1 ?cousin2)
    (parent ?parent1 ?cousin1)
    (parent ?parent2 ?cousin2)
    (sibling ?parent1 ?parent2))

(<--- (ancestor ?p1 ?p2)
      "
Rule with parameters:
?p1 : atom - name of a person (ancestor)
?p2 : atom - name of a person (descendant)

is satisfied if ?p1 is an ancestor of ?p2
")
(<- (ancestor ?ancestor ?descendant)
    (parent ?ancestor ?descendant))

(<- (ancestor ?ancestor ?descendant)
    (parent ?parent ?descendant)
    (ancestor ?ancestor ?parent))
