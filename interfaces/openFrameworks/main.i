// forward declarations and headers which need to be handled first
// 2017 Dan Wilcox <danomatika@gmail.com>

// ignore everything in the private namespace
%ignore of::priv;

// needed for functions and return types
namespace std {
	%template(IntVector) std::vector<int>;
	%template(FloatVector) std::vector<float>;
	%template(StringVector) std::vector<std::string>;
	%template(UCharVector) std::vector<unsigned char>;
	%template(VideoDeviceVector) std::vector<ofVideoDevice>;
	%template(TextureVector) std::vector<ofTexture>;
};

// DIFF: std::filesystem::path arguments replaced by string
%ignore std::filesystem::path;

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

// DIFF: ofFbo.h:
// DIFF:   ignoring const & copy constructor in favor of && constructor
%ignore ofFbo::ofFbo(ofFbo const &);

// DIFF:   setUseTexture & isUsingTexture are "irrelevant", so ignoring
%ignore ofFbo::setUseTexture;
%ignore ofFbo::isUsingTexture;

// DIFF:   ignoring setActiveDrawBufers() due to std::vector
%ignore setActiveDrawBuffers(const vector<int>& i);

// DIFF:   ignoring nested structs, not supported by SWIG
%ignore ofFbo::Settings;

// DIFF:   (Lua) beginFbo() & endFbo() since "end" is a Lua keyword
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

// DIFF: ofImage.h:
// DIFF:   ignore global helper functions
%ignore ofLoadImage;
%ignore ofSaveImage;
%ignore ofCloseFreeImage;

#if OF_VERSION_MINOR > 9
// extend with std::string wrappers for std::filesystem::path
%extend ofImage_ {
	ofImage_(const string& fileName, const ofImageLoadSettings &settings = ofImageLoadSettings()) {
		std::filesystem::path p = std::filesystem::path(fileName);
		return new ofImage_<PixelType>(p, settings);
	}
	bool load(const string& fileName, const ofImageLoadSettings &settings = ofImageLoadSettings()) {
        std::filesystem::path p = std::filesystem::path(fileName);
        return $self->load(p, settings);
	}
	void save(const std::filesystem::path & fileName, ofImageQualityType compressionLevel = OF_IMAGE_QUALITY_BEST) const {
		std::filesystem::path p = std::filesystem::path(fileName);
		return $self->save(p, compressionLevel);
	}
}
#endif

// DIFF:   ignoring ofPixels operator
%ignore ofImage_::operator ofPixels_<PixelType>&();

// DIFF:   ignoring const & copy constructor in favor of && constructor
%ignore ofImage_(const ofImage_<PixelType>&);

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
