(load "~/quicklisp/setup.lisp")
(ql:quickload "fiveam")
(use-package :fiveam)

(load "/Users/akrik/Desktop/ФИЛП/lab_03/docs/def.lisp")

(test test-square-fun
  "Testing function for quadratic equation."
  (is (equal (solve-quad-eq 1 -2 1) '(1 1)) "D=0 I test")
  (is (equal (solve-quad-eq 1 2 1) '(-1 -1)) "D=0 II test")
  (is (equal (solve-quad-eq 4 12 5) '(-2.5 -0.5)) "D>0 I test")
  (is (equal (solve-quad-eq 0 3 12) '(-4)) "a = 0 test")
  (is (equal (solve-quad-eq 0 0 1) NIL) "Wrong equation")
  (is (equal (solve-quad-eq 0 0 0) T) "Any value")
  (is (equal (solve-quad-eq 2 4 4) '(#C(-1.0 -1.0) #C(-1.0 1.0))) "D<0 I test")
)
(run! 'test-square-fun)