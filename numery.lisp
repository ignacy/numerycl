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

;; To run tests in SLIME use
;; (ql:quickload "numery")
;; (in-package :numery)
;; (setq *print-failures* t)
;; (run-tests)
