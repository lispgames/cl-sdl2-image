(defpackage :sdl2-image.asdf
  (:use #:cl #:asdf))

(in-package :sdl2-image.asdf)

(defsystem :sdl2-image
  :description "Bindings for sdl2_image using autowrap"
  :author "Ryan Pavlik"
  :maintainer ("Michael Fiano <mail@michaelfiano.com>")
  :license "MIT"
  :version "1.0"

  :depends-on (:alexandria :defpackage-plus :cl-autowrap :sdl2 :trivial-garbage)
  :pathname "src"
  :serial t

  :components
  ((:file "package")
   (:file "library")
   (:file "autowrap")
   (:file "conditions")
   (:file "general")

   (:module autowrap-spec
    :pathname "spec"
    :components
    ((:static-file "SDL_image.h")))))
