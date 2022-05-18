(defun disc (a b c) (- (* b b) (* 4 a c)))


(defun solve-quad-eq (a b c) (
            cond ((not (= a 0)) (let ((d (disc a b c)))
                                (cond ((= d 0) (let ((x (/ b (* -2 a)))) (list x x)))
                                (T (list (/ (- (- b) (sqrt d)) (* 2 a)) (/ (- (sqrt d) b) (* 2 a)))))))
            ; a = 0
            ((not (= b 0)) (list (/ (- c) b)))
            ; a = 0 b = 0
            ((= c 0) T)
            (T nil)
))


(defun solve-quad-eq-out (a b c)
  (with-open-file (stream "/Users/akrik/Desktop/ФИЛП/lab_03/docs/out.txt" :direction :output :if-exists :supersede)
    (format stream "Уравнение: ~Fx^2 + ~Fx + ~F = 0~%Ответ: " a b c) 
    (let ((res (solve-quad-eq a b c)))
      (cond ((not res) (format stream "Уравнение задано неверно"))
	    ((eq res T) (format stream "Любой x"))
	    ((complexp (car res)) (format stream "x1 = ~F + (~F) * i, x2 = ~F + (~F) * i~%" (realpart (car res)) (imagpart (car res)) (realpart (cadr res)) (imagpart(cadr res))))
      ((eq (cdr res) nil) (format stream "x = ~F~%" (car res)))
	    (T (format stream "x1 = ~F, x2 = ~F~%" (car res) (cadr res)))))))

