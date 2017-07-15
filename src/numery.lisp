;;;; numery.lisp

(in-package #:numery)

;;; "numery" goes here. Hacks and glory await!

(defun absolute-error (value approximation)
  "Return the absolute error between two numbers"
  (abs
   (- (coerce value 'double-float)
      (coerce approximation 'double-float))))

(define-test test-absolute-error
  (setq *print-failures* t)
  (assert-true (= 0.0d0 (absolute-error 10 10)))
  (assert-true (= 0.5d0 (absolute-error -10 -9.5)))
  (assert-true (< 0.1 (absolute-error 10 9.9) 0.15)))

(defun relative-error (absolute-error approximation)
  "Return the relative error between two numbers"
  (abs (/ absolute-error approximation)))

(define-test test-relative-error
  (setq *print-failures* t)
  (assert-true (< 0.0105 (relative-error 0.02d0 1.9d0) 0.0106))
  (assert-true (< 0.0444 (relative-error 0.08d0 1.8d0) 0.0445)))

(defun print-float (float)
  (format t "~10$" float))

(defun factorial (n)
  "Computes factorial for small n using iterative approach"
  (check-type n unsigned-byte)
  (loop for i from 0 to n
     for factorial = 1 then (* factorial i)
     finally (return factorial)))

(define-test test-factorial
  (assert-equal 3628800 (factorial 10))
  (assert-equal 1 (factorial 0)))

(defun series-1 (max)
  (loop for n from 0 to max
     sum (* (expt -1 n) (/ (* 2 n) (factorial (+ n 2))))))

(defvar *epsilon-for-series-1* 0.0000000001)
(defvar *max-sequence-expansion* 30)

(defun series-sum-1 (series)
  "Computes estimated sum of alternating convergent series assuming
  that the sum would be the term n which satisfies condition:

     | term(n) - term(n-1) | < Epsilon

  "
  (loop for n from 0 to *max-sequence-expansion*
     for epsilon = (abs (- (funcall series n) (funcall series (+ n 1))))
     when (< epsilon *epsilon-for-series-1*)
     return (format nil "Sum ~8$ at sequence number ~d ~%" (funcall series n) n)))

(define-test test-series-sum-1
  (assert-true (string=
   (format nil "Sum -0.20727664 at sequence number 12 ~%")
   (series-sum-1 #'series-1))))

;; -- Function errors --
(ql:quickload "cl-autodiff")
;; Computing derivatives using cl-autodiff is done by using:
;; (define-with-derivatives p (x) (* x x))
;; (multiple-value-bind (val der) (p 3) (format t "Value ~d~%" val) (format t "Derivative ~d~%" der))
(define-with-derivatives f (x) (* x x x))

(defun get-derivative-from (expression)
  (elt (nth-value 1 expression) 0))

(defun absolute-function-error (derf dx)
  "Computes the absolute error for f(x) values assuming that x's
   are given with dx precision"
  (* (abs derf) dx))


(define-test test-absolute-function--error
  (setq *print-failures* t)
  (assert-true (< 0.48
                  (absolute-function-error (get-derivative-from (f 2.3)) 0.03d0)
                  0.5)))



;; To run tests in SLIME use
;; (ql:quickload "numery")
;; (in-package :numery)
;; (setq *print-failures* t)
;; (run-tests)
