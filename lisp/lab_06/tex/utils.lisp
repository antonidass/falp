(defun matrix-get-col (col-i m)
  (let ((res (make-array (array-dimension m 0))))
    (loop for i from 0 below (array-dimension m 0) do
	 (setf (row-major-aref res i) (aref m i col-i)))
    res))

(defun matrix-transpose-a (m)
  (let ((res (make-array (array-dimensions m))))
    (loop for i from 0 below (array-dimension m 0) do
	 (loop for j from 0 below (array-dimension m 1) do
	      (setf (aref res j i) (aref m i j))))
    res))

(defun аrr-minor (row-i col-i m)
  (let ((res (make-array (mapcar #'- (array-dimensions m) '(1 1)))))
    (loop for i from 0 below (array-dimension m 0) do
	 (loop for j from 0 below (array-dimension m 1) do
	      (if (and (/= i row-i) (/= j col-i))
		  (setf (aref res
			      (if (> i row-i) (- i 1) i)
			      (if (> j col-i) (- j 1) j))
			(aref m i j)))))
    res))

(defun det-аrr (m)
  (let ((results (make-array (array-dimension m 1))))
    (if (= (array-dimension m 1) 1) (aref m 0 0)
	(progn
	  (loop for i from 0 below (array-dimension m 0) do
	       (setf (aref results i) (* (det-аrr (аrr-minor 0 i m))
					 (aref m 0 i)
					 (if (oddp i) -1 1))))
	(reduce #'+ results)))))

