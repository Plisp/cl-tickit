# Overview

`cl-tickit` is a simple cffi wrapper over `libtickit` (by 'Leonerd', available at https://launchpad.net/libtickit), a library that provides a full toolkit for developing interactive terminal applications. Using this library, applications can:

* Render output content and react to input events independently in any window region
* Use fully Unicode-aware string content, including non-BMP, fullwidth and combining characters
* Draw line-art using Unicode box-drawing characters in a variety of styles
* Operate synchronously or asynchronously via file descriptors, or abstractly via byte buffers
* Recognise arbitrary keyboard input, including modifiers
* Make use of multiple terminals, if available, from a single application
* Recognise mouse gestures including mouse wheel and recognition of position reporting greater than 224 columns* on terminals that support it
* Use 24-bit colors (truecolor) on terminals that support it, eliminating the need for palettes

Sometime in the future:

* Embed this functionality in a user-provided event loop (once API becomes stable)
* Provide your own virtual terminal ('driver') implementation
* use a high level lisp wrapper for common tasks
