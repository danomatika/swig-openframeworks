/*
	SWIG (http://www.swig.org) interface wrapper for the OpenFrameworks core API

	(Lua) Creates an "of" module and renames functions, classes, constants, & enums

		* function: ofBackground -> of.background
		* class: ofColor -> of.Color
		* constant: OF_LOG_VERBOSE -> of.LOG_VERBOSE
		* enum: ofShader::POSITION_ATTRIBUTE -> of.Shader.POSITION_ATTRIBUTE

	(Python) Creates an "openframeworks" module
	
	Deprecations are ignored (aka not wrapped)

	2014 Dan Wilcox <danomatika@gmail.com>
*/

// workaround when compiling Python in MinGW
#ifdef SWIGPYTHON
%begin %{
	#if defined( __WIN32__ ) || defined( _WIN32 )
		#include <cmath>
	#endif
%}
#endif

%module MODULE_NAME
%{
	#include "ofMain.h"
	#undef check
%}

%include <attribute.i>
%include <typemaps.i>

// custom attribute wrapper for nested union var access
%define %attributeVar(Class, AttributeType, AttributeName, GetVar, SetVar...)
	#if #SetVar != ""
		%attribute_custom(%arg(Class), %arg(AttributeType), AttributeName, GetVar, SetVar, self_->GetVar, self_->SetVar = val_)
	#else
		%attribute_readonly(%arg(Class), %arg(AttributeType), AttributeName, GetVar, self_->GetVar)
	#endif
%enddef

// ----- C++ -----

// SWIG doesn't understand C++ streams
%ignore operator <<;
%ignore operator >>;

// expanded primitives
%typedef unsigned int size_t;
%typedef long long int64_t;
%typedef unsigned long long uint64_t;

// ----- STL types -----

%include <stl.i>
%include <std_string.i>
%include <std_vector.i>

// needed for functions and return types
namespace std {
	%template(IntVector) std::vector<int>;
	%template(FloatVector) std::vector<float>;
	%template(StringVector) std::vector<std::string>;
	%template(UCharVector) std::vector<unsigned char>;
	%template(VideoDeviceVector) std::vector<ofVideoDevice>;
	%template(TextureVector) std::vector<ofTexture>;
};

// ----- Renaming -----

#ifdef OF_SWIG_RENAME

	// strip "of" prefix from classes
	%rename("%(strip:[of])s", %$isclass) "";

	// strip "of" prefix from global functions & make first char lowercase
	%rename("%(regex:/of(.*)/\\l\\1/)s", %$isfunction) "";

	// strip "OF_" from constants & enums
	%rename("%(strip:[OF_])s", %$isconstant) "";
	%rename("%(strip:[OF_])s", %$isenumitem) "";

#endif

// ----- Deprecated ------

#ifndef OF_SWIG_DEPRECATED
	%include "interfaces/deprecated.i"
#endif

// ----- Python -----

// overloading operators
#ifdef SWIGPYTHON
	%rename(__getitem__) *::operator[];
	%rename(__mul__) *::operator*;
	%rename(__div__) *::operator/;
	%rename(__add__) *::operator+;
	%rename(__sub__) *::operator-;
#endif

////////////////////////////////////////////////////////////////////////////////
// ----- BINDINGS --------------------------------------------------------------
//
// Look for the follow notes:
//     TODO: something that might need to be updated or fixed in the future
//     DIFF: an important difference as compared to the OF C++ API
//
// Make sure to %rename & %ignore *before* %including a header.
//
// The order of class declarations is important! This is why a number of
// classes are %included at the beginning before ofBaseTypes.h.
//
// If a header forward declares a class like (AnotherClass.h):
//
//     class SomeClass;
//     class AnotherClass {
//     ...
//
// and this header is %included before the actual class implementation
// (SomeClass.h), SWIG will wrap the empty declaration and *not* the actual
// class! This basically allows you to create the class in the bound language,
// but it does nothing and has no attributes or functions. Bummer.
//
// What needs to be done is either %include SomeClass.h before AnotherClass.h
//
//    %include "SomeClass.h"
//    %include "AnotherClass.h"
//
// or make a forward declaration before %including SomeClass.h:
//
//    class SomeClass {};
//    %include AnotherClass.h
//
// This forward declaration is then overridden by the actual implementation after
// %include "SomeClass.h" later on.

// ignore everything in the private namespace
%ignore of::priv;

// ----- ofConstants.h -----

// GL types used as OF arguments, etc so SWIG needs to know about them
typedef int GLint;
typedef unsigned int GLenum;
typedef unsigned int GLuint;
typedef float GLfloat;

%include "utils/ofConstants.h"

// ----- ofFbo.h -----

// need to forward declare these for ofFbo
%ignore ofBaseDraws;
class ofBaseDraws {};

%ignore ofBaseHasTexture;
class ofBaseHasTexture {};

%ignore ofBaseHasPixels;
class ofBaseHasPixels {};

// DIFF: ofFbo.h: ignoring const & copy constructor in favor of && constructor
%ignore ofFbo::ofFbo(ofFbo const &);

// DIFF: ofFbo.h: setUseTexture & isUsingTexture are "irrelevant", so ignoring
%ignore ofFbo::setUseTexture;
%ignore ofFbo::isUsingTexture;

// DIFF: ofFbo.h: ignoring setActiveDrawBufers() due to std::vector
%ignore setActiveDrawBuffers(const vector<int>& i);

// DIFF: ofFbo.h: ignoring nested structs, not supported by SWIG
%ignore ofFbo::Settings;

// DIFF: (Lua) ofFbo.h: beginFbo() & endFbo() since "end" is a Lua keyword
#ifdef SWIGLUA
	%rename(beginFbo) ofFbo::begin;
	%rename(endFbo) ofFbo::end;
