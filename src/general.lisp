(in-package :sdl2-image)

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

(defmacro load-from-rw-wrapper (file-specifier load-macro)
  `(let ((rwops-object (sdl2:rw-from-file (namestring ,file-specifier) "rb")))
     (unwind-protect
          (autowrap:autocollect (ptr)
                                (check-null ,load-macro)
            (sdl-free-surface ptr))
       (sdl2:rw-close rwops-object))))

(defmacro define-loader-function (file-type)
  (let* ((wrapper-name (intern (string-upcase (format 'nil
                                                      "load-~a-rw"
                                                      file-type))))
         (original-name (intern (format 'nil
                                        "IMG-~a"
                                        (symbol-name wrapper-name)))))
    `(progn (defun ,wrapper-name (file-specifier)
              (load-from-rw-wrapper file-specifier
                                    (,original-name rwops-object)))
            (export ',wrapper-name))))

(defun load-type-rw (file-specifier file-type-hint)
  "Load a given file of a specified type and return an SDL surface object. The specified file type hint is a string representing one of the file types supported by sdl2 image. The supported types are documented in the official sdl2 image documentation. The original API had an argument indicating whether or not to automatically free the rwops pointer. However since an rwops structure is generated internally, this has been omitted and is automaticalaly freed"
  (load-from-rw-wrapper file-specifier
                        (img-load-typed-rw rwops-object
                                           0
                                           file-type-hint)))

(define-loader-function "bmp")
(define-loader-function "cur")
(define-loader-function "gif")
(define-loader-function "ico")
(define-loader-function "jpg")
(define-loader-function "lbm")
(define-loader-function "pcx")
(define-loader-function "png")
(define-loader-function "tga")
(define-loader-function "tif")
(define-loader-function "xcf")
(define-loader-function "xpm")
(define-loader-function "xv")
