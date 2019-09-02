(defsystem :cl-tickit
  :author "tianlin qu <tianlinqu@gmail.com>"
  :description "A set of CFFI bindings to the C libtickit library."
  :license "MIT License"
  :defsystem-depends-on ("cffi-grovel")
  :depends-on (:cffi :cl-unicode)
  :serial t
  :pathname "src/"
  :components ((:module struct-wrapper
                :components ((:static-file "struct-wrapper.c")))
               (:file "package")
               (:cffi-grovel-file "grovel")
               (:cffi-wrapper-file "grovel-wrappers")
               (:file "bindings")))

(defmethod perform :before ((o prepare-op) (c (eql (find-system :cl-unicode))))
  (let* ((srcdir (namestring
                  (make-pathname
                   :directory `(:absolute ,(namestring (asdf:system-source-directory :cl-tickit))
                                          "src" "struct-wrapper"))))
         (wrapper-source (uiop:strcat srcdir "struct-wrapper.c"))
         (wrapper-object (uiop:strcat srcdir "struct-wrapper.o"))
         (wrapper-library (uiop:strcat srcdir "struct-wrapper.so")))
    (when (null (probe-file wrapper-library))
      (uiop:run-program `("cc" "-c" "-fPIC" ,wrapper-source "-o" ,wrapper-object))
      (uiop:run-program `("cc" "-shared" ,wrapper-object "-o" ,wrapper-library "-ltickit")))))