#endif

%include "gl/ofFbo.h"

// ----- ofTexture.h -----

// DIFF: ofTexture.h: ignoring const & copy constructor in favor of && constructor
%ignore ofTexture::ofTexture(ofTexture const &);

%include "gl/ofTexture.h"

// ----- ofImage.h -----

// forward declare needed types
%ignore ofBaseImage_;
template<typename T> class ofBaseImage_ {};

// forward declare base template classes
%ignore ofBaseImage;
%ignore ofBaseFloatImage;
%ignore ofBaseShortImage;
#ifdef OF_SWIG_RENAME
	%template(BaseImage) ofBaseImage_<unsigned char>;
	%template(BaseFloatImage) ofBaseImage_<float>;
	%template(BaseShortImage) ofBaseImage_<unsigned short>;
#else
	%template(ofBaseImage) ofBaseImage_<unsigned char>;
	%template(ofBaseFloatImage) ofBaseImage_<float>;
	%template(ofBaseShortImage) ofBaseImage_<unsigned short>;
#endif

// DIFF: ofImage.h: ignore global helper functions
%ignore ofLoadImage;
%ignore ofSaveImage;
%ignore ofCloseFreeImage;

// DIFF: ofImage.h: ignoring ofPixels operator
%ignore ofImage_::operator ofPixels_<PixelType>&();

// DIFF: ofImage.h: ignoring const & copy constructor in favor of && constructor
%ignore ofImage_(const ofImage_<PixelType>&);

%extend ofImage_ {
        bool load(const string& fileName, const ofImageLoadSettings &settings = ofImageLoadSettings()) {
                std::filesystem::path p = std::filesystem::path(fileName);
                return $self->load(p, settings);
        }
}

%include "graphics/ofImage.h"

// handle template implementations
#ifdef OF_SWIG_RENAME
	%template(Image) ofImage_<unsigned char>;
	%template(FloatImage) ofImage_<float>;
	%template(ShortImage) ofImage_<unsigned short>;
#else
	%template(ofImage) ofImage_<unsigned char>;
	%template(ofFloatImage) ofImage_<float>;
	%template(ofShortImage) ofImage_<unsigned short>;
#endif

// the following GL define values are pulled from glew.h & converted to base 10:

// DIFF: defined GLint texture types: OF_TEXTURE_LUMINANCE, OF_TEXTURE_RGB, & OF_TEXTURE_RGBA
#define OF_TEXTURE_LUMINANCE 6409    // 0x1909
#define OF_TEXTURE_RGB 6407          // 0x1907
#define OF_TEXTURE_RGBA 6408         // 0x1908

// DIFF: defined GLenum mipmap filter types: OF_NEAREST, OF_LINEAR
#define OF_NEAREST 9728       // 0x2600
#define OF_LINEAR 9729        // 0x2601

// DIFF: defined GLenum shader types: OF_FRAGMENT_SHADER, OF_VERTEX_SHADER
#define OF_FRAGMENT_SHADER 35632     // 0x8B30
#define OF_VERTEX_SHADER 35633       // 0x8B31

// DIFF: defined GLfloat texture wrap defines: OF_CLAMP_TO_EDGE, OF_CLAMP_TO_BORDER, OF_REPEAT, OF_MIRRORED_REPEAT
// DIFF:
#define OF_CLAMP_TO_EDGE 33071       // 0x812F
#ifndef TARGET_OPENGLES
	#define OF_CLAMP_TO_BORDER 33069 // 0x812D
#endif
#define OF_REPEAT 10497              // 0x2901
#define OF_MIRRORED_REPEAT 33648     // 0x8370

// ----- ofBaseTypes.h -----

// DIFF: ofBaseTypes.h: ignore all abstract and base types
%ignore ofAbstractParameter;
%ignore ofBaseDraws;
%ignore ofBaseUpdates;
%ignore ofBaseHasTexture;
%ignore ofBaseHasTexturePlanes;

%ignore ofAbstractHasPixels;
%ignore ofBaseHasPixels_;
%ignore ofBaseHasPixels;
%ignore ofBaseHasFloatPixels;
%ignore ofBaseHasShortPixels;

%ignore ofAbstractImage;
%ignore ofBaseImage_;
%ignore ofBaseImage;
%ignore ofBaseFloatImage;
%ignore ofBaseShortImage;

%ignore ofBaseSoundInput;
%ignore ofBaseSoundOutput;

%ignore ofBaseVideo;
%ignore ofBaseVideoDraws;
%ignore ofBaseVideoGrabber;
%ignore ofBaseVideoPlayer;

%ignore ofBaseRenderer;
%ignore ofBaseGLRenderer;
#ifdef SWIGLUA // ignore these to silence Warning 314
	%ignore ofBaseGLRenderer::begin;
	%ignore ofBaseGLRenderer::end;
#endif

%ignore ofBaseSerializer;
%ignore ofBaseFileSerializer;
%ignore ofBaseURLFileLoader;
%ignore ofBaseMaterial;
#ifdef SWIGLUA // ignore these to silence Warning 314
	%ignore ofBaseMaterial::begin;
	%ignore ofBaseMaterial::end;
#endif

// still include header for derived classes
%include "types/ofBaseTypes.h"

// ----- 3D --------------------------------------------------------------------

// ----- ofNode.h -----

// DIFF: ofNode.h: ignoring const & copy constructor in favor of && constructor
%ignore ofNode::ofNode(ofNode const &);

// process ofNode first since it's a base class
%include "3d/ofNode.h"

// ----- of3dUtils.h -----

%include "3d/of3dUtils.h"

// ----- ofCamera.h -----

