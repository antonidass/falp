(load "~/quicklisp/setup.lisp")
(ql:quickload "fiveam")
(use-package :fiveam)

(load "/Users/akrik/Desktop/ФИЛП/lab_05/def/rns.lisp")
(test test-fun
  "Testing functions."
  (is (equal (dec-to-rns 10) '(0 1 0)) "10 from decimal to rns")
  (is (equal (dec-to-rns 29) '(1 2 4)) "29 from decimal to rns")
  (is (equal (dec-to-rns 1) '(1 1 1)) "1 from decimal to rns")

  (is (equal (rns-to-dec '(0 1 0) (gb)) 10) "10 from rns to decimal")
  (is (equal (rns-to-dec '(1 2 4) (gb)) 29) "29 from rns to decimal")
  (is (equal (rns-to-dec '(1 1 1) (gb)) 1) "1 from rns to decimal")

  (is (equal (rns-mult (gb) '(0 2 2) '(1 2 0)) '(0 1 0)) "2 * 5")
  (is (equal (rns-mult (gb) '(0 2 2) '(1 0 3) '(0 1 4)) '(0 0 4)) "2 * 3 * 4")

  (is (equal (rns-plus (gb) '(1 2 0) '(1 2 0)) '(0 1 0)) "5 + 5")
  (is (equal (rns-plus (gb) '(1 2 0) '(1 2 0) '(1 0 0)) '(1 1 0)) "5 + 5 + 15")

  (is (equal (rns-minus (gb) '(0 1 0) '(0 1 0)) '(0 0 0)) "10 - 10")
  (is (equal (rns-minus (gb) '(1 2 4) '(0 0 1) '(1 1 1)) '(0 1 2)) "29 - 6 - 1")

  (is (equal (rns-div (gb) '(0 1 2) '(1 2 1)) '(0 2 2)) "22 / 11")
)
(run! 'test-fun)