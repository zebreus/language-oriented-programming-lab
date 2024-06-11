(defclass person ()
    ((name
      :initarg :name
      :type 'string
      :accessor name)))

(defclass account ()
    ((interest-rate
      :initform 0
      :initarg :interest-rate
      :type 'float
      :accessor interest-rate)

     (balance
      :initform 0
      :initarg :balance
      :type 'float
      :accessor balance)))

(defclass checking-account (account)
    ())

(defclass savings-account (account)
    ())

; TODO: Add check against withdraw amount being larger than balance
(defmethod withdraw ((obj account) amount)
  (setf (slot-value obj 'balance) (- (slot-value obj 'balance) amount)))

(defmethod deposit ((obj account) amount)
  (setf (slot-value obj 'balance) (+ (slot-value obj 'balance) amount)))

; TODO: Make sure that this either fails or suceeds
(defmethod transfer ((from account) (to account) amount)
  (progn
   (withdraw from amount)
   (deposit to amount)))

;TODO: Try if this works
(defmethod apply-interest ((obj account))
  (setf (slot-value obj 'balance) (* (slot-value obj 'balance) (+ 1 (slot-value obj 'interest-rate)))))

;TODO: Everything is unfinished

; Withdraw money from an account
; Deposit money to an account
; Transfer money from one account to another
; Calculate interest rates and add to account balance


(defun assert-true (name test) (if (not test) (error (format T "Test ~s failed" name))))
(defun assert-false (name test) (if test (error (format T "Test ~s failed" name))))
(defun assert-equal (name a b) (if (not (equal a b)) (error (format T "Test ~s failed: ~s is not equal to ~s" name a b))))

(defun test-withdraw ()
  (let
      ((account-i (make-instance 'account :balance 100)))
    (withdraw account-i 50)
    (assert-equal "Withdraw" 50 (slot-value account-i 'balance))
    (withdraw account-i 50)
    (assert-equal "Withdraw" 0 (slot-value account-i 'balance))
    (withdraw account-i 50)
    (assert-equal "Withdraw" -50 (slot-value account-i 'balance))))

(defun test-deposit ()
  (let
      ((account-i (make-instance 'account :balance 100)))
    (setf (slot-value account-i 'balance) 100)
    (deposit account-i 50)
    (assert-equal "Deposit" 150 (slot-value account-i 'balance))
    (deposit account-i 50)
    (assert-equal "Deposit" 200 (slot-value account-i 'balance))))

(defun test-transfer ()
  (let
      ((account-a (make-instance 'account :balance 100.0))
       (account-b (make-instance 'account :balance 100.0)))

    (transfer account-a account-b 50)
    (assert-equal "Transfer" 50 (slot-value account-a 'balance))
    (assert-equal "Transfer" 150 (slot-value account-b 'balance))
    (transfer account-a account-b 100)
    (assert-equal "Transfer" -50 (slot-value account-a 'balance))
    (assert-equal "Transfer" 250 (slot-value account-b 'balance))))

(defun test-apply-interest ()
  (let
      ((account-i (make-instance 'account :balance 100 :interest-rate 0.1)))
    (apply-interest account-i)
    (assert-equal "Apply interest" 110.0 (slot-value account-i 'balance))))

(test-withdraw)
(test-deposit)
(test-transfer)
(test-apply-interest)