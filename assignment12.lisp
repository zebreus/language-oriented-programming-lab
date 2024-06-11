; Read https://lispcookbook.github.io/cl-cookbook/macros.html

(defmacro ourcase (c d)
  (list 'cond (mapcar (lambda (x y) (list x y)) c d)))

(defmacro ourif (a then-keyword b &optional else-keyword c)
  (cond
   ((not (equal then-keyword 'then)) (error "Then keyword must be 'then"))
   ((and else-keyword (not (equal else-keyword 'else))) (error "Else keyword must be 'else"))
   (t (list 'cond (list a b) (list 't c)))))

(defun foreach-apply (name listt func test)
  (list 'loop 'for name 'in listt
        'collect (list 'cond (list (list test name) (list 'funcall func name)))))


(defun foreach-save (name listt func test)
  (list 'loop 'for name 'in listt
        'if (list test name)
        'collect (list 'funcall func name)))

(defmacro foreach ((name in-keyword listt) (action-keyword func) (when-keyword (test)))
  (cond
   ((not (equal in-keyword 'in)) (error "In keyword must be 'in"))
   ((not (equal when-keyword 'when)) (error "When keyword must be 'when"))
   ((equal action-keyword 'apply) (foreach-apply name listt func test))
   ((equal action-keyword 'save) (foreach-save name listt func test))
   (t (error "Action keyword must be 'apply or 'save"))))

(defun assert-true (name test) (if (not test) (error (format T "Test ~s failed" name))))
(defun assert-false (name test) (if test (error (format T "Test ~s failed" name))))
(defun assert-equal (name a b) (if (not (equal a b)) (error (format T "Test ~s failed: ~s is not equal to ~s" name a b))))

; (defun test-case-macro ()
;   (let
;       ()
;     (assert-equal "Withdraw" 1 (ourcase (t '() '() '()) (1 2 3 4)))
;     (assert-equal "Withdraw" 2 (ourcase ('() t '() '()) (1 2 3 4)))
;     (assert-equal "Withdraw" 3 (ourcase ('() '() t '()) (1 2 3 4)))
;     (assert-equal "Withdraw" 4 (ourcase ('() '() '() t) (1 2 3 4)))))

; (test-case-macro)