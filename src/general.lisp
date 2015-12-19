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

(defun load-type-rw (filename file-type-hint)
  "Load a given file of a specified type and return an SDL surface object. The specified file type hint is a string representing one of the file types supported by sdl2 image. The supported types are documented in the official sdl2 image documentation. The original API had an argument indicating whether or not to automatically free the rwops pointer. However since an rwops structure is generated internally, this has been omitted and is automaticalaly freed"
  (let ((rwops-object (sdl2:rw-from-file (namestring filename) "rb")))
    (unwind-protect
         (autowrap:autocollect (ptr)
                               (check-null (img-load-typed-rw rwops-object 0 file-type-hint))
           (sdl-free-surface ptr))
      (sdl2:rw-close rwops-object))))
