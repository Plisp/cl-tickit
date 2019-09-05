;;;; straightfoward translation of demo.c from libtickit's examples

(defpackage :tickit-demo
  (:use :cl)
  (:export :main))
(in-package :tickit-demo)

(defvar *counter*)
(defvar *highlight-pen*)
;; since we have to do a copy anyway, copy fields to lisp to simplify things
(defvar *last-key-type* 0
  "Initially 0 (no key event) to prevent unbound variable error on first expose event.")
(defvar *last-key-mod*)
(defvar *last-key-string*)

(defvar *last-mouse-line*)
(defvar *last-mouse-col*)
(defvar *last-mouse-button*)
(defvar *last-mouse-type* 0
  "Initially 0 (no mouse event) to prevent unbound variable error on first expose event.")
(defvar *last-mouse-mod*)

(defvar *key-window*)
(defvar *mouse-window*)
(defvar *timer-window*)

;; here translate-from-foreign's behaviour (call foreign-enum-keyword) is not desirable as
;; tickiteventflags contains a mask of tickit-ev-fire and tickit-ev-unbind
;; we don't need `flags` anyways so we declare it as :pointer

(cffi:defcallback render-root :int ((win :pointer)
                                    (flags :pointer)
                                    (info :pointer)
                                    (user :pointer))
  (declare (ignore flags user))
  (let ((renderbuffer (cffi:foreign-slot-value info '(:struct tkt:tickitexposeeventinfo) 'tkt:rb))
        (right (1- (cffi:foreign-slot-value (tkt:tickit-window-get-geometry-ptr win)
                                            '(:struct tkt:tickitrect) 'tkt:cols)))
        (bottom (1- (cffi:foreign-slot-value (tkt:tickit-window-get-geometry-ptr win)
                                             '(:struct tkt:tickitrect) 'tkt:lines)))
        (pen-blue (tkt:tickit-pen-new-attrs (cffi:foreign-enum-value 'tkt:tickitpenattr :tickit-pen-fg)
                                            :int (+ 4 8)
                                            :int 0))
        (pen-white (tkt:tickit-pen-new-attrs (cffi:foreign-enum-value 'tkt:tickitpenattr :tickit-pen-fg)
                                             :int (+ 7 8)
                                             :int 0)))
    (cffi:with-foreign-object (rect '(:struct tkt:tickitrect))
      (setf (cffi:foreign-slot-value rect '(:struct tkt:tickitrect) 'tkt:top) 0
            (cffi:foreign-slot-value rect '(:struct tkt:tickitrect) 'tkt:left) 0
            (cffi:foreign-slot-value rect '(:struct tkt:tickitrect) 'tkt:lines) (1+ bottom)
            (cffi:foreign-slot-value rect '(:struct tkt:tickitrect) 'tkt:cols) (1+ right))
      (tkt:tickit-renderbuffer-eraserect renderbuffer rect))
    ;; draw the horizontal bar
    (tkt:tickit-renderbuffer-setpen renderbuffer pen-blue)
    (tkt:tickit-renderbuffer-hline-at renderbuffer 1 0 right
                                      (cffi:foreign-enum-value 'tkt:tickitlinestyle :tickit-line-single)
                                      0)
    (tkt:tickit-renderbuffer-vline-at renderbuffer 0 2 0
                                      (cffi:foreign-enum-value 'tkt:tickitlinestyle :tickit-line-single)
                                      0)
    (tkt:tickit-renderbuffer-vline-at renderbuffer 0 2 right
                                      (cffi:foreign-enum-value 'tkt:tickitlinestyle :tickit-line-single)
                                      0)
    (tkt:tickit-renderbuffer-setpen renderbuffer pen-white)
    (tkt:tickit-renderbuffer-goto renderbuffer 1 (- (/ right 2) 2))
    (tkt:tickit-renderbuffer-text renderbuffer (format nil " ~d " (1+ right)))
    ;; draw the vertical bar
    (tkt:tickit-renderbuffer-setpen renderbuffer pen-blue)
    (tkt:tickit-renderbuffer-vline-at renderbuffer 0 bottom (- right 2)
                                      (cffi:foreign-enum-value 'tkt:tickitlinestyle :tickit-line-single)
                                      0)
    (tkt:tickit-renderbuffer-hline-at renderbuffer 0 (- right 4) right
                                      (cffi:foreign-enum-value 'tkt:tickitlinestyle :tickit-line-single)
                                      0)
    (tkt:tickit-renderbuffer-hline-at renderbuffer bottom (- right 4) right
                                      (cffi:foreign-enum-value 'tkt:tickitlinestyle :tickit-line-single)
                                      0)
    (tkt:tickit-renderbuffer-setpen renderbuffer pen-white)
    (tkt:tickit-renderbuffer-goto renderbuffer (1- (/ bottom 2)) (- right 4))
    (tkt:tickit-renderbuffer-text renderbuffer (format nil "~d" (1+ bottom))))
  1)

(cffi:defcallback event-resize :int ((win :pointer)
                                     (flags :pointer)
                                     (info :pointer)
                                     (user :pointer))
  (declare (ignore flags info user))
  (cffi:with-foreign-objects ((key-rect '(:struct tkt:tickitrect))
                              (timer-rect '(:struct tkt:tickitrect)))
    (cffi:with-foreign-slots ((tkt:top tkt:left tkt:lines tkt:cols) key-rect (:struct tkt:tickitrect))
      (setf tkt:top 2
            tkt:left 2
            tkt:lines 3
            tkt:cols (- (cffi:foreign-slot-value (tkt:tickit-window-get-geometry-ptr win)
                                                 '(:struct tkt:tickitrect) 'tkt:cols)
                        7)))
    (tkt:tickit-window-set-geometry-ptr *key-window* key-rect)
    (cffi:with-foreign-slots ((tkt:top tkt:left tkt:lines tkt:cols) timer-rect (:struct tkt:tickitrect))
      (setf tkt:top 15
            tkt:left 2
            tkt:lines 3
            tkt:cols (- (cffi:foreign-slot-value (tkt:tickit-window-get-geometry-ptr win)
                                                 '(:struct tkt:tickitrect) 'tkt:cols)
                        7)))
    (tkt:tickit-window-set-geometry-ptr *timer-window* timer-rect)
    (tkt:tickit-window-expose win (cffi:null-pointer)))
  1)

(defun render-modifier (renderbuffer mod)
  (if (= mod 0) (return-from render-modifier))
  (tkt:tickit-renderbuffer-text renderbuffer
                                (format nil "<~{~a~^|~}>"
                                        (loop :for m :in (list tkt:tickit-mod-shift
                                                               tkt:tickit-mod-alt
                                                               tkt:tickit-mod-ctrl)
                                              :for name :in '("SHIFT" "ALT" "CTRL")
                                              :when (not (zerop (logand mod m)))
                                                :collect name))))

(cffi:defcallback render-mouse :int ((win :pointer)
                                     (flags :pointer)
                                     (info :pointer)
                                     (user :pointer))
  (declare (ignore win flags user))
  (let ((renderbuffer (cffi:foreign-slot-value info '(:struct tkt:tickitexposeeventinfo) 'tkt:rb))
        (rect-ptr (cffi:foreign-slot-pointer info '(:struct tkt:tickitexposeeventinfo) 'tkt:rect)))
    (tkt:tickit-renderbuffer-eraserect renderbuffer rect-ptr)

    (tkt:tickit-renderbuffer-goto renderbuffer 0 0)
    (tkt:tickit-renderbuffer-savepen renderbuffer)
    (tkt:tickit-renderbuffer-setpen renderbuffer *highlight-pen*)
    (tkt:tickit-renderbuffer-text renderbuffer "Mouse:")
    (tkt:tickit-renderbuffer-restore renderbuffer)

    (tkt:tickit-renderbuffer-goto renderbuffer 2 2)
    (case *last-mouse-type*
      (:tickit-mouseev-press
       (tkt:tickit-renderbuffer-text renderbuffer "press   "))
      (:tickit-mouseev-drag
       (tkt:tickit-renderbuffer-text renderbuffer "drag    "))
      (:tickit-mouseev-release
       (tkt:tickit-renderbuffer-text renderbuffer "release "))
      (:tickit-mouseev-wheel
       (tkt:tickit-renderbuffer-text renderbuffer "wheel "))
      (t
       (return-from render-mouse 0)))

    (if (eq *last-mouse-type* :tickit-mouseev-wheel)
        (if (eq *last-mouse-button* tkt:tickit-mousewheel-down)
            (tkt:tickit-renderbuffer-text renderbuffer "down")
            (tkt:tickit-renderbuffer-text renderbuffer "up"))
        (tkt:tickit-renderbuffer-text renderbuffer (format nil "button ~d" *last-mouse-button*)))

    (tkt:tickit-renderbuffer-text renderbuffer (format nil " at (~d,~d)" *last-mouse-line* *last-mouse-col*))
    (render-modifier renderbuffer *last-mouse-mod*))
  1)

(cffi:defcallback event-mouse :int ((win :pointer)
                                    (flags :pointer)
                                    (info :pointer)
                                    (user :pointer))
  (declare (ignore win flags user))
  (setf *last-mouse-line* (cffi:foreign-slot-value info '(:struct tkt:tickitmouseeventinfo) 'tkt:line)
        *last-mouse-col* (cffi:foreign-slot-value info '(:struct tkt:tickitmouseeventinfo) 'tkt:col)
        *last-mouse-button* (cffi:foreign-slot-value info '(:struct tkt:tickitmouseeventinfo) 'tkt:button)
        *last-mouse-type* (cffi:foreign-slot-value info '(:struct tkt:tickitmouseeventinfo) 'tkt:type)
        *last-mouse-mod* (cffi:foreign-slot-value info '(:struct tkt:tickitmouseeventinfo) 'tkt:mod))
  (tkt:tickit-window-expose *mouse-window* (cffi:null-pointer))
  1)

(cffi:defcallback render-key :int ((win :pointer)
                                   (flags :pointer)
                                   (info :pointer)
                                   (user :pointer))
  (declare (ignore win flags user))
  (let ((renderbuffer
          (cffi:foreign-slot-value info '(:struct tkt:tickitexposeeventinfo) 'tkt:rb))
        (rect-ptr
          (cffi:foreign-slot-pointer info '(:struct tkt:tickitexposeeventinfo) 'tkt:rect)))
    (tkt:tickit-renderbuffer-eraserect renderbuffer rect-ptr)

    (tkt:tickit-renderbuffer-goto renderbuffer 0 0)
    (tkt:tickit-renderbuffer-savepen renderbuffer)
    (tkt:tickit-renderbuffer-setpen renderbuffer *highlight-pen*)
    (tkt:tickit-renderbuffer-text renderbuffer "Key:")
    (tkt:tickit-renderbuffer-restore renderbuffer)

    (tkt:tickit-renderbuffer-goto renderbuffer 2 2)
    (case *last-key-type*
      (:tickit-keyev-key
       (tkt:tickit-renderbuffer-text renderbuffer "text "))
      (:tickit-keyev-text
       (tkt:tickit-renderbuffer-text renderbuffer "key  "))
      (t
       (return-from render-key 0)))
    (tkt:tickit-renderbuffer-text renderbuffer *last-key-string*)

    (render-modifier renderbuffer *last-key-mod*))
  1)

(cffi:defcallback event-key :int ((win :pointer)
                                  (flags :pointer)
                                  (info :pointer)
                                  (user :pointer))
  (declare (ignore win flags user))
  (setf *last-key-type* (cffi:foreign-slot-value info '(:struct tkt:tickitkeyeventinfo) 'tkt:type)
        *last-key-mod* (cffi:foreign-slot-value info '(:struct tkt:tickitkeyeventinfo) 'tkt:mod)
        *last-key-string* (cffi:foreign-slot-value info '(:struct tkt:tickitkeyeventinfo) 'tkt:str))

  (tkt:tickit-window-expose *key-window* (cffi:null-pointer))
  1)

(cffi:defcallback render-timer :int ((win :pointer)
                                     (flags :pointer)
                                     (info :pointer)
                                     (user :pointer))
  (declare (ignore win flags))
  (let ((renderbuffer (cffi:foreign-slot-value info '(:struct tkt:tickitexposeeventinfo) 'tkt:rb))
        (rect-ptr (cffi:foreign-slot-pointer info '(:struct tkt:tickitexposeeventinfo) 'tkt:rect)))
    (tkt:tickit-renderbuffer-eraserect renderbuffer rect-ptr)

    (tkt:tickit-renderbuffer-goto renderbuffer 0 0)
    (tkt:tickit-renderbuffer-savepen renderbuffer)
    (tkt:tickit-renderbuffer-setpen renderbuffer *highlight-pen*)
    (tkt:tickit-renderbuffer-text renderbuffer "Counter:")
    (tkt:tickit-renderbuffer-restore renderbuffer)

    (tkt:tickit-renderbuffer-goto renderbuffer 2 2)
    (tkt:tickit-renderbuffer-text renderbuffer (princ-to-string (cffi:mem-ref user :int))))
  1)

(cffi:defcallback on-timer :int ((tickit :pointer)
                                 (flags :pointer)
                                 (info :pointer)
                                 (user :pointer))
  (declare (ignore flags info))
  (tkt:tickit-window-expose *timer-window* (cffi:null-pointer))
  (incf (cffi:mem-ref user :int))
  ;; reschedule the timer callback
  (tkt:tickit-watch-timer-after-msec tickit 1000 0
                                     (cffi:callback on-timer)
                                     user)
  0)

(defun main ()
  (let* ((tickit (tkt:tickit-new-stdio))
         (root (tkt:tickit-get-rootwin tickit))
         (*counter* (cffi:foreign-alloc :int :initial-element 0))
         (*highlight-pen* ; calling varargs
           (tkt:tickit-pen-new-attrs (cffi:foreign-enum-value 'tkt:tickitpenattr :tickit-pen-fg)
                                     :int 3
                                     :int (cffi:foreign-enum-value 'tkt:tickitpenattr :tickit-pen-bold)
                                     :int 1
                                     :int 0))
         (key-rect (cffi:foreign-alloc '(:struct tkt:tickitrect)))
         (mouse-rect (cffi:foreign-alloc '(:struct tkt:tickitrect)))
         (timer-rect (cffi:foreign-alloc '(:struct tkt:tickitrect))))

    (cffi:with-foreign-slots
        ((tkt:top tkt:left tkt:lines tkt:cols) key-rect (:struct tkt:tickitrect))
      (setf tkt:top 2
            tkt:left 2
            tkt:lines 3
            tkt:cols (- (cffi:foreign-slot-value (tkt:tickit-window-get-geometry-ptr root)
                                                 '(:struct tkt:tickitrect) 'tkt:cols)
                        7)))
    (setf *key-window* (tkt:tickit-window-new-ptr root key-rect 0))

    (cffi:with-foreign-slots
        ((tkt:top tkt:left tkt:lines tkt:cols) mouse-rect (:struct tkt:tickitrect))
      (setf tkt:top 8
            tkt:left 2
            tkt:lines 3
            tkt:cols (- (cffi:foreign-slot-value (tkt:tickit-window-get-geometry-ptr root)
                                                 '(:struct tkt:tickitrect) 'tkt:cols)
                        7)))
    (setf *mouse-window* (tkt:tickit-window-new-ptr root mouse-rect 0))

    (cffi:with-foreign-slots
        ((tkt:top tkt:left tkt:lines tkt:cols) timer-rect (:struct tkt:tickitrect))
      (setf tkt:top 15
            tkt:left 2
            tkt:lines 3
            tkt:cols (- (cffi:foreign-slot-value (tkt:tickit-window-get-geometry-ptr root)
                                                 '(:struct tkt:tickitrect) 'tkt:cols)
                        7)))
    (setf *timer-window* (tkt:tickit-window-new-ptr root timer-rect 0))

    ;; root window
    (tkt:tickit-window-bind-event root
                                  (cffi:foreign-enum-value
                                   'tkt:tickitwindowevent :tickit-window-on-expose)
                                  0
                                  (cffi:callback render-root)
                                  (cffi:null-pointer))
    (tkt:tickit-window-bind-event root
                                  (cffi:foreign-enum-value
                                   'tkt:tickitwindowevent :tickit-window-on-geomchange)
                                  0
                                  (cffi:callback event-resize)
                                  (cffi:null-pointer))
    ;; key events display
    (tkt:tickit-window-bind-event *key-window*
                                  (cffi:foreign-enum-value
                                   'tkt:tickitwindowevent :tickit-window-on-expose)
                                  0
                                  (cffi:callback render-key)
                                  (cffi:null-pointer))
    (tkt:tickit-window-bind-event root
                                  (cffi:foreign-enum-value
                                   'tkt:tickitwindowevent :tickit-window-on-key)
                                  0
                                  (cffi:callback event-key)
                                  (cffi:null-pointer))
    ;; mouse events display
    (tkt:tickit-window-bind-event *mouse-window*
                                  (cffi:foreign-enum-value
                                   'tkt:tickitwindowevent :tickit-window-on-expose)
                                  0
                                  (cffi:callback render-mouse)
                                  (cffi:null-pointer))
    (tkt:tickit-window-bind-event root
                                  (cffi:foreign-enum-value
                                   'tkt:tickitwindowevent :tickit-window-on-mouse)
                                  0
                                  (cffi:callback event-mouse)
                                  (cffi:null-pointer))
    ;; timer display
    (tkt:tickit-watch-timer-after-msec tickit 1000 0
                                       (cffi:callback on-timer)
                                       *counter*)
    (tkt:tickit-window-bind-event *timer-window*
                                  (cffi:foreign-enum-value
                                   'tkt:tickitwindowevent :tickit-window-on-expose)
                                  0
                                  (cffi:callback render-timer)
                                  *counter*)

    (tkt:tickit-window-take-focus root)
    (tkt:tickit-window-set-cursor-visible root 0)
    (tkt:tickit-run tickit) ; run the main loop
    (tkt:tickit-window-close root)
    (tkt:tickit-unref tickit)
    ;; free foreign memory
    (cffi:foreign-free *counter*)
    (cffi:foreign-free *highlight-pen*)
    (cffi:foreign-free key-rect)
    (cffi:foreign-free mouse-rect)
    (cffi:foreign-free timer-rect)))