// DIFF: (Lua) ofCamera.h: beginCamera() & endCamera() since "end" is a Lua keyword
#ifdef SWIGLUA
	%rename(beginCamera) ofCamera::begin;
	%rename(endCamera) ofCamera::end;
#endif

%include "3d/ofCamera.h"

// ----- ofEasyCam.h -----

%include "3d/ofEasyCam.h"

// ----- ofMesh.h -----

// tesselator index
#ifdef TARGET_OPENGLES
	%typedef unsigned short TESSindex;
#else
	%typedef unsigned int TESSindex;
#endif

// add ofMesh virtual destructor
%extend ofMesh {
	virtual ~ofMesh() {
		$self->clear();
		delete $self;
	}
};

%include "3d/ofMesh.h"

// ----- of3dPrimitives.h -----

// DIFF: of3dPrimitives.h: ignore of3dPrimitive base class
%ignore of3dPrimitive;
class of3dPrimitive {};

%include "3d/of3dPrimitives.h"

// ----- APP -------------------------------------------------------------------

// ----- ofAppRunner.h -----

// DIFF: ofAppRunner.h: ofInit, ofSetupOpenGL, & ofCreateWindow not applicable in target language
%ignore ofInit;
%ignore ofSetupOpenGL;
%ignore ofCreateWindow;

// DIFF: ofAppRunner.h: get/set main loop not applicable to target language
%ignore ofGetMainLoop;
%ignore ofSetMainLoop;

// DIFF: ofAppRunner.h: run app & main loop not applicable to target language
%ignore noopDeleter;
%ignore ofRunApp;
%ignore ofRunMainLoop;

// DIFF: ofAppRunner.h: ofSetAppPtr not applicable in a target language
%ignore ofSetAppPtr;

// DIFF: ofAppRunner.h: ofGetWindowPtr not applicable in a target language
%ignore ofGetWindowPtr;

// DIFF: ofAppRunner.h: get/set current renderer not applicable to target language
%ignore ofSetCurrentRenderer;
%ignore ofGetCurrentRenderer;

// DIFF: ofAppRunner.h: ignoring api-specific window objects: display, window, context, surface
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

// ----- not needed -----

// ofWindowSettings.h, ofMainLoop.h, ofAppNoWindow.h, ofAppGlutWindow.h,
// ofAppGLFWWindow.h, ofAppBaseWindow.h, ofBaseApp.h

// ----- COMMUNICATION ---------------------------------------------------------

// conditional compilation for iOS and Android
#if !defined(TARGET_IOS) && !defined(TARGET_ANDROID)

// ----- ofArduino.h -----

// DIFF: ofArduino.h: ignoring functions which return list points
%ignore ofArduino::getDigitalHistory(int);
%ignore ofArduino::getAnalogHistory(int);
%ignore ofArduino::getSysExHistory();
%ignore ofArduino::getStringHistory();

%include "communication/ofArduino.h"

// ----- ofSerial.h -----

// DIFF: ofSerial.h: pass binary data to ofSerial as full char strings
// pass binary data & byte length as a single argument for ofBuffer
#if defined(SWIGLUA)

	// args from lang in to C++ function
	%typemap(in) (unsigned char *STRING, int LENGTH) {
		$2 = (int)lua_tonumber(L, $input+1);
		$1 = (unsigned char *)lua_tolstring(L, $input, (size_t *)&$2);
	}

#endif
%apply(unsigned char *STRING, int LENGTH) {(unsigned char * buffer, int length)};

%include "communication/ofSerial.h"

#endif // ! iOS and Android

// ----- GL --------------------------------------------------------------------

// ----- ofBufferObject.h -----

%include "gl/ofBufferObject.h"

// ----- ofLight.h -----

// DIFF: ofLight.h: ignoring nested struct, not supported by SWIG
%ignore ofLight::Data;

%include "gl/ofLight.h"

// ----- ofMaterial.h -----

// DIFF: ofMaterial.h: ignoring nested struct, not supported by SWIG
%ignore ofMaterial::Data;
%ignore ofMaterial::getData() const;

// DIFF: (Lua) ofMaterial.h: beginMaterial() & endMaterial() since "end" is a Lua keyword
#ifdef SWIGLUA
	%rename(beginMaterial) ofMaterial::begin;
	%rename(endMaterial) ofMaterial::end;
#endif

%include "gl/ofMaterial.h"

// ----- ofShader.h -----

// DIFF: ofShader.h: ignoring const & copy constructor in favor of && constructor
%ignore ofShader::ofShader(ofShader const &);

// DIFF: (Lua) ofShader.h: beginShader() & endShader() since "end" is a Lua keyword
#ifdef SWIGLUA
	%rename(beginShader) ofShader::begin;
	%rename(endShader) ofShader::end;
#endif

%include "gl/ofShader.h"

// ----- ofVbo.h -----

%include "gl/ofVbo.h"

// ----- ofVboMesh.h -----

%include "gl/ofVboMesh.h"

// ----- not needed -----

// ofGLProgrammableRenderer.h, ofGLRenderer.h, ofGLUtils.h

// ----- GRAPHICS --------------------------------------------------------------

// ----- ofPixels.h -----

// DIFF: ofImage.h: ignoring const & copy constructor in favor of && constructor
%ignore ofPixels_(const ofPixels_<PixelType> &);

// DIFF: ofPixels.h: fixed ambiguous ofPixels function overloads since enums = int in SWIG
// DIFF:             by renaming to allocatePixelFormat, allocateimageType, & setFromPixelsImageType
%rename(allocatePixelFormat) ofPixels_<unsigned char>::allocate(size_t, size_t, ofPixelFormat);
%rename(allocateImageType) ofPixels_<unsigned char>::allocate(size_t, size_t, ofImageType);
%rename(setFromPixelsImageType) ofPixels_<unsigned char>::setFromPixels(unsigned char const *, size_t, size_t, ofImageType);

