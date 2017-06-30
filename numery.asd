;;;; numery.asd

(asdf:defsystem #:numery
  :description "Describe numery here"
  :author "Your Name <your.name@example.com>"
  :license "Specify license here"
  :serial t
  :depends-on (#:lisp-unit)
  :components ((:file "package")
               (:file "numery")))
