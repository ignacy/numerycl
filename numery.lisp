;;;; numery.lisp

(in-package #:numery)

;;; "numery" goes here. Hacks and glory await!

(defun absolute-error (value approximation)
  "Return the absolute error between two numbers"
  (abs
   (- (coerce value 'double-float)
      (coerce approximation 'double-float))))

(define-test test-absolute-error
  (assert-float-equal 0.0d0 (absolute-error 10 10))
  (assert-float-equal 0.5d0 (absolute-error -10 -9.5))
  (assert-float-equal 0.1d0 (absolute-error 10 9.9)))

(defun relative-error (absolute-error approximation)
  "Return the relative error between two numbers"
  (abs (if (or (zerop exact) (zerop approximate))
           (- exact approximate)
           (/ (- exact approximate) exact))))

;; To run tests in SLIME use
;; (ql:quickload "numery")
;; (in-package :numery)
;; (setq *print-failures* t)
;; (run-tests)