%rename(allocatePixelFormat) ofPixels_<float>::allocate(size_t, size_t, ofPixelFormat);
%rename(allocateImageType) ofPixels_<float>::allocate(size_t, size_t, ofImageType);
%rename(setFromPixelsImageType) ofPixels_<float>::setFromPixels(float const *, size_t, size_t, ofImageType);

%rename(allocatePixelFormat) ofPixels_<unsigned short>::allocate(size_t, size_t, ofPixelFormat);
%rename(allocateImageType) ofPixels_<unsigned short>::allocate(size_t, size_t, ofImageType);
%rename(setFromPixelsImageType) ofPixels_<unsigned short>::setFromPixels(unsigned short const *, size_t, size_t, ofImageType);

// DIFF: ofPixels.h: ignore overloaded setFromPixels, setFromExternalPixels, & setFromAlignedPixels
//                   w/ channels argument, use ofPixelType overloaded functions instead
%ignore ofPixels_<unsigned char>::setFromPixels(unsigned char const *, size_t, size_t, size_t);
%ignore ofPixels_<float>::setFromPixels(float const *, size_t, size_t, size_t);
%ignore ofPixels_<unsigned short>::setFromPixels(unsigned short const *, size_t, size_t, size_t);

%ignore ofPixels_<unsigned char>::setFromExternalPixels(unsigned char *, size_t, size_t, size_t);
%ignore ofPixels_<float>::setFromExternalPixels(float *, size_t, size_t, size_t);
%ignore ofPixels_<unsigned short>::setFromExternalPixels(unsigned short *, size_t, size_t, size_t);

%ignore ofPixels_<unsigned char>::setFromAlignedPixels(const unsigned char *, size_t, size_t, size_t, size_t);
%ignore ofPixels_<float>::setFromAlignedPixels(const float *, size_t, size_t, size_t, size_t);
%ignore ofPixels_<unsigned short>::setFromAlignedPixels(const unsigned short *, size_t, size_t, size_t, size_t);

// DIFF: ofPixels.h: ignore setFromAlignedPixels with vector arguments
%ignore ofPixels_<unsigned char>::setFromAlignedPixels(const unsigned char *, size_t, size_t, ofPixelFormat, std::vector<size_t>);
%ignore ofPixels_<float>::setFromAlignedPixels(const float *, size_t, size_t, ofPixelFormat, std::vector<size_t>);
%ignore ofPixels_<unsigned short>::setFromAlignedPixels(const unsigned short *, size_t, size_t, ofPixelFormat, std::vector<size_t>);

%ignore ofPixels_<unsigned char>::setFromAlignedPixels(const unsigned char *, size_t, size_t, ofPixelFormat, std::vector<int>);
%ignore ofPixels_<float>::setFromAlignedPixels(const float *, size_t, size_t, ofPixelFormat, std::vector<int>);
%ignore ofPixels_<unsigned short>::setFromAlignedPixels(const unsigned short *, size_t, size_t, ofPixelFormat, std::vector<int>);

// DIFF: ofPixels.h: ignoring static functions
%ignore ofPixels_::pixelBitsFromPixelFormat(ofPixelFormat);
%ignore ofPixels_::bytesFromPixelFormat(size_t, size_t, ofPixelFormat);

// DIFF: ofPixels.h: ignoring nested structs, not supported by SWIG
%ignore ofPixels_::ConstPixel;
%ignore ofPixels_::Pixel;
%ignore ofPixels_::Pixels;
%ignore ofPixels_::Line;
%ignore ofPixels_::Lines;
%ignore ofPixels_::ConstPixels;
%ignore ofPixels_::ConstLine;
%ignore ofPixels_::ConstLines;

// DIFF: ofPixels.h: ignoring iterators
%ignore ofPixels_::begin;
%ignore ofPixels_<unsigned char>::end;
%ignore ofPixels_<float>::end;
%ignore ofPixels_<unsigned short>::end;
%ignore ofPixels_::rbegin;
%ignore ofPixels_::rend;
%ignore ofPixels_::begin const;
%ignore ofPixels_::end const;
%ignore ofPixels_::rbegin const;
%ignore ofPixels_::rend const;
%ignore ofPixels_::getLine(size_t);
%ignore ofPixels_::getLines();
%ignore ofPixels_::getLines(size_t, size_t);
%ignore ofPixels_::getPixelsIter();
%ignore ofPixels_::getConstLine(size_t) const;
%ignore ofPixels_::getConstLines() const;
%ignore ofPixels_::getConstLines(size_t, size_t) const;
%ignore ofPixels_::getConstPixelsIter() const;

// ignore end keywords, even though they are within nested classes which are
// effectively ignored by SWIG
#ifdef SWIGLUA
	%ignore ofPixels_::Line::end;
	%ignore ofPixels_::Lines::end;
	%ignore ofPixels_::ConstPixels::end;
	%ignore ofPixels_::ConstLine::end;
	%ignore ofPixels_::ConstLines::end;
	%ignore ofPixels_::Pixels::end;
#endif

%include "graphics/ofPixels.h"

// tell SWIG about template classes
#ifdef OF_SWIG_RENAME
	%template(Pixels) ofPixels_<unsigned char>;
	%template(FloatPixels) ofPixels_<float>;
	%template(ShortPixels) ofPixels_<unsigned short>;
#else
	%template(ofPixels) ofPixels_<unsigned char>;
	%template(ofFloatPixels) ofPixels_<float>;
	%template(ofShortPixels) ofPixels_<unsigned short>;
#endif

// ----- ofPath.h -----

// DIFF: ofPath.h: ignoring nested struct, not supported by SWIG
%ignore ofPath::Command;

%include "graphics/ofPath.h"

