(in-package #:cl-tickit)

(cffi:define-foreign-library libtickit
  (:unix (:or "libtickit.so.2.0.2" "libtickit.so.2"))
  (t (:default "libtickit")))

(cffi:use-foreign-library libtickit)

;;; wrapper library for functions passing structs on the stack

(defvar *wrapper-path*
  (make-pathname
   :directory `(:absolute
                ,(namestring (asdf:system-source-directory :cl-tickit)) "src" "struct-wrapper")
   :name "struct-wrapper.so"))

(cffi:load-foreign-library *wrapper-path*)

;;; This file was automatically generated by SWIG (http://www.swig.org).
;;; Version 3.0.12
;;;
;;; Do not make changes to this file unless you know what you are doing--modify
;;; the SWIG interface file instead.

;;;SWIG wrapper code starts here

(defmacro defanonenum (&body enums)
  "Converts anonymous enums to defconstants."
  `(progn ,@(loop for value in enums
                  for index = 0 then (1+ index)
                  when (listp value) do (setf index (second value)
                                              value (first value))
                    collect `(defconstant ,value ,index))))

;;;SWIG wrapper code ends here

(cffi:defctype TickitPen :pointer)

(cffi:defctype TickitRectSet :pointer)

(cffi:defctype TickitRenderBuffer :pointer)

(cffi:defctype TickitString :pointer)

(cffi:defctype TickitTerm :pointer)

(cffi:defctype TickitWindow :pointer)

(cffi:defctype Tickit :pointer)

(cffi:defctype TickitTermDriver :pointer)

(defanonenum
	(TICKIT_MOD_SHIFT #.#x01)
	(TICKIT_MOD_ALT #.#x02)
	(TICKIT_MOD_CTRL #.#x04))

(defanonenum
	(TICKIT_MOUSEWHEEL_UP #.1)
	TICKIT_MOUSEWHEEL_DOWN)

(cffi:defcfun "tickit_pen_new" :pointer)

(cffi:defcfun "tickit_pen_new_attrs" :pointer
  (attr TickitPenAttr)
  &rest)

(cffi:defcfun "tickit_pen_clone" :pointer
  (orig :pointer))

(cffi:defcfun "tickit_pen_ref" :pointer
  (pen :pointer))

(cffi:defcfun "tickit_pen_unref" :void
  (pen :pointer))

(cffi:defcfun "tickit_pen_has_attr" :bool
  (pen :pointer)
  (attr TickitPenAttr))

(cffi:defcfun "tickit_pen_is_nonempty" :bool
  (pen :pointer))

(cffi:defcfun "tickit_pen_nondefault_attr" :bool
  (pen :pointer)
  (attr TickitPenAttr))

(cffi:defcfun "tickit_pen_is_nondefault" :bool
  (pen :pointer))

(cffi:defcfun "tickit_pen_get_bool_attr" :bool
  (pen :pointer)
  (attr TickitPenAttr))

(cffi:defcfun "tickit_pen_set_bool_attr" :void
  (pen :pointer)
  (attr TickitPenAttr)
  (val :bool))

(cffi:defcfun "tickit_pen_get_int_attr" :int
  (pen :pointer)
  (attr TickitPenAttr))

(cffi:defcfun "tickit_pen_set_int_attr" :void
  (pen :pointer)
  (attr TickitPenAttr)
  (val :int))

(cffi:defcfun "tickit_pen_get_colour_attr" :int
  (pen :pointer)
  (attr TickitPenAttr))

(cffi:defcfun "tickit_pen_set_colour_attr" :void
  (pen :pointer)
  (attr TickitPenAttr)
  (value :int))



(cffi:defcfun "tickit_pen_has_colour_attr_rgb8" :bool
  (pen :pointer)
  (attr TickitPenAttr))

;; the _ptr suffixed functions are wrappers which take/return pointers
;; instead of structs

(cffi:defcfun "tickit_pen_get_colour_attr_rgb8_ptr" :pointer
  (pen :pointer)
  (attr TickitPenAttr))

(cffi:defcfun "tickit_pen_set_colour_attr_rgb8_ptr" :void
  (pen :pointer)
  (attr TickitPenAttr)
  (value :pointer))

(cffi:defcfun "tickit_pen_set_colour_attr_desc" :bool
  (pen :pointer)
  (attr TickitPenAttr)
  (value :string))

(cffi:defcfun "tickit_pen_clear_attr" :void
  (pen :pointer)
  (attr TickitPenAttr))

(cffi:defcfun "tickit_pen_clear" :void
  (pen :pointer))

(cffi:defcfun "tickit_pen_equiv_attr" :bool
  (a :pointer)
  (b :pointer)
  (attr TickitPenAttr))

(cffi:defcfun "tickit_pen_equiv" :bool
  (a :pointer)
  (b :pointer))

(cffi:defcfun "tickit_pen_copy_attr" :void
  (dst :pointer)
  (src :pointer)
  (attr TickitPenAttr))

(cffi:defcfun "tickit_pen_copy" :void
  (dst :pointer)
  (src :pointer)
  (overwrite :bool))

(cffi:defctype TickitPenEventFn :pointer)



(cffi:defcfun "tickit_pen_bind_event" :int
  (tt :pointer)
  (ev TickitPenEvent)
  (flags TickitBindFlags)
  (fn :pointer)
  (user :pointer))

(cffi:defcfun "tickit_pen_unbind_event_id" :void
  (tt :pointer)
  (id :int))

(cffi:defcfun "tickit_pen_attrtype" TickitPenAttrType
  (attr TickitPenAttr))

(cffi:defcfun "tickit_pen_attrname" :string
  (attr TickitPenAttr))

(cffi:defcfun "tickit_pen_lookup_attr" TickitPenAttr
  (name :string))

(cffi:defcfun "tickit_rect_init_sized" :void
  (rect :pointer)
  (top :int)
  (left :int)
  (lines :int)
  (cols :int))

(cffi:defcfun "tickit_rect_init_bounded" :void
  (rect :pointer)
  (top :int)
  (left :int)
  (bottom :int)
  (right :int))

;; these are inline functions that have been wrapped in wrapper.lisp

;; (cffi:defcfun "tickit_rect_bottom" :int
;;   (rect :pointer))

;; (cffi:defcfun "tickit_rect_right" :int
;;   (rect :pointer))

(cffi:defcfun "tickit_rect_translate" :void
  (rect :pointer)
  (downward :int)
  (rightward :int))

(cffi:defcfun "tickit_rect_intersect" :bool
  (dst :pointer)
  (a :pointer)
  (b :pointer))

(cffi:defcfun "tickit_rect_intersects" :bool
  (a :pointer)
  (b :pointer))

(cffi:defcfun "tickit_rect_contains" :bool
  (large :pointer)
  (small :pointer))

(cffi:defcfun "tickit_rect_add" :int
  (ret :pointer)
  (a :pointer)
  (b :pointer))

(cffi:defcfun "tickit_rect_subtract" :int
  (ret :pointer)
  (orig :pointer)
  (hole :pointer))

(cffi:defcfun "tickit_rectset_new" :pointer)

(cffi:defcfun "tickit_rectset_destroy" :void
  (trs :pointer))

(cffi:defcfun "tickit_rectset_clear" :void
  (trs :pointer))

(cffi:defcfun "tickit_rectset_rects" size-t
  (trs :pointer))

(cffi:defcfun "tickit_rectset_get_rect" size-t
  (trs :pointer)
  (i size-t)
  (rects :pointer))

(cffi:defcfun "tickit_rectset_get_rects" size-t
  (trs :pointer)
  (rects :pointer)
  (n size-t))

(cffi:defcfun "tickit_rectset_add" :void
  (trs :pointer)
  (rect :pointer))

(cffi:defcfun "tickit_rectset_subtract" :void
  (trs :pointer)
  (rect :pointer))

(cffi:defcfun "tickit_rectset_translate" :void
  (trs :pointer)
  (downward :int)
  (rightward :int))

(cffi:defcfun "tickit_rectset_intersects" :bool
  (trs :pointer)
  (rect :pointer))

(cffi:defcfun "tickit_rectset_contains" :bool
  (trs :pointer)
  (rect :pointer))

(cffi:defcfun "tickit_string_new" :pointer
  (str :string)
  (len size-t))

(cffi:defcfun "tickit_string_ref" :pointer
  (s :pointer))

(cffi:defcfun "tickit_string_unref" :void
  (s :pointer))

(cffi:defcfun "tickit_string_get" :string
  (s :pointer))

(cffi:defcfun "tickit_string_len" size-t
  (s :pointer))

(cffi:defcfun "tickit_term_new" :pointer)

(cffi:defcfun "tickit_term_new_for_termtype" :pointer
  (termtype :string))

(cffi:defcfun "tickit_term_destroy" :void
  (tt :pointer))





(cffi:defcfun "tickit_term_build" :pointer
  (builder :pointer))

(cffi:defcfun "tickit_term_ref" :pointer
  (tt :pointer))

(cffi:defcfun "tickit_term_unref" :void
  (tt :pointer))

(cffi:defcfun "tickit_term_open_stdio" :pointer)

(cffi:defcfun "tickit_term_get_termtype" :string
  (tt :pointer))

(cffi:defctype TickitTermOutputFunc :pointer)

(cffi:defcfun "tickit_term_set_output_fd" :void
  (tt :pointer)
  (fd :int))

(cffi:defcfun "tickit_term_get_output_fd" :int
  (tt :pointer))

(cffi:defcfun "tickit_term_set_output_func" :void
  (tt :pointer)
  (fn :pointer)
  (user :pointer))

(cffi:defcfun "tickit_term_set_output_buffer" :void
  (tt :pointer)
  (len size-t))

(cffi:defcfun "tickit_term_await_started_msec" :void
  (tt :pointer)
  (msec :long))

(cffi:defcfun "tickit_term_await_started_tv" :void
  (tt :pointer)
  (timeout :pointer))

(cffi:defcfun "tickit_term_flush" :void
  (tt :pointer))

(cffi:defcfun "tickit_term_pause" :void
  (tt :pointer))

(cffi:defcfun "tickit_term_resume" :void
  (tt :pointer))

(cffi:defcfun "tickit_term_set_input_fd" :void
  (tt :pointer)
  (fd :int))

(cffi:defcfun "tickit_term_get_input_fd" :int
  (tt :pointer))

(cffi:defcfun "tickit_term_get_utf8" TickitMaybeBool
  (tt :pointer))

(cffi:defcfun "tickit_term_set_utf8" :void
  (tt :pointer)
  (utf8 :bool))

(cffi:defcfun "tickit_term_input_push_bytes" :void
  (tt :pointer)
  (bytes :string)
  (len size-t))

(cffi:defcfun "tickit_term_input_readable" :void
  (tt :pointer))

(cffi:defcfun "tickit_term_input_check_timeout_msec" :int
  (tt :pointer))

(cffi:defcfun "tickit_term_input_wait_msec" :void
  (tt :pointer)
  (msec :long))

(cffi:defcfun "tickit_term_input_wait_tv" :void
  (tt :pointer)
  (timeout :pointer))

(cffi:defcfun "tickit_term_get_size" :void
  (tt :pointer)
  (lines :pointer)
  (cols :pointer))

(cffi:defcfun "tickit_term_set_size" :void
  (tt :pointer)
  (lines :int)
  (cols :int))

(cffi:defcfun "tickit_term_refresh_size" :void
  (tt :pointer))

(cffi:defcfun "tickit_term_observe_sigwinch" :void
  (tt :pointer)
  (observe :bool))

(cffi:defctype TickitTermEventFn :pointer)



(cffi:defcfun "tickit_term_bind_event" :int
  (tt :pointer)
  (ev TickitTermEvent)
  (flags TickitBindFlags)
  (fn :pointer)
  (user :pointer))

(cffi:defcfun "tickit_term_unbind_event_id" :void
  (tt :pointer)
  (id :int))

(cffi:defcfun "tickit_term_print" :void
  (tt :pointer)
  (str :string))

(cffi:defcfun "tickit_term_printn" :void
  (tt :pointer)
  (str :string)
  (len size-t))

(cffi:defcfun "tickit_term_printf" :void
  (tt :pointer)
  (fmt :string)
  &rest)

(cffi:defcfun "tickit_term_vprintf" :void
  (tt :pointer)
  (fmt :string)
  (args :pointer))

(cffi:defcfun "tickit_term_goto" :bool
  (tt :pointer)
  (line :int)
  (col :int))

(cffi:defcfun "tickit_term_move" :void
  (tt :pointer)
  (downward :int)
  (rightward :int))

(cffi:defcfun "tickit_term_scrollrect_ptr" :bool
  (tt :pointer)
  (rect :pointer)
  (downward :int)
  (rightward :int))

(cffi:defcfun "tickit_term_chpen" :void
  (tt :pointer)
  (pen :pointer))

(cffi:defcfun "tickit_term_setpen" :void
  (tt :pointer)
  (pen :pointer))

(cffi:defcfun "tickit_term_clear" :void
  (tt :pointer))

(cffi:defcfun "tickit_term_erasech" :void
  (tt :pointer)
  (count :int)
  (moveend TickitMaybeBool))

(cffi:defcfun "tickit_term_getctl_int" :bool
  (tt :pointer)
  (ctl TickitTermCtl)
  (value :pointer))

(cffi:defcfun "tickit_term_setctl_int" :bool
  (tt :pointer)
  (ctl TickitTermCtl)
  (value :int))

(cffi:defcfun "tickit_term_setctl_str" :bool
  (tt :pointer)
  (ctl TickitTermCtl)
  (value :string))

(cffi:defcfun "tickit_term_emit_key" :void
  (tt :pointer)
  (info :pointer))

(cffi:defcfun "tickit_term_emit_mouse" :void
  (tt :pointer)
  (info :pointer))

(cffi:defcfun "tickit_term_ctlname" :string
  (ctl TickitTermCtl))

(cffi:defcfun "tickit_term_lookup_ctl" TickitTermCtl
  (name :string))

(cffi:defcfun "tickit_term_ctltype" TickitType
  (ctl TickitTermCtl))

(cffi:defcfun "tickit_utf8_seqlen" :int
  (codepoint :long))

(cffi:defcfun "tickit_utf8_put" size-t
  (str :string)
  (len size-t)
  (codepoint :long))

(cffi:defcfun "tickit_utf8_count" size-t
  (str :string)
  (pos :pointer)
  (limit :pointer))

(cffi:defcfun "tickit_utf8_countmore" size-t
  (str :string)
  (pos :pointer)
  (limit :pointer))

(cffi:defcfun "tickit_utf8_ncount" size-t
  (str :string)
  (len size-t)
  (pos :pointer)
  (limit :pointer))

(cffi:defcfun "tickit_utf8_ncountmore" size-t
  (str :string)
  (len size-t)
  (pos :pointer)
  (limit :pointer))

;; (cffi:defcfun "tickit_stringpos_zero" :void
;;   (pos :pointer))

;; (cffi:defcfun "tickit_stringpos_limit_none" :void
;;   (pos :pointer))

;; (cffi:defcfun "tickit_stringpos_limit_bytes" :void
;;   (pos :pointer)
;;   (bytes :pointer))

;; (cffi:defcfun "tickit_stringpos_limit_codepoints" :void
;;   (pos :pointer)
;;   (codepoints :int))

;; (cffi:defcfun "tickit_stringpos_limit_graphemes" :void
;;   (pos :pointer)
;;   (graphemes :int))

;; (cffi:defcfun "tickit_stringpos_limit_columns" :void
;;   (pos :pointer)
;;   (columns :int))

(cffi:defcfun "tickit_utf8_mbswidth" :int
  (str :string))

(cffi:defcfun "tickit_utf8_byte2col" :int
  (str :string)
  (byte size-t))

(cffi:defcfun "tickit_utf8_col2byte" size-t
  (str :string)
  (col :int))

(cffi:defcfun "tickit_renderbuffer_new" :pointer
  (lines :int)
  (cols :int))

(cffi:defcfun "tickit_renderbuffer_destroy" :void
  (rb :pointer))

(cffi:defcfun "tickit_renderbuffer_ref" :pointer
  (rb :pointer))

(cffi:defcfun "tickit_renderbuffer_unref" :void
  (rb :pointer))

(cffi:defcfun "tickit_renderbuffer_get_size" :void
  (rb :pointer)
  (lines :pointer)
  (cols :pointer))

(cffi:defcfun "tickit_renderbuffer_translate" :void
  (rb :pointer)
  (downward :int)
  (rightward :int))

(cffi:defcfun "tickit_renderbuffer_clip" :void
  (rb :pointer)
  (rect :pointer))

(cffi:defcfun "tickit_renderbuffer_mask" :void
  (rb :pointer)
  (mask :pointer))

(cffi:defcfun "tickit_renderbuffer_has_cursorpos" :bool
  (rb :pointer))

(cffi:defcfun "tickit_renderbuffer_get_cursorpos" :void
  (rb :pointer)
  (line :pointer)
  (col :pointer))

(cffi:defcfun "tickit_renderbuffer_goto" :void
  (rb :pointer)
  (line :int)
  (col :int))

(cffi:defcfun "tickit_renderbuffer_ungoto" :void
  (rb :pointer))

(cffi:defcfun "tickit_renderbuffer_setpen" :void
  (rb :pointer)
  (pen :pointer))

(cffi:defcfun "tickit_renderbuffer_reset" :void
  (rb :pointer))

(cffi:defcfun "tickit_renderbuffer_save" :void
  (rb :pointer))

(cffi:defcfun "tickit_renderbuffer_savepen" :void
  (rb :pointer))

(cffi:defcfun "tickit_renderbuffer_restore" :void
  (rb :pointer))

(cffi:defcfun "tickit_renderbuffer_skip_at" :void
  (rb :pointer)
  (line :int)
  (col :int)
  (cols :int))

(cffi:defcfun "tickit_renderbuffer_skip" :void
  (rb :pointer)
  (cols :int))

(cffi:defcfun "tickit_renderbuffer_skip_to" :void
  (rb :pointer)
  (col :int))

(cffi:defcfun "tickit_renderbuffer_skiprect" :void
  (rb :pointer)
  (rect :pointer))

(cffi:defcfun "tickit_renderbuffer_text_at" :int
  (rb :pointer)
  (line :int)
  (col :int)
  (text :string))

(cffi:defcfun "tickit_renderbuffer_textn_at" :int
  (rb :pointer)
  (line :int)
  (col :int)
  (text :string)
  (len size-t))

(cffi:defcfun "tickit_renderbuffer_text" :int
  (rb :pointer)
  (text :string))

(cffi:defcfun "tickit_renderbuffer_textn" :int
  (rb :pointer)
  (text :string)
  (len size-t))

(cffi:defcfun "tickit_renderbuffer_textf_at" :int
  (rb :pointer)
  (line :int)
  (col :int)
  (fmt :string)
  &rest)

(cffi:defcfun "tickit_renderbuffer_vtextf_at" :int
  (rb :pointer)
  (line :int)
  (col :int)
  (fmt :string)
  (args :pointer))

(cffi:defcfun "tickit_renderbuffer_textf" :int
  (rb :pointer)
  (fmt :string)
  &rest)

(cffi:defcfun "tickit_renderbuffer_vtextf" :int
  (rb :pointer)
  (fmt :string)
  (args :pointer))

(cffi:defcfun "tickit_renderbuffer_erase_at" :void
  (rb :pointer)
  (line :int)
  (col :int)
  (cols :int))

(cffi:defcfun "tickit_renderbuffer_erase" :void
  (rb :pointer)
  (cols :int))

(cffi:defcfun "tickit_renderbuffer_erase_to" :void
  (rb :pointer)
  (col :int))

(cffi:defcfun "tickit_renderbuffer_eraserect" :void
  (rb :pointer)
  (rect :pointer))

(cffi:defcfun "tickit_renderbuffer_clear" :void
  (rb :pointer))

(cffi:defcfun "tickit_renderbuffer_char_at" :void
  (rb :pointer)
  (line :int)
  (col :int)
  (codepoint :long))

(cffi:defcfun "tickit_renderbuffer_char" :void
  (rb :pointer)
  (codepoint :long))

(cffi:defcfun "tickit_renderbuffer_hline_at" :void
  (rb :pointer)
  (line :int)
  (startcol :int)
  (endcol :int)
  (style TickitLineStyle)
  (caps TickitLineCaps))

(cffi:defcfun "tickit_renderbuffer_vline_at" :void
  (rb :pointer)
  (startline :int)
  (endline :int)
  (col :int)
  (style TickitLineStyle)
  (caps TickitLineCaps))

(cffi:defcfun "tickit_renderbuffer_copyrect" :void
  (rb :pointer)
  (dest :pointer)
  (src :pointer))

(cffi:defcfun "tickit_renderbuffer_moverect" :void
  (rb :pointer)
  (dest :pointer)
  (src :pointer))

(cffi:defcfun "tickit_renderbuffer_flush_to_term" :void
  (rb :pointer)
  (tt :pointer))

(cffi:defcfun "tickit_renderbuffer_blit" :void
  (dst :pointer)
  (src :pointer))



(cffi:defcfun "tickit_renderbuffer_get_cell_active" :int
  (rb :pointer)
  (line :int)
  (col :int))

(cffi:defcfun "tickit_renderbuffer_get_cell_text" size-t
  (rb :pointer)
  (line :int)
  (col :int)
  (buffer :string)
  (len size-t))

(cffi:defcfun "tickit_renderbuffer_get_cell_linemask_ptr" :pointer
  (rb :pointer)
  (line :int)
  (col :int))

(cffi:defcfun "tickit_renderbuffer_get_cell_pen" :pointer
  (rb :pointer)
  (line :int)
  (col :int))

(cffi:defcfun "tickit_renderbuffer_get_span" size-t
  (rb :pointer)
  (line :int)
  (startcol :int)
  (info :pointer)
  (buffer :string)
  (len size-t))

(cffi:defcfun "tickit_window_new_root" :pointer
  (term :pointer))

(cffi:defcfun "tickit_window_new_ptr" :pointer
  (parent :pointer)
  (rect :pointer)
  (flags TickitWindowFlags))

(cffi:defcfun "tickit_window_parent" :pointer
  (win :pointer))

(cffi:defcfun "tickit_window_root" :pointer
  (win :pointer))

(cffi:defcfun "tickit_window_children" size-t
  (win :pointer))

(cffi:defcfun "tickit_window_get_children" size-t
  (win :pointer)
  (children :pointer)
  (n size-t))

(cffi:defcfun "tickit_window_get_term" :pointer
  (win :pointer))

(cffi:defcfun "tickit_window_close" :void
  (win :pointer))

(cffi:defcfun "tickit_window_destroy" :void
  (win :pointer))

(cffi:defcfun "tickit_window_ref" :pointer
  (win :pointer))

(cffi:defcfun "tickit_window_unref" :void
  (win :pointer))

(cffi:defctype TickitWindowEventFn :pointer)



(cffi:defcfun "tickit_window_bind_event" :int
  (win :pointer)
  (ev TickitWindowEvent)
  (flags TickitBindFlags)
  (fn :pointer)
  (user :pointer))

(cffi:defcfun "tickit_window_unbind_event_id" :void
  (win :pointer)
  (id :int))

(cffi:defcfun "tickit_window_raise" :void
  (win :pointer))

(cffi:defcfun "tickit_window_raise_to_front" :void
  (win :pointer))

(cffi:defcfun "tickit_window_lower" :void
  (win :pointer))

(cffi:defcfun "tickit_window_lower_to_back" :void
  (win :pointer))

(cffi:defcfun "tickit_window_show" :void
  (win :pointer))

(cffi:defcfun "tickit_window_hide" :void
  (win :pointer))

(cffi:defcfun "tickit_window_is_visible" :bool
  (win :pointer))

(cffi:defcfun "tickit_window_get_geometry_ptr" :pointer
  (win :pointer))

(cffi:defcfun "tickit_window_get_abs_geometry_ptr" :pointer
  (win :pointer))

(cffi:defcfun "tickit_window_bottom" :int
  (win :pointer))

(cffi:defcfun "tickit_window_right" :int
  (win :pointer))

(cffi:defcfun "tickit_window_resize" :void
  (win :pointer)
  (lines :int)
  (cols :int))

(cffi:defcfun "tickit_window_reposition" :void
  (win :pointer)
  (top :int)
  (left :int))

(cffi:defcfun "tickit_window_set_geometry_ptr" :void
  (win :pointer)
  (rect :pointer))

(cffi:defcfun "tickit_window_get_pen" :pointer
  (win :pointer))

(cffi:defcfun "tickit_window_set_pen" :void
  (win :pointer)
  (pen :pointer))

(cffi:defcfun "tickit_window_expose" :void
  (win :pointer)
  (exposed :pointer))

(cffi:defcfun "tickit_window_flush" :void
  (win :pointer))

(cffi:defcfun "tickit_window_scrollrect" :bool
  (win :pointer)
  (rect :pointer)
  (downward :int)
  (rightward :int)
  (pen :pointer))

(cffi:defcfun "tickit_window_scroll" :bool
  (win :pointer)
  (downward :int)
  (rightward :int))

(cffi:defcfun "tickit_window_scroll_with_children" :bool
  (win :pointer)
  (downward :int)
  (rightward :int))

(cffi:defcfun "tickit_window_set_cursor_position" :void
  (win :pointer)
  (line :int)
  (col :int))

(cffi:defcfun "tickit_window_set_cursor_visible" :void
  (win :pointer)
  (visible :bool))

(cffi:defcfun "tickit_window_set_cursor_shape" :void
  (win :pointer)
  (shape TickitCursorShape))

(cffi:defcfun "tickit_window_take_focus" :void
  (win :pointer))

(cffi:defcfun "tickit_window_is_focused" :bool
  (win :pointer))

(cffi:defcfun "tickit_window_set_focus_child_notify" :void
  (win :pointer)
  (notify :bool))

(cffi:defcfun "tickit_window_getctl_int" :bool
  (win :pointer)
  (ctl TickitWindowCtl)
  (value :pointer))

(cffi:defcfun "tickit_window_setctl_int" :bool
  (win :pointer)
  (ctl TickitWindowCtl)
  (value :int))

(cffi:defcfun "tickit_window_is_steal_input" :bool
  (win :pointer))

(cffi:defcfun "tickit_window_set_steal_input" :void
  (win :pointer)
  (steal :bool))

(cffi:defcfun "tickit_window_ctlname" :string
  (ctl TickitWindowCtl))

(cffi:defcfun "tickit_window_lookup_ctl" TickitWindowCtl
  (name :string))

(cffi:defcfun "tickit_window_ctltype" TickitType
  (ctl TickitWindowCtl))

(cffi:defctype TickitCallbackFn :pointer)

(cffi:defcfun "tickit_new_for_term" :pointer
  (tt :pointer))

(cffi:defcfun "tickit_new_stdio" :pointer)

(cffi:defcfun "tickit_ref" :pointer
  (t_arg0 :pointer))

(cffi:defcfun "tickit_unref" :void
  (t_arg0 :pointer))

(cffi:defcfun "tickit_get_term" :pointer
  (t_arg0 :pointer))

(cffi:defcfun "tickit_get_rootwin" :pointer
  (t_arg0 :pointer))

(cffi:defcfun "tickit_run" :void
  (t_arg0 :pointer))

(cffi:defcfun "tickit_stop" :void
  (t_arg0 :pointer))

(cffi:defcfun "tickit_tick" :void
  (t_arg0 :pointer)
  (flags TickitRunFlags))

(cffi:defcfun "tickit_getctl_int" :bool
  (tt :pointer)
  (ctl TickitCtl)
  (value :pointer))

(cffi:defcfun "tickit_setctl_int" :bool
  (tt :pointer)
  (ctl TickitCtl)
  (value :int))

(cffi:defcfun "tickit_ctlname" :string
  (ctl TickitCtl))

(cffi:defcfun "tickit_lookup_ctl" TickitCtl
  (name :string))

(cffi:defcfun "tickit_ctltype" TickitType
  (ctl TickitCtl))

(cffi:defcfun "tickit_watch_io_read" :pointer
  (t_arg0 :pointer)
  (fd :int)
  (flags TickitBindFlags)
  (fn :pointer)
  (user :pointer))

(cffi:defcfun "tickit_watch_timer_after_msec" :pointer
  (t_arg0 :pointer)
  (msec :int)
  (flags TickitBindFlags)
  (fn :pointer)
  (user :pointer))

(cffi:defcfun "tickit_watch_timer_after_tv" :pointer
  (t_arg0 :pointer)
  (after :pointer)
  (flags TickitBindFlags)
  (fn :pointer)
  (user :pointer))

(cffi:defcfun "tickit_watch_timer_at_epoch" :pointer
  (t_arg0 :pointer)
  (at time-t)
  (flags TickitBindFlags)
  (fn :pointer)
  (user :pointer))

(cffi:defcfun "tickit_watch_timer_at_tv" :pointer
  (t_arg0 :pointer)
  (at :pointer)
  (flags TickitBindFlags)
  (fn :pointer)
  (user :pointer))

(cffi:defcfun "tickit_watch_later" :pointer
  (t_arg0 :pointer)
  (flags TickitBindFlags)
  (fn :pointer)
  (user :pointer))

(cffi:defcfun "tickit_watch_cancel" :void
  (t_arg0 :pointer)
  (watch :pointer))

(cffi:defcfun "tickit_hook_terminfo" :void
  (t_arg0 :pointer)
  (getstr :pointer)
  (data :pointer))

(cffi:defcfun "tickit_debug_init" :void)

(cffi:defcvar "tickit_debug_enabled" :bool)

(cffi:defcfun "tickit_debug_logf" :void
  (flag :string)
  (fmt :string)
  &rest)

(cffi:defcfun "tickit_debug_vlogf" :void
  (flag :string)
  (fmt :string)
  (args :pointer))

(cffi:defcfun "tickit_debug_set_func" :void
  (func :pointer)
  (data :pointer))

(cffi:defcfun "tickit_debug_set_fh" :void
  (fh :pointer))

(cffi:defcfun "tickit_debug_open" :bool
  (path :string))

(do-symbols (s)
  (when (eq (symbol-package s) *package*)
    (export s)))
