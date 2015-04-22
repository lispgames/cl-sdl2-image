# cl-sdl2-image

This is a (currently) brief but usable wrap for SDL2_image.  Currently, this exports the following:

* `(sdl2-image:init LIST-OF-FORMATS)`: Initialize and load `LIST-OF-FORMATS`, which should be a list of any combination of the keyword `:png`, `:jpg`, and `:tif`.  This calls `IMG_Init()`.
* `(sdl2-image:quit)`: This calls `IMG_Quit()`.
* `(sdl2-image:load-image FILENAME)`: This calls `IMG_Load()` on the filename, and returns an `SDL-SURFACE`.

These functions act more or less like their wrapped equivalents; see the SDL_image 2.0 documentation for details.

## Issues

If you require further functions, please file an issue, **pull request**, or inquire in `#lispgames` on freenode.

If you can't load `libSDL2_image`, please ensure that you have SDL_image 2.0 installed, and not just 1.2.  Earlier versions will not work correctly.  In the case of Windows, please ensure this, along with SDL2's DLLs, are installed in the same directory as your Lisp `.exe`.

If you are sure all of this is correct, and it still will not load, please [file an issue](https://github.com/lispgames/cl-sdl2-image/issues/new) and specify:

* Your platform and architecture
* Your lisp
* The absolute path to your installed `.so`, `.dll`, or the appropriate OSX framework