%template(PolylineVector) std::vector<ofPolyline>;

// ----- ofPolyline.h -----

// ignored due to default variable overload
%ignore ofPolyline::arc(float, float, float, float, float, float, float);
%ignore ofPolyline::arcNegative(float, float, float, float, float, float, float);

// DIFF: ofPolyline.h: ignoring iterators
%ignore ofPolyline::begin;
%ignore ofPolyline::end;
%ignore ofPolyline::rbegin;
%ignore ofPolyline::rend;

%include "graphics/ofPolyline.h"

#ifdef OF_SWIG_RENAME
        %template(Polyline) ofPolyline_<ofDefaultVertexType>;
#else
        %template(ofPolyline) ofPolyline_<ofDefaultVertexType>;
#endif

// ----- ofGraphics.h -----

// no PDF or SVG export support on mobile
#if defined(TARGET_IOS) || defined(TARGET_ANDROID)
	%ignore ofBeginSaveScreenAsPDF;
	%ignore ofEndSaveScreenAsPDF();
	%ignore ofBeginSaveScreenAsSVG;
	%ignore ofEndSaveScreenAsSVG();
#endif

// DIFF: ofGraphics.h: ignoring foDrawBitmapString template functions in favor
// of string versions target languages can handle the string conversions
%ignore ofDrawBitmapString(const T &, const ofPoint&);
%ignore ofDrawBitmapString(const T &, float, float);
%ignore ofDrawBitmapString(const T &, float, float, float);

// manually define string functions here otherwise they get redefined by SWIG & then ignored
void ofDrawBitmapString(const string & textString, float x, float y);
void ofDrawBitmapString(const string & textString, const ofPoint & p);
void ofDrawBitmapString(const string & textString, float x, float y, float z);

%include "graphics/ofGraphics.h"

// ----- of3dGraphics.h -----

// ignore base classes
%ignore of3dGraphics;

%include "graphics/of3dGraphics.h"

// ----- ofTrueTypeFont.h -----

// ignore internal font struct
%ignore charProps;

// DIFF: ofTrueTypeFont.h: ignoring ofTrueTypeShutdown() & ofExitCallback() friend
%ignore ofTrueTypeShutdown;
%ignore ofExitCallback();

// DIFF: ofTrueTypeFont.h: ignoring const & copy constructor in favor of && constructor
%ignore ofTrueTypeFont::ofTrueTypeFont(ofTrueTypeFont const &);

// string static const strings
%rename(TTF_SANS) OF_TTF_SANS;
%rename(TTF_SERIF) OF_TTF_SERIF;
%rename(TTF_MONO) OF_TTF_MONO;

%extend ofTrueTypeFont {
        bool load(const string& filename, int fontsize, bool _bAntiAliased=true, bool _bFullCharacterSet=true, bool makeContours=false, float simplifyAmt=0.3f, int dpi=0) {
                std::filesystem::path p = std::filesystem::path(filename);
                return $self->load(p, fontsize, _bAntiAliased, _bFullCharacterSet, makeContours, simplifyAmt, dpi);
        }
}

%include "graphics/ofTrueTypeFont.h"

// ----- not needed -----

// ofRendererCollection.h, ofCairoRenderer.h, ofBitmapFont.h, ofTessellator.h

// ----- SOUND -----------------------------------------------------------------

// ----- ofSoundStream.h -----

// ignore overloaded functions
%ignore ofSoundStream::setInput(ofBaseSoundInput &soundInput);
%ignore ofSoundStream::setOutput(ofBaseSoundOutput &soundOutput);

%include "sound/ofSoundStream.h"

// ----- ofSoundPlayer.h -----

%ignore ofBaseSoundPlayer;
class ofBaseSoundPlayer {};

// DIFF: ofSoundPlayer.h: warnings say "FIX THIS SHIT", so leaving out fmod global functions
%ignore ofSoundStopAll;
%ignore ofSoundShutdown;
%ignore ofSoundSetVolume;
%ignore ofSoundUpdate;
%ignore ofSoundGetSpectrum;

%include "sound/ofSoundPlayer.h"

// ----- not needed -----

// ofBaseSoundPlayer.h, ofBaseSoundStream.h, ofFmodSoundPlayer.h,
// ofOpenALSoundPlayer.h, ofRtAudioSoundStream.h, ofSoundBuffer.h, ofSoundUtils.h

// ----- MATH ------------------------------------------------------------------

// ----- ofMatrix3x3.h -----

%include "math/ofMatrix3x3.h"

%extend ofMatrix3x3 {
	const char* __str__() {
		stringstream str;
		str << (*$self);
		return str.str().c_str();
	}
};

// ----- ofMatrix4x4.h -----

// DIFF: ofMatrix4x4.h: ignoring operator(size_t,size_t) const overload
%ignore ofMatrix4x4::operator()(std::size_t, std::size_t) const;

%include "math/ofMatrix4x4.h"

%extend ofMatrix4x4 {
	const char* __str__() {
		stringstream str;
		str << (*$self);
		return str.str().c_str();
	}
};

// ----- ofQuaternion.h -----

// silence warning as SWIG ignores these anyway
// since it uses the non-const versions
%ignore ofQuaternion::x() const;
%ignore ofQuaternion::y() const;
%ignore ofQuaternion::z() const;
%ignore ofQuaternion::w() const;

%include "math/ofQuaternion.h"

%extend ofQuaternion {
	const char* __str__() {
		stringstream str;
		str << (*$self);
		return str.str().c_str();
	}
};

// ----- ofVecs -----

%include "math/ofVec2f.h"

%extend ofVec2f {
	const char* __str__() {
		stringstream str;
		str << (*$self);
		return str.str().c_str();
	}
};

%include "math/ofVec3f.h"

