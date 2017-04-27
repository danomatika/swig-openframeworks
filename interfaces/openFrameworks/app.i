// app folder bindings
// 2017 Dan Wilcox <danomatika@gmail.com>

// ----- ofWindowSettings.h -----

// not needed

// ----- ofMainLoop.h -----

// not needed

// ----- ofAppNoWindow.h -----

// not needed

// ----- ofAppGlutWindow.h -----

// not needed

// ----- ofAppGLFWWindow.h -----

// not needed

// ----- ofAppBaseWindow.h -----

// not needed

// ----- ofAppRunner.h -----

// DIFF: ofAppRunner.h:
// DIFF:   ofInit, ofSetupOpenGL, & ofCreateWindow not applicable in target language
%ignore ofInit;
%ignore ofSetupOpenGL;
%ignore ofCreateWindow;

// DIFF:   get/set main loop not applicable to target language
%ignore ofGetMainLoop;
%ignore ofSetMainLoop;

// DIFF:   run app & main loop not applicable to target language
%ignore noopDeleter;
%ignore ofRunApp;
%ignore ofRunMainLoop;

// DIFF:   ofSetAppPtr not applicable in a target language
%ignore ofSetAppPtr;

// DIFF:   ofGetWindowPtr not applicable in a target language
%ignore ofGetWindowPtr;

// DIFF:   get/set current renderer not applicable to target language
%ignore ofSetCurrentRenderer;
%ignore ofGetCurrentRenderer;

// DIFF:   ignoring api-specific window objects: display, window, context, surface
%ignore ofGetX11Display;
%ignore ofGetX11Window;
%ignore ofGetGLXContext;
%ignore ofGetEGLDisplay;
%ignore ofGetEGLContext;
%ignore ofGetEGLSurface;
%ignore ofGetNSGLContext;
%ignore ofGetCocoaWindow;
%ignore ofGetWGLContext;
%ignore ofGetWin32Window;

%include "app/ofAppRunner.h"

// ----- ofBaseApp.h -----

// not needed
