(in-package :cl-tickit)

(include "tickit.h")

(defwrapper "tickit_rect_bottom" :int
  (rect :pointer))

(defwrapper "tickit_rect_right" :int
  (rect :pointer))

(defwrapper "tickit_stringpos_zero" :void
  (pos :pointer))

(defwrapper "tickit_stringpos_limit_none" :void
  (pos :pointer))

(defwrapper "tickit_stringpos_limit_bytes" :void
  (pos :pointer)
  (bytes :pointer))

(defwrapper "tickit_stringpos_limit_codepoints" :void
  (pos :pointer)
  (codepoints :int))

(defwrapper "tickit_stringpos_limit_graphemes" :void
  (pos :pointer)
  (graphemes :int))

(defwrapper "tickit_stringpos_limit_columns" :void
  (pos :pointer)
  (columns :int))
