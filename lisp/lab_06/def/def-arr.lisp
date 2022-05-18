(ql:quickload :array-operations)
(load "/Users/akrik/Desktop/ФИЛП/lab_06/tex/utils.lisp")

(defun matrix-cols-cnt (m)
  (array-dimension m 0))

(defun matrix-rows-cnt (m)
  (array-dimension m 1))

(defun matrix-get (row-i col-i m)
  (aref m row-i col-i))

(defun matrix-get-row (row-i m)
  (make-array (array-dimension m 1) 
	      :displaced-to m 
	      :displaced-index-offset (* row-i (array-dimension m 1))))


(defun arr-minor-internal-copy-row (arr-to arr-from ri-to ri-from ci-to)
  (cond ((>= ci-to (array-dimension arr-to 1))arr-to)
	(T(and (or (setf (aref arr-to ri-to ci-to)(aref arr-from ri-from (+ ci-to 1)))T)
               (arr-minor-internal-copy-row arr-to arr-from ri-to ri-from (+ ci-to 1))))))

(defun arr-minor-internal (arr-to arr-from ri-skip i-to i-from)
  (cond ((>= i-to (array-dimension arr-to 1))arr-to)
	((= ri-skip i-from)(arr-minor-internal arr-to arr-from ri-skip i-to (+ i-from 1)))
	(T(and (arr-minor-internal-copy-row arr-to arr-from i-to i-from 0)
	       (arr-minor-internal arr-to arr-from ri-skip (+ i-to 1) (+ i-from 1))))))

(defun arr-minor (arr ri)
  (let* ((n (array-dimension arr 1))
         (n-new (- n 1))
         (arr-new (make-array `(,n-new ,n-new))))
        (arr-minor-internal arr-new arr ri 0 0)))

(defun det-arr-internal (arr row_index sum)
  (cond ((= 1 (array-dimension arr 0))(aref arr 0 0))
        ((>= row_index (array-dimension arr 0))sum)
        (T (det-arr-internal arr
                             (+ row_index 1)
                             (+ sum
                                (* (expt -1 row_index)
                                   (aref arr row_index 0)
                                   (det-arr-internal (arr-minor arr row_index)
                                                     0
                                                     0)))))))

(defun det-arr (arr)
  (det-arr-internal arr 0 0))


(defun matrix-mult-num-a (num m)
  (aops:each (lambda (it) (* num it)) m))


(defun matrix-associated-internal (res m i j)
  (cond ((and (= (+ i 1) (array-dimension m 0)) (= (+ j 1) (array-dimension m 1))) (setf (aref res i j) 
                                    (* (det-аrr (аrr-minor i j m))
                                       (if (oddp (+ i j)) -1 1))) res)
  ((= (+ j 1) (array-dimension m 1)) (setf (aref res i j) 
                                    (* (det-аrr (аrr-minor i j m))
                                       (if (oddp (+ i j)) -1 1)))  (matrix-associated-internal res m (+ i 1) 0))
  (T (setf (aref res i j) 
                                    (* (det-аrr (аrr-minor i j m))
                                       (if (oddp (+ i j)) -1 1)))  (matrix-associated-internal res m i (+ j 1)))
  )
)

(defun matrix-associated-ar (m)
  (let ((res (make-array (array-dimensions m)))
	(m (matrix-transpose-a m)))
    (matrix-associated-internal res m 0 0)
    res))


(defun matrix-inverse-a (m)
  (matrix-mult-num-a (/ 1 (det-arr m)) (matrix-associated-ar m)))

