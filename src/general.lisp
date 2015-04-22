(in-package sdl2-image)

(defun linked-version ()
  (c-let ((version sdl2-ffi:sdl-version :from (img-linked-version)))
    (values (version :major) (version :minor) (version :patch))))

(autowrap:define-bitmask-from-enum (img-initflags sdl2-ffi:img-init-flags))

(defun init (flags)
  (let ((flags (mask-apply 'img-initflags flags)))
    (check= flags (img-init flags))))

(defun quit () (img-quit))

(defun load-image (filename)
  (autocollect (ptr)
      (check-null (img-load (namestring (merge-pathnames filename))))
    (sdl-free-surface ptr)))

