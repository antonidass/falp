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


(defun matrix-transpose (m)
  (let ((res (make-array (reverse (array-dimensions m)))))
    (loop for i from 0 below (array-dimension m 0) do
	 (loop for j from 0 below (array-dimension m 1) do
	      (setf (aref res j i) (aref m i j))))
    res))