%extend ofVec3f {
	const char* __str__() {
		stringstream str;
		str << (*$self);
		return str.str().c_str();
	}
};

%include "math/ofVec4f.h"

%extend ofVec4f {
	const char* __str__() {
		stringstream str;
		str << (*$self);
		return str.str().c_str();
	}
};

// ----- ofMath.h -----

// ignore the template functions
%ignore ofInterpolateCosine;
%ignore ofInterpolateCubic;
%ignore ofInterpolateCatmullRom;
%ignore ofInterpolateHermite;

// declare float functions
ofInterpolateCosine(float y1, float y2, float pct);
ofInterpolateCubic(float y1, float y2, float pct);
ofInterpolateCatmullRom(float y1, float y2, float pct);
ofInterpolateHermite(float y1, float y2, float pct);

%include "math/ofMath.h"

// tell SWIG about template functions
#ifdef OF_SWIG_RENAME
	%template(interpolateCosine) ofInterpolateCosine<float>;
	%template(interpolateCubic) ofInterpolateCubic<float>;
	%template(interpolateCatmullRom) ofInterpolateCatmullRom<float>;
	%template(interpolateHermite) ofInterpolateHermite<float>;
#else
	%template(ofInterpolateCosine) ofInterpolateCosine<float>;
	%template(ofInterpolateCubic) ofInterpolateCubic<float>;
	%template(ofInterpolateCatmullRom) ofInterpolateCatmullRom<float>;
	%template(ofInterpolateHermite) ofInterpolateHermite<float>;
#endif

// ----- not needed -----

// ofVectorMath.h

// ----- EVENTS ----------------------------------------------------------------

// ----- ofEvents.h -----

// DIFF: ofEvents.h: ignore event classes, event args, and registration functions
%ignore ofEventArgs;
%ignore ofEntryEventArgs;
%ignore ofKeyEventArgs;
%ignore ofMouseEventArgs;
// need ofTouchEventArgs for touch callbacks
%ignore ofAudioEventArgs;
%ignore ofResizeEventArgs;
%ignore ofMessage;

// DIFF: ofEvents.h: ignore ofSendMessage() with ofMessage in favor of std::string
%ignore ofSendMessage(ofMessage msg);

%ignore ofCoreEvents;
%ignore ofEvents;

%ignore ofRegisterMouseEvents;
%ignore ofRegisterKeyEvents;
%ignore ofRegisterTouchEvents;
%ignore ofRegisterGetMessages;
%ignore ofRegisterDragEvents;
%ignore ofUnregisterMouseEvents;
%ignore ofUnregisterKeyEvents;
%ignore ofUnregisterTouchEvents;
%ignore ofUnregisterGetMessages;
%ignore ofUnregisterDragEvents;

%ignore ofNotifySetup;
%ignore ofNotifyUpdate;
%ignore ofNotifyDraw;
%ignore ofNotifyKeyPressed;
%ignore ofNotifyKeyReleased;
%ignore ofNotifyKeyEvent;
%ignore ofNotifyMousePressed;
%ignore ofNotifyMouseReleased;
%ignore ofNotifyMouseDragged;
%ignore ofNotifyMouseMoved;
%ignore ofNotifyMouseEvent;
%ignore ofNotifyExit;
%ignore ofNotifyWindowResized;
%ignore ofNotifyWindowEntry;
%ignore ofNotifyDragEvent;

%include "events/ofEvents.h"

// ----- not needed -----

// ofEventUtils.h

// ----- TYPES -----------------------------------------------------------------

// ----- ofColor.h -----

// TODO: ofColor.h: SWIG Warning 312 ignores nested union that provides r, g, b, & a access
#pragma SWIG nowarn=312

%include "types/ofColor.h"

// reenable
#pragma SWIG nowarn=312

// DIFF: ofColor.h: added ofColor_ pixel channel getters getR(), getG(), getB(), getA()
// DIFF:            added ofColor_ pixel channel setters setR(), setG(), setB(), setA()
// DIFF: ofColor.h: added target language tostring wrapper for ofColor_::operator <<
%extend ofColor_ {

	// pixel channel getters
	PixelType getR() {return $self->r;}
	PixelType getG() {return $self->g;}
	PixelType getB() {return $self->b;}
	PixelType getA() {return $self->a;}

	// pixel channel setters
	void setR(PixelType r) {$self->r = r;}
	void setG(PixelType g) {$self->g = g;}
	void setB(PixelType b) {$self->b = b;}
	void setA(PixelType a) {$self->a = a;}

	const char* __str__() {
		stringstream str;
		str << (*$self);
		return str.str().c_str();
	}
};

%attributeVar(ofColor_<unsigned char>, unsigned char, r, r, r);
%attributeVar(ofColor_<unsigned char>, unsigned char, g, g, g);
%attributeVar(ofColor_<unsigned char>, unsigned char, b, b, b);
%attributeVar(ofColor_<unsigned char>, unsigned char, a, a, a);

%attributeVar(ofColor_<float>, float, r, r, r);
%attributeVar(ofColor_<float>, float, g, g, g);
%attributeVar(ofColor_<float>, float, b, b, b);
%attributeVar(ofColor_<float>, float, a, a, a);

%attributeVar(ofColor_<unsigned short>, unsigned short, r, r, r);
%attributeVar(ofColor_<unsigned short>, unsigned short, g, g, g);
%attributeVar(ofColor_<unsigned short>, unsigned short, b, b, b);
%attributeVar(ofColor_<unsigned short>, unsigned short, a, a, a);

// tell SWIG about template classes
#ifdef OF_SWIG_RENAME
	%template(Color) ofColor_<unsigned char>;
	%template(FloatColor) ofColor_<float>;
	%template(ShortColor) ofColor_<unsigned short>;
