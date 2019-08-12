;;; tui...

(defsystem :cl-tickit
  :author "tianlin qu <tianlinqu@gmail.com>"
  :description "A set of CFFI bindings to the C libtickit library."
  :license "MIT License"
  :defsystem-depends-on ("cffi-grovel")
  :depends-on (:cffi-libffi :cl-unicode)
  :serial t
  :pathname "src/"
  :components ((:file "package")
               (:cffi-grovel-file "grovel")
               (:cffi-wrapper-file "wrappers")
               (:file "bindings")))
