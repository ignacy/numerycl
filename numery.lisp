;;;; numery.lisp

(in-package #:numery)

;;; "numery" goes here. Hacks and glory await!

(defun absolute-error (value approximation)
  (abs
   (- (coerce value 'float)
      (coerce approximation 'float))))

(define-test test-absolute-error
    (assert-equal 0.0 (absolute-error 10 10)))

(defun relative-error (absolute-error approximation)
  (/ absolute-error (abs approximation)))


;; To run tests in SLIME use
;; (in-package :numery)
;; (setq *print-failures* t)
;; (run-tests)
