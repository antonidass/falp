(defun hyp (x1 x2) (sqrt (+ (* x1 x1) (* x2 x2))))


(defun vol (a b c) (* a (* b c)))

(defun longer_then (a b) (> (length a) (length b)))

(defun f-to-c (x) (/ 5 (* 9 (- x 320))))


(defun f (x) (if (= (mod x 2) 1) (+ x 1) x))

(defvar b (list '1 '2 (cons '3 '4) '5))


(defvar b (list '1 '2 '3))



(defun f (a b c) (if (> a b) (< a c) (> a c)))

(defun beetween (a b c) (or (and (> a b) (< a c)) (and (> a c) (< a b)))) 