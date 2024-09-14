(in-package :sdl2-image)

(cffi:define-foreign-library libsdl2-image
  ;; I have no idea if this is the correct framework, file an issue
  ;; and let me know!
  (:darwin (:or (:framework "SDL2_image") (:default "libSDL2_image")))
  (:unix (:or "libSDL2_image-2.0.so.0" "libSDL2_image" "libSDL2_image.so.1.1"))
  (:windows "SDL2_image.dll")
  (t (:default "libSDL2_image")))

(cffi:use-foreign-library libsdl2-image)
