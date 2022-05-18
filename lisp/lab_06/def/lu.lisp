(defun matrix-dimensions (m)
  (array-dimensions m))


(defun make-matrix (row col &key (initial-element 0.0) (initial-contents nil))
  (if (null initial-contents)
      (make-array (list row col) :initial-element initial-element)
      (make-array (list row col) :initial-contents initial-contents)))

(defun copy-matrix (m)
  (destructuring-bind (row col) (matrix-dimensions m)
    (let ((mt (make-array (list row col))))
      (dotimes (i row)
        (dotimes (j col) (setf (aref mt i j) (aref m i j))))
      mt)))


(defun make-id-matrix-internal (m order i)
  (cond ((= i order) m)
      (T (setf (aref m i i) 1.0) (make-id-matrix-internal m order (+ i 1)) )  
))

(defun make-id-matrix (order)
  (let ((m (make-array (list order order) :initial-element 0.0)))
    (make-id-matrix-internal m order 0)
    m))

(defun lud-internal (mu ma index dim i)
  (cond ((= i (- dim index)) mu)
      (T (setf (aref mu index (+ index i 1))
                                      (aref ma index (+ index i 1))) (lud-internal mu ma index dim (+ i 1)))  
))


(defun lud-internal-second (ml ma index dim i)
  (cond ((= i (- dim index)) ml)
      (T (setf (aref ml (+ index i 1) index)
                                      (/ (aref ma (+ index i 1) index)
                                         (aref ma index index))) (lud-internal-second ml ma index dim (+ i 1)))  
))


(defun lud-internal-body (ma index dim i j)
  (cond ((and (= (+ i 1) (- dim index)) (= (+ j 1) (- dim index))) (decf (aref ma (+ index i 1) (+ index j 1))
                                        (/ (* (aref ma (+ index i 1) index)
                                              (aref ma index (+ index j 1)))
                                           (aref ma index index))) ma)

  ((= (+ j 1) (- dim index)) (decf (aref ma (+ index i 1) (+ index j 1))
                                        (/ (* (aref ma (+ index i 1) index)
                                              (aref ma index (+ index j 1)))
                                           (aref ma index index))) (lud-internal-body ma index dim (+ i 1) 0))
  (T (decf (aref ma (+ index i 1) (+ index j 1))
                                        (/ (* (aref ma (+ index i 1) index)
                                              (aref ma index (+ index j 1)))
                                           (aref ma index index)))  (lud-internal-body ma index dim i (+ j 1)))
  )
)

(defun lud (m)
  (destructuring-bind (row col) (matrix-dimensions m)
    (when (= row col)
      (let ((l (make-id-matrix row))
            (u (make-matrix row row))
            (mt (copy-matrix m)))
        (labels ((lud-sub (ma ml mu index dim-1)
                   (declare (inline lud-sub))
                   (if (>= index dim-1)
                       (progn (setf (aref mu dim-1 dim-1)
                                    (aref ma dim-1 dim-1))
                              (values ml mu))
                       (progn (setf (aref mu index index)
                                    (aref ma index index))
                              (lud-internal mu ma index dim-1 0)
                              (lud-internal-second ml ma index dim-1 0)
                              (lud-internal-body ma index dim-1 0 0)
                              (lud-sub ma ml mu (1+ index) dim-1)))))
          (lud-sub mt l u 0 (1- row)))))))


(defun test-decomposition (matrix)
  (multiple-value-bind (lower upper) (lud matrix)
      (format nil "LOWER: ~S~%UPPER: ~S~%" lower upper)))




; (test-decomposition #2A((2 7 -6) (8 2 1) (7 4 2)))
; (load "/Users/akrik/Desktop/ФИЛП/lab_06/def/lu.lisp")