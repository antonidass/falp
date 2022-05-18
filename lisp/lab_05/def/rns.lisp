(defun gb () '(2 7 5))

(defun dec-to-rns-in (base n)
    (mapcar (lambda (x) (mod n x)) base))
        
(defun dec-to-rns (n)
    (dec-to-rns-in (gb) n))

(defun inverse-num (base-num num)
    (mod (expt num (- base-num 2)) base-num))

(defun rns-to-dec (rns base) 
    (let* ((M (apply #'* base))
            (Mi (mapcar #'(lambda (x) (/ M x)) base))
            (Bi (mapcar #'inverse-num base Mi))) 
        (mod (apply #'+ (mapcar #'* rns Mi Bi)) M)))


(defun rns-mult (base &rest r-nums)
    (mapcar #'mod (apply #'mapcar #'* r-nums) base))

(defun rns-plus (base &rest r-nums)
    (mapcar #'mod (apply #'mapcar #'+ r-nums) base))

(defun rns-minus (base &rest r-nums)
    (mapcar #'mod (apply #'mapcar #'- r-nums) base))


(defun rns-inverse (base &rest r-nums)
    (mapcar (lambda (num)
	    (mapcar #'inverse-num
		    base num))
	  r-nums))

(defun rns-div (base &rest r-nums)
    (mapcar #'mod 
        (apply #'rns-mult base (car r-nums)
  	        (apply #'rns-inverse base (cdr r-nums))) base))


