(load "~/quicklisp/setup.lisp")
(ql:quickload "fiveam")
(use-package :fiveam)

(load "/Users/akrik/Desktop/ФИЛП/lab_04/def/def.lisp")
(test test-fun
  "Testing functions."
  (is (equal (format nil "~,6f" (my-sin 0.56)) (format nil "~,6f" (sin 0.56))) "sin test")
  (is (equal (format nil "~,6f" (my-cos 0.8)) (format nil "~,6f" (cos 0.8))) "cos test")
  (is (equal (format nil "~,6f" (my-exp 1.0)) (format nil "~,6f" (exp 1.0))) "exp test")
  (is (equal (format nil "~,6d" (my-exp 2.5)) (format nil "~,6d" (exp 2.5d))) "exp test")

  (is (equal (format nil "~,6f" (wrap-log 0.55)) (format nil "~,6f" (log 0.55))) "log test")
  (is (equal (format nil "~,6f" (my-tg 0.225)) (format nil "~,6f" (tan 0.225))) "tg test")
  (is (equal (format nil "~,6f" (my-ctg 0.5)) (format nil "~,6f" (/ 1 (tan 0.5)))) "ctg test")
  (is (equal (format nil "~,6f" (my-asin 0.01)) (format nil "~,6f" (asin 0.01))) "asin test")
  (is (equal (format nil "~,6f" (my-acos 0)) (format nil "~,6f" (acos 0))) "acos test")
  (is (equal (format nil "~,6f" (my-atan 0.333)) (format nil "~,6f" (atan 0.333))) "atan test")
)
(run! 'test-fun)