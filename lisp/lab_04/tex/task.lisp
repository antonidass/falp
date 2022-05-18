(defun between (a b c) (or (> b a c) (> c a b)))

(defun if-between (a b c) (if (> b a c) T (> c a b)))


(defun cond-between (a b c) (cond ((> b a c) T)
                                  ((> c a b) T)
                                  (T nil)))