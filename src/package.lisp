(in-package defpackage+-user-1)

(defpackage+ :sdl2-image
  (:use #:cl #:alexandria #:autowrap.minimal #:plus-c #:sdl2-ffi.functions)
  (:export-only

   ;; Conditions
   #:sdl-image-error

   ;; General
   #:linked-version
   #:init #:quit #:load-image
   ))

(in-package :sdl2-image)

 ;; Variables