#else
	%template(ofColor) ofColor_<unsigned char>;
	%template(ofFloatColor) ofColor_<float>;
	%template(ofShortColor) ofColor_<unsigned short>;
#endif

// ----- ofTypes.h -----

// DIFF: ofTypes.h: ignoring video format and video device classes
%ignore ofVideoFormat;
%ignore ofVideoDevice;

// DIFF: ofTypes.h: mutex, scoped lock, & ptr are probably too low level
%ignore ofMutex;
%ignore ofScopedLock;
%ignore ofPtr;

%include "types/ofTypes.h"

// ----- ofPoint.h -----

// NOTE: ofPoint is just a typedef which swig cannot wrap, so the types need to be 
// handled in the scripting language, see the Lua, Python, etc code at the end
%include "types/ofPoint.h"

// ----- ofRectangle.h -----

// DIFF: ofRectangle.h: renamed functions due to ambiguous overloading:
// DIFF:                scaleToScaleMode() & scaleToAspectRatio()
%rename(scaleToScaleMode) ofRectangle::scaleTo(ofRectangle const &, ofScaleMode);
%rename(scaleToAspectRatio) ofRectangle::scaleTo(ofRectangle const &, ofAspectRatioMode);

// TODO: ofRectangle.h: SWIG Warning 302 due to manual override of x & y attributes
%warnfilter(302) ofRectangle::x;
%warnfilter(302) ofRectangle::y;

%extend ofRectangle {

	// override these since they are float references in the orig file and we
	// want to access them as floats
	float x;
	float y;

	const char* __str__() {
		stringstream str;
		str << (*$self);
		return str.str().c_str();
	}
};

%include "types/ofRectangle.h"

// SWIG converts the x & y float& types into pointers,
// so specify x & y as attributes using the get & set functions
%attribute(ofRectangle, float, x, getX, setX);
%attribute(ofRectangle, float, y, getY, setY);

// ----- not needed -----

// ofParameter.h, ofParameterGroup.h 

// ----- UTILS -----------------------------------------------------------------

// ----- ofFpsCounter.h -----

%include "utils/ofFpsCounter.h"

// ----- ofMatrixStack.h -----

%include "utils/ofMatrixStack.h"

// ----- ofXml.h -----

// DIFF: ofXml.h: ignoring PocoDocument & PocoElement getters
%ignore ofXml::getPocoDocument;
%ignore ofXml::getPocoElement;

%include "utils/ofXml.h"

// ----- ofMatrixStack.h -----

%include "utils/ofMatrixStack.h"

// ----- ofFileUtils.h -----

// SWIG needs to know about boost::filesystem or it throws an error
namespace boost {
	namespace filesystem {}
}

// forward declare fstream for ofFile
%ignore fstream;
class fstream {};

// DIFF: ofFileUtils.h: ignoring iterators
%ignore ofBuffer::begin;
%ignore ofBuffer::end;
%ignore ofBuffer::rbegin;
%ignore ofBuffer::rend;
%ignore ofDirectory::begin;
%ignore ofDirectory::end;
%ignore ofDirectory::rbegin;
%ignore ofDirectory::rend;

// DIFF: ofFileUtils.h: ignoring ofBuffer istream & ostream functions
%ignore ofBuffer::ofBuffer(istream &);
%ignore ofBuffer::ofBuffer(istream &, size_t);
%ignore ofBuffer::set(istream &);
%ignore ofBuffer::set(istream &, size_t);
%ignore ofBuffer::writeTo(ostream &) const;

%ignore ofBuffer::ofBuffer(const string &);
%ignore ofBuffer::set(const string &);
%ignore ofBuffer::append(const string&);

// ignore char* getData() in preference to const char* getData() whose return
// type is overriden below
%ignore ofBuffer::getData();

// DIFF: ofFileUtils.h: pass binary data to ofBuffer as full char strings
// pass binary data & byte length as a single argument for ofBuffer
#if defined(SWIGLUA)

// args from lang in to C++ function
%typemap(in) (char *STRING, size_t LENGTH) {
	$2 = (size_t)lua_tonumber(L, $input+1);
	$1 = (char *)lua_tolstring(L, $input, &$2);
}

// arg returned from C++ function out to lang
%typemap(out) (const char *) {
	lua_pushlstring(L, $1, arg1->size());
	SWIG_arg++;
}

#endif

// ofBuffer constructor uses "buffer" and "size" while set & append use "_buffer" and "_size"
%apply(char *STRING, size_t LENGTH) {(const char * buffer, std::size_t size)};
%apply(char *STRING, size_t LENGTH) {(const char * _buffer, std::size_t _size)};

// DIFF: ofFileUtils.h: ignoring nested ofBuffer Line & Lines & RLine & RLines structs
%ignore ofBuffer::Line;
%ignore ofBuffer::Lines;
%ignore ofBuffer::RLine;
%ignore ofBuffer::RLines;
%ignore ofBuffer::getLines();
%ignore ofBuffer::getReverseLines();
%ignore ofBuffer::Lines::end();
%ignore ofBuffer::RLines::end();

// DIFF: ofFileUtils.h: std::filesystem::path arguments replaced by string
%ignore std::filesystem::path;

// extend with std::string wrappers for std::filesystem::path
%extend ofFile {
	ofFile(const string &path) {
		std::filesystem::path p = std::filesystem::path(path);
		return new ofFile(path);
	}
	bool ofFile::open(const string &path) {
		std::filesystem::path p = std::filesystem::path(path);
		return $self->open(p);
	}
}

// extend with std::string wrappers for std::filesystem::path
%extend ofDirectory {
	ofDirectory(const string &path) {
		std::filesystem::path p = std::filesystem::path(path);
		return new ofDirectory(path);
	}
	void ofDirectory::open(const string &path) {
		std::filesystem::path p = std::filesystem::path(path);
		return $self->open(p);
	}
}

