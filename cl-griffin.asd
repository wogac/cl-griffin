;;;; cl-griffin.asd

(asdf:defsystem #:cl-griffin
  :description "Describe cl-griffin here"
  :author "Wojciech Gac <wo.gac@samsung.com>"
  :license  "Specify license here"
  :version "0.0.1"
  :serial t
  :depends-on (#:cl-ppcre #:cl-yaml #:clack)
  :components ((:file "package")
               (:file "cl-griffin")
	       (:file "util")))
