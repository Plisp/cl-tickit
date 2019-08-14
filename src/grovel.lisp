(in-package #:cl-tickit)

(cc-flags "-std=c11")

(ctype size-t "size_t")
(ctype time-t "time_t")

(include "tickit.h")

;;; enums

(cenum TickitBindFlags
       ((:TICKIT-BIND-FIRST "TICKIT_BIND_FIRST"))
       ((:TICKIT-BIND-UNBIND "TICKIT_BIND_UNBIND"))
       ((:TICKIT-BIND-DESTROY "TICKIT_BIND_DESTROY")))

(cenum TickitCtl
       ((:TICKIT-CTL-USE-ALTSCREEN "TICKIT_CTL_USE_ALTSCREEN"))
       ((:TICKIT-N-CTLS "TICKIT_N_CTLS")))

(cenum TickitCursorShape
       ((:TICKIT-CURSORSHAPE-BLOCK "TICKIT_CURSORSHAPE_BLOCK"))
       ((:TICKIT-CURSORSHAPE-UNDER "TICKIT_CURSORSHAPE_UNDER"))
       ((:TICKIT-CURSORSHAPE-LEFT-BAR "TICKIT_CURSORSHAPE_LEFT_BAR")))

(cenum TickitLineCaps
       ((:TICKIT-LINECAP-START "TICKIT_LINECAP_START"))
       ((:TICKIT-LINECAP-END "TICKIT_LINECAP_END"))
       ((:TICKIT-LINECAP-BOTH "TICKIT_LINECAP_BOTH")))

(cenum TickitLineStyle
       ((:TICKIT-LINE-SINGLE "TICKIT_LINE_SINGLE"))
       ((:TICKIT-LINE-DOUBLE "TICKIT_LINE_DOUBLE"))
       ((:TICKIT-LINE-THICK "TICKIT_LINE_THICK")))

(cenum TickitMaybeBool
       ((:TICKIT-NO "TICKIT_NO"))
       ((:TICKIT-YES "TICKIT_YES"))
       ((:TICKIT-MAYBE "TICKIT_MAYBE")))

(cenum TickitPenAttr
       ((:TICKIT-PEN-FG "TICKIT_PEN_FG"))
       ((:TICKIT-PEN-BG "TICKIT_PEN_BG"))
       ((:TICKIT-PEN-BOLD "TICKIT_PEN_BOLD"))
       ((:TICKIT-PEN-UNDER "TICKIT_PEN_UNDER"))
       ((:TICKIT-PEN-ITALIC "TICKIT_PEN_ITALIC"))
       ((:TICKIT-PEN-REVERSE "TICKIT_PEN_REVERSE"))
       ((:TICKIT-PEN-STRIKE "TICKIT_PEN_STRIKE"))
       ((:TICKIT-PEN-ALTFONT "TICKIT_PEN_ALTFONT"))
       ((:TICKIT-PEN-BLINK "TICKIT_PEN_BLINK"))
       ((:TICKIT-N-PEN-ATTRS "TICKIT_N_PEN_ATTRS")))

(cenum TickitPenUnderline
       ((:TICKIT-PEN-UNDER-NONE "TICKIT_PEN_UNDER_NONE"))
       ((:TICKIT-PEN-UNDER-SINGLE "TICKIT_PEN_UNDER_SINGLE"))
       ((:TICKIT-PEN-UNDER-DOUBLE "TICKIT_PEN_UNDER_DOUBLE"))
       ((:TICKIT-PEN-UNDER-WAVY "TICKIT_PEN_UNDER_WAVY"))
       ((:TICKIT-N-PEN-UNDERS "TICKIT_N_PEN_UNDERS")))

(cenum TickitRunFlags
       ((:TICKIT-RUN-DEFAULT "TICKIT_RUN_DEFAULT"))
       ((:TICKIT-RUN-ONCE "TICKIT_RUN_ONCE"))
       ((:TICKIT-RUN-NOHANG "TICKIT_RUN_NOHANG"))
       ((:TICKIT-RUN-NOSETUP "TICKIT_RUN_NOSETUP")))

(cenum TickitTermCtl
       ((:TICKIT-TERMCTL-ALTSCREEN "TICKIT_TERMCTL_ALTSCREEN"))
       ((:TICKIT-TERMCTL-CURSORVIS "TICKIT_TERMCTL_CURSORVIS"))
       ((:TICKIT-TERMCTL-MOUSE "TICKIT_TERMCTL_MOUSE"))
       ((:TICKIT-TERMCTL-CURSORBLINK "TICKIT_TERMCTL_CURSORBLINK"))
       ((:TICKIT-TERMCTL-CURSORSHAPE "TICKIT_TERMCTL_CURSORSHAPE"))
       ((:TICKIT-TERMCTL-ICON-TEXT "TICKIT_TERMCTL_ICON_TEXT"))
       ((:TICKIT-TERMCTL-TITLE-TEXT "TICKIT_TERMCTL_TITLE_TEXT"))
       ((:TICKIT-TERMCTL-ICONTITLE-TEXT "TICKIT_TERMCTL_ICONTITLE_TEXT"))
       ((:TICKIT-TERMCTL-KEYPAD-APP "TICKIT_TERMCTL_KEYPAD_APP"))
       ((:TICKIT-TERMCTL-COLORS "TICKIT_TERMCTL_COLORS"))
       ((:TICKIT-N-TERMCTLS "TICKIT_N_TERMCTLS")))

(cenum TickitTermMouseMode
       ((:TICKIT-TERM-MOUSEMODE-OFF "TICKIT_TERM_MOUSEMODE_OFF"))
       ((:TICKIT-TERM-MOUSEMODE-CLICK "TICKIT_TERM_MOUSEMODE_CLICK"))
       ((:TICKIT-TERM-MOUSEMODE-DRAG "TICKIT_TERM_MOUSEMODE_DRAG"))
       ((:TICKIT-TERM-MOUSEMODE-MOVE "TICKIT_TERM_MOUSEMODE_MOVE")))

(cenum TickitType
       ((:TICKIT-TYPE-NONE "TICKIT_TYPE_NONE"))
       ((:TICKIT-TYPE-BOOL "TICKIT_TYPE_BOOL"))
       ((:TICKIT-TYPE-INT "TICKIT_TYPE_INT"))
       ((:TICKIT-TYPE-STR "TICKIT_TYPE_STR"))
       ((:TICKIT-TYPE-COLOUR "TICKIT_TYPE_COLOUR")))

(cenum TickitWindowCtl
       ((:TICKIT-WINCTL-STEAL-INPUT "TICKIT_WINCTL_STEAL_INPUT"))
       ((:TICKIT-WINCTL-FOCUS-CHILD-NOTIFY "TICKIT_WINCTL_FOCUS_CHILD_NOTIFY"))
       ((:TICKIT-WINCTL-CURSORVIS "TICKIT_WINCTL_CURSORVIS"))
       ((:TICKIT-WINCTL-CURSORBLINK "TICKIT_WINCTL_CURSORBLINK"))
       ((:TICKIT-WINCTL-CURSORSHAPE "TICKIT_WINCTL_CURSORSHAPE"))
       ((:TICKIT-N-WINCTLS "TICKIT_N_WINCTLS")))

(cenum TickitWindowFlags
       ((:TICKIT-WINDOW-HIDDEN "TICKIT_WINDOW_HIDDEN"))
       ((:TICKIT-WINDOW-LOWEST "TICKIT_WINDOW_LOWEST"))
       ((:TICKIT-WINDOW-ROOT-PARENT "TICKIT_WINDOW_ROOT_PARENT"))
       ((:TICKIT-WINDOW-STEAL-INPUT "TICKIT_WINDOW_STEAL_INPUT"))
       ((:TICKIT-WINDOW-POPUP "TICKIT_WINDOW_POPUP")))

(cenum TickitPenAttrType
       ((:TICKIT-PENTYPE-BOOL "TICKIT_PENTYPE_BOOL"))
       ((:TICKIT-PENTYPE-INT "TICKIT_PENTYPE_INT"))
       ((:TICKIT-PENTYPE-COLOUR "TICKIT_PENTYPE_COLOUR")))

(cenum TickitEventFlags
       ((:TICKIT-EV-FIRE "TICKIT_EV_FIRE"))
       ((:TICKIT-EV-UNBIND "TICKIT_EV_UNBIND"))
       ((:TICKIT-EV-DESTROY "TICKIT_EV_DESTROY")))

(cenum TickitKeyEventType
       ((:TICKIT-KEYEV-KEY "TICKIT_KEYEV_KEY"))
       ((:TICKIT-KEYEV-TEXT "TICKIT_KEYEV_TEXT")))

(cenum TickitMouseEventType
       ((:TICKIT-MOUSEEV-PRESS "TICKIT_MOUSEEV_PRESS"))
       ((:TICKIT-MOUSEEV-DRAG "TICKIT_MOUSEEV_DRAG"))
       ((:TICKIT-MOUSEEV-RELEASE "TICKIT_MOUSEEV_RELEASE"))
       ((:TICKIT-MOUSEEV-WHEEL "TICKIT_MOUSEEV_WHEEL"))
       ((:TICKIT-MOUSEEV-DRAG-START "TICKIT_MOUSEEV_DRAG_START"))
       ((:TICKIT-MOUSEEV-DRAG-OUTSIDE "TICKIT_MOUSEEV_DRAG_OUTSIDE"))
       ((:TICKIT-MOUSEEV-DRAG-DROP "TICKIT_MOUSEEV_DRAG_DROP"))
       ((:TICKIT-MOUSEEV-DRAG-STOP "TICKIT_MOUSEEV_DRAG_STOP")))

(cenum TickitFocusEventType
       ((:TICKIT-FOCUSEV-IN "TICKIT_FOCUSEV_IN"))
       ((:TICKIT-FOCUSEV-OUT "TICKIT_FOCUSEV_OUT")))

(cenum TickitPenEvent
       ((:TICKIT-PEN-ON-DESTROY "TICKIT_PEN_ON_DESTROY"))
       ((:TICKIT-PEN-ON-CHANGE "TICKIT_PEN_ON_CHANGE")))

(cenum TickitTermEvent
       ((:TICKIT-TERM-ON-DESTROY "TICKIT_TERM_ON_DESTROY"))
       ((:TICKIT-TERM-ON-RESIZE "TICKIT_TERM_ON_RESIZE"))
       ((:TICKIT-TERM-ON-KEY "TICKIT_TERM_ON_KEY"))
       ((:TICKIT-TERM-ON-MOUSE "TICKIT_TERM_ON_MOUSE")))

(cenum TickitWindowEvent
       ((:TICKIT-WINDOW-ON-DESTROY "TICKIT_WINDOW_ON_DESTROY"))
       ((:TICKIT-WINDOW-ON-GEOMCHANGE "TICKIT_WINDOW_ON_GEOMCHANGE"))
       ((:TICKIT-WINDOW-ON-EXPOSE "TICKIT_WINDOW_ON_EXPOSE"))
       ((:TICKIT-WINDOW-ON-FOCUS "TICKIT_WINDOW_ON_FOCUS"))
       ((:TICKIT-WINDOW-ON-KEY "TICKIT_WINDOW_ON_KEY"))
       ((:TICKIT-WINDOW-ON-MOUSE "TICKIT_WINDOW_ON_MOUSE")))

;;; structs

(cstruct TickitRect "TickitRect"
         (top "top" :type :int)
         (left "left" :type :int)
         (lines "lines" :type :int)
         (cols "cols" :type :int))

(cstruct TickitStringPos "TickitStringPos"
         (bytes "bytes" :type size-t)
         (codepoints "codepoints" :type :int)
         (graphemes "graphemes" :type :int)
         (columns "columns" :type :int))

(cstruct TickitResizeEventInfo "TickitResizeEventInfo"
         (lines "lines" :type :int)
         (cols "cols" :type :int))

(cstruct TickitKeyEventInfo "TickitKeyEventInfo"
         (type "type" :type TickitKeyEventType)
         (mod "mod" :type :int)
         (str "str" :type :string))

(cstruct TickitMouseEventInfo "TickitMouseEventInfo"
         (type "type" :type TickitMouseEventType)
         (button "button" :type :int)
         (mod "mod" :type :int)
         (line "line" :type :int)
         (col "col" :type :int))

(cstruct TickitGeomchangeEventInfo "TickitGeomchangeEventInfo"
         (rect "rect" :type (:struct TickitRect))
         (oldrect "oldrect" :type (:struct TickitRect)))

(cstruct TickitExposeEventInfo "TickitExposeEventInfo"
         (rect "rect" :type (:struct TickitRect))
         (rb "rb" :type :pointer))

(cstruct TickitFocusEventInfo "TickitFocusEventInfo"
         (type "type" :type TickitFocusEventType)
         (window "win" :type :pointer))

(cstruct TickitPenRGB8 "TickitPenRGB8"
         (r "r" :type :uint8)
         (g "g" :type :uint8)
         (b "b" :type :uint8))

(cstruct TickitTermBuilder "struct TickitTermBuilder"
         (termtype "termtype" :type :pointer)
         (driver "driver" :type :pointer)
         (ti-hook "ti_hook" :type :pointer))

(cstruct TickitTerminfoHook "const struct TickitTerminfoHook"
         (getstr "getstr" :type :pointer)
         (data "data" :type :pointer))

(cstruct TickitRenderBufferLineMask "TickitRenderBufferLineMask"
         (north "north" :type :char)
         (south "south" :type :char)
         (east "east" :type :char)
         (west "west" :type :char))

(cstruct TickitRenderBufferSpanInfo "struct TickitRenderBufferSpanInfo"
         (activep "is_active" :type :bool)
         (columns "n_columns" :type :int)
         (text "text" :type :string)
         (length "len" :type size-t)
         (pen "pen" :type :pointer))
