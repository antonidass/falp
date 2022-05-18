(defun matrix-transpose (m)
    (if m (apply #'mapcar #'list m)))


(defun zerofy-column (m p first_row col_j)
  (mapcar
   #'(lambda (mi li)
      (let
        ((lz (nth col_j li)))
        (mapcar
          #'(lambda (mij fj)
            (-
              mij
              (* fj lz)))
          mi
          first_row)))
   m
   p))



; Находит первую строчку в матрице a, в которой элемент в col_i колнке не нулевой 
(defun first-nonzero (a col_i &optional (i 0))
  (cond
   ((null a) nil)
   ((zerop (nth col_i (car a))) (first-nonzero (cdr a) col_i (1+ i)))
   (i)))


(defun identity-mat (n)
  (cond
   ((= n 1) (cons (cons 1 nil) nil))
   ((let ((r (identity-mat (1- n))))
      (cons
       (cons
        1
        (cons 0 (cdar r)))
       (mapcar
        #'(lambda (x) (cons 0 x))
        r))))))

; Поместить i элемент списка а в начало
(defun bubble-element (a i)
  (let ((ai (nth i a)))
    (cond
     ((zerop i) a)
     ((null ai) a)
     ((cons
       ai
       (remove-if
        (constantly t)
        a
        :start i
        :count 1))))))



(defun triangular (a b &optional (col_j 0) (ra nil) (rb nil))
  (cond
   ((null a) (cons ra (cons rb nil)))
   ((let* ((row_i (cond
                   ((first-nonzero a col_j))
                   ((throw 'nonzero-not-found "Determinant is zero"))))
           (sa (bubble-element a row_i))
           (sb (bubble-element b row_i))
           (fz (nth col_j (car sa))))
      (triangular
       (zerofy-column
        (cdr sa)
        (cdr sa)
        (mapcar #'(lambda (x) (/ x fz)) (car sa))
        col_j)
       (zerofy-column
        (cdr sb)
        (cdr sa)
        (mapcar #'(lambda (x) (/ x fz)) (car sb))
        col_j)
       (1+ col_j)
       (cons (reverse (car sa)) ra)
       (cons (reverse (car sb)) rb))))))



(defun inverse (m)
  (catch 'nonzero-not-found
         (apply
          #'mapcar
          #'(lambda (ar br)
        (let
          ((nz (find-if-not #'zerop ar)))
          (mapcar
            #'(lambda (bi) (/ bi nz))
            br)))
          (apply
           #'triangular
           (triangular
            m
            (identity-mat (length m)))))))












