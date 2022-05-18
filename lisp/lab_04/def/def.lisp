(defun my-sin (x &optional (eps 1E-6) (s x) (n 1) (a x))
  (let ((a (- (/ (* a x x) (+ n 1) (+ n 2)))))
       (if (<= (abs a) eps) s (my-sin x eps (+ s a) (+ n 2) a))))


(defun my-exp (x &optional (eps 1E-6) (s 1) (n 1) (a 1))
  (let ((a (/ (* a x) n)))
       (if (<= (abs a) eps) s (my-exp x eps (+ s a) (+ n 1) a))))


(defun my-cos (x &optional (eps 1E-6) (s 1) (n 1) (a 1))
  (let ((a (- (/ (* a x x) n (+ n 1)))))
       (if (<= (abs a) eps) s (my-cos x eps (+ s a) (+ n 2) a))))


(defun my-asin (x &optional (eps 1E-6) (s x) (n 1) (a x))
  (let ((a (/ (* a x x (- (* 2 n) 1)) (* 2 n))))
       (if (<= (abs (/ a (+ (* 2 n) 1))) eps) s (my-asin x eps (+ s (/ a (+ (* 2 n) 1))) (+ n 1) a))))

(defun my-acos (x &optional (eps 1E-6)) (- (/ pi 2) (my-asin x eps)))


(defun my-atan (x &optional (eps 1E-6) (s x) (n 1) (a x))
  (let ((a (- (* a x x))))
       (if (<= (abs (/ a (+ n 2))) eps) s (my-atan x eps (+ s (/ a (+ n 2))) (+ n 2) a))))


(defun my-tg (x &optional (eps 1E-6)) (/ (my-sin x eps) (my-cos x eps)))

(defun my-ctg (x &optional (eps 1E-6)) (/ (my-cos x eps) (my-sin x eps)))


(defun my-log (x &optional (eps 1E-12) (s x) (n 1) (a x))
  (let ((a (- (* a x))))
       (if (<= (abs (/ a (+ n 1))) eps) s (my-log x eps (+ s (/ a (+ n 1))) (+ n 1) a))))

(defun wrap-log (x &optional (eps 1E-12)) (my-log (- x 1) eps))