// DIFF: ofFileUtils.h: ignoring string, filebuf, & std::filesystem::path operators
%ignore ofBuffer::operator string() const;
%ignore ofFile::getFileBuffer() const;
%ignore ofFile::operator std::filesystem::path();
%ignore ofFile::operator const std::filesystem::path() const;
%ignore ofDirectory::operator std::filesystem::path();
%ignore ofDirectory::operator const std::filesystem::path() const;

%extend ofFilePath {
        static string getFileExt(const string& filename) {
                return ofFilePath::getFileExt(filename);
        }
        static string removeExt(const string& filename) {
                return ofFilePath::removeExt(filename);
        }
        static string addLeadingSlash(const string& path) {
                return ofFilePath::addLeadingSlash(path);
        }
        static string addTrailingSlash(const string& path) {
                return ofFilePath::addTrailingSlash(path);
        }
        static string removeTrailingSlash(const string& path) {
                return ofFilePath::removeTrailingSlash(path);
        }
        static string getPathForDirectory(const string& path) {
                return ofFilePath::getPathForDirectory(path);
        }
        static string getAbsolutePath(const string& path, bool bRelativeToData = true) {
                return ofFilePath::getAbsolutePath(path, bRelativeToData);
        }
        static bool isAbsolute(const string& path) {
                return ofFilePath::isAbsolute(path);
        }
        static string getFileName(const string& filePath, bool bRelativeToData = true) {
                return ofFilePath::getFileName(filePath, bRelativeToData);
        }
        static string getBaseName(const string& filePath) {
                return ofFilePath::getBaseName(filePath);
        }
        static string getEnclosingDirectory(const string& filePath, bool bRelativeToData = true) {
                return ofFilePath::getEnclosingDirectory(filePath, bRelativeToData);
        }
        static bool createEnclosingDirectory(const string& filePath, bool bRelativeToData = true, bool bRecursive = true) {
                return ofFilePath::createEnclosingDirectory(filePath, bRelativeToData, bRecursive);
        }
        static string join(const string& path1, const string& path2) {
                return ofFilePath::join(path1, path2);
        }
        static string makeRelative(const string& from, const string& to) {
                return ofFilePath::makeRelative(from, to);
        }
}

%include "utils/ofFileUtils.h"

// clear typemaps
%clear (const char *buffer, std::size_t size);
%clear (const char *_buffer, std::size_t _size);
%clear (const char *);

// ----- ofLog.h -----

// function wrapper for ofLog class
%inline %{
	void log(ofLogLevel level, const string & message) {
		ofLog(level, message);
	}
%}

// DIFF: ofLog.h: ignore stream based log classes since target languages won't support it
%ignore ofLog;
%ignore ofLogVerbose;
%ignore ofLogNotice;
%ignore ofLogWarning;
%ignore ofLogError;
%ignore ofLogFatalError;

// DIFF: ofLog.h: ignore logger channel classes
%ignore ofBaseLoggerChannel;
%ignore ofSetLoggerChannel;
%ignore ofConsoleLoggerChannel;
%ignore ofFileLoggerChannel;

%include "utils/ofLog.h"

// ----- ofSystemUtils.h -----

%include "utils/ofSystemUtils.h"

// ----- ofURLFileLoader.h -----

// DIFF: ofURLFileLoader.h:ignoring ofHttpResponse ofBuffer operator
%ignore ofHttpResponse::operator ofBuffer&();
%ignore ofSaveURLTo(const string& url, const std::filesystem::path& path);
%ignore ofSaveURLAsync(const string& url, const std::filesystem::path& path);

%include "utils/ofURLFileLoader.h"

// ----- ofUtils.h -----

// DIFF: ofUtils.h: ignoring ofFromString as templating results in too much overloading
%ignore ofFromString;

// DIFF: ofUtils.h: variable argument support is painful, safer to ignore
// see http://www.swig.org/Doc2.0/Varargs.html
%ignore ofVAArgsToString;

// DIFF: ofUtils.h: ignoring ofUTF8Iterator
%ignore ofUTF8Iterator;
#ifdef SWIGLUA // ignore these to silence Warning 314
	%ignore ofUTF8Iterator::end;
#endif

%include "utils/ofUtils.h"

// ----- not needed -----

// ofTimer.h, ofNoise.h, ofThread.h 

// ----- VIDEO -----------------------------------------------------------------

// ----- ofVideoGrabber.h -----

// DIFF: ofVideoGrabber.h: ignore getGrabber/setGrabber
%ignore setGrabber(shared_ptr<ofBaseVideoPlayer>);
%ignore getGrabber();
%ignore getGrabber() const;

%include "video/ofVideoGrabber.h"

// ----- ofVideoPlayer.h -----

// DIFF: ofVideoPlayer.h: ignore getPlayer/setPlayer
%ignore setPlayer(shared_ptr<ofBaseVideoPlayer>);
%ignore getPlayer();
%ignore getPlayer() const;

%include "video/ofVideoPlayer.h"

// ----- not needed -----

// ofQuickTimGrabber.h, ofQuickTimePlayer.h, ofQTUtils.h, ofQTKitGrabber.h,
// ofQTKitPlayer.h, ofQTKitMovieRenderer.h, ofAVFoundationVideoPlayer,
// ofAVFoundationPlayer.h

////////////////////////////////////////////////////////////////////////////////
// ----- ATTRIBUTES ------------------------------------------------------------

#ifdef OF_SWIG_ATTRIBUTES
	%include "interfaces/attributes.i"
#endif

////////////////////////////////////////////////////////////////////////////////
// ----- LANG ------------------------------------------------------------------

%include "interfaces/lang.i"
