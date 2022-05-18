(defun hyp (x1 x2) (sqrt (+ (* x1 x1) (* x2 x2))))


(defun vol (a b c) (* a (* b c)))

(defun longer_then (a b) (> (length a) (length b)))

(defun f-to-c (x) (/ 5 (* 9 (- x 320))))


(defun f (x) (if (= (mod x 2) 1) (+ x 1) x))