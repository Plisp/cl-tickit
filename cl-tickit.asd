(defsystem :cl-tickit
  :author "tianlin qu <tianlinqu@gmail.com>"
  :description "A set of CFFI bindings to the C libtickit library."
  :license "MIT License"
  :defsystem-depends-on ("cffi-grovel")
  :depends-on (:cffi :cl-unicode :trivial-features)
  :serial t
  :pathname "src/"
  :components ((:module bin
                :components ((:static-file "struct-wrapper.so")
                             (:static-file "struct-wrapper-x86.so")))
               (:file "package")
               (:cffi-grovel-file "grovel")
               (:cffi-wrapper-file "grovel-wrappers")
               (:file "bindings")))
