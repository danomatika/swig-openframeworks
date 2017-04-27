// graphics folder bindings
// 2017 Dan Wilcox <danomatika@gmail.com>

// ----- ofPixels.h -----

// include pixels first as it's used by most other classes

// DIFF: ofPixels.h:
// DIFF:   ignoring const & copy constructor in favor of && constructor
%ignore ofPixels_(const ofPixels_<PixelType> &);

// DIFF: ofPixels.h:
// DIFF:   fixed ambiguous ofPixels function overloads since enums = int in SWIG
// DIFF:   by renaming to allocatePixelFormat, allocateimageType, & setFromPixelsImageType
%rename(allocatePixelFormat) ofPixels_<unsigned char>::allocate(size_t, size_t, ofPixelFormat);
%rename(allocateImageType) ofPixels_<unsigned char>::allocate(size_t, size_t, ofImageType);
%rename(setFromPixelsImageType) ofPixels_<unsigned char>::setFromPixels(unsigned char const *, size_t, size_t, ofImageType);

%rename(allocatePixelFormat) ofPixels_<float>::allocate(size_t, size_t, ofPixelFormat);
%rename(allocateImageType) ofPixels_<float>::allocate(size_t, size_t, ofImageType);
%rename(setFromPixelsImageType) ofPixels_<float>::setFromPixels(float const *, size_t, size_t, ofImageType);

%rename(allocatePixelFormat) ofPixels_<unsigned short>::allocate(size_t, size_t, ofPixelFormat);
%rename(allocateImageType) ofPixels_<unsigned short>::allocate(size_t, size_t, ofImageType);
%rename(setFromPixelsImageType) ofPixels_<unsigned short>::setFromPixels(unsigned short const *, size_t, size_t, ofImageType);

// DIFF: ofPixels.h:
// DIFF:   ignore overloaded setFromPixels, setFromExternalPixels, &
// DIFF:   setFromAlignedPixels w/ channels argument,
// DIFF:   use ofPixelType overloaded functions instead
%ignore ofPixels_<unsigned char>::setFromPixels(unsigned char const *, size_t, size_t, size_t);
%ignore ofPixels_<float>::setFromPixels(float const *, size_t, size_t, size_t);
%ignore ofPixels_<unsigned short>::setFromPixels(unsigned short const *, size_t, size_t, size_t);

%ignore ofPixels_<unsigned char>::setFromExternalPixels(unsigned char *, size_t, size_t, size_t);
%ignore ofPixels_<float>::setFromExternalPixels(float *, size_t, size_t, size_t);
%ignore ofPixels_<unsigned short>::setFromExternalPixels(unsigned short *, size_t, size_t, size_t);

%ignore ofPixels_<unsigned char>::setFromAlignedPixels(const unsigned char *, size_t, size_t, size_t, size_t);
%ignore ofPixels_<float>::setFromAlignedPixels(const float *, size_t, size_t, size_t, size_t);
%ignore ofPixels_<unsigned short>::setFromAlignedPixels(const unsigned short *, size_t, size_t, size_t, size_t);

// DIFF: ofPixels.h:
// DIFF:   ignore setFromAlignedPixels with vector arguments
%ignore ofPixels_<unsigned char>::setFromAlignedPixels(const unsigned char *, size_t, size_t, ofPixelFormat, std::vector<size_t>);
%ignore ofPixels_<float>::setFromAlignedPixels(const float *, size_t, size_t, ofPixelFormat, std::vector<size_t>);
%ignore ofPixels_<unsigned short>::setFromAlignedPixels(const unsigned short *, size_t, size_t, ofPixelFormat, std::vector<size_t>);

%ignore ofPixels_<unsigned char>::setFromAlignedPixels(const unsigned char *, size_t, size_t, ofPixelFormat, std::vector<int>);
%ignore ofPixels_<float>::setFromAlignedPixels(const float *, size_t, size_t, ofPixelFormat, std::vector<int>);
%ignore ofPixels_<unsigned short>::setFromAlignedPixels(const unsigned short *, size_t, size_t, ofPixelFormat, std::vector<int>);

// DIFF:   ignoring static functions
%ignore ofPixels_::pixelBitsFromPixelFormat(ofPixelFormat);
%ignore ofPixels_::bytesFromPixelFormat(size_t, size_t, ofPixelFormat);

// DIFF:   ignoring nested structs, not supported by SWIG
%ignore ofPixels_::ConstPixel;
%ignore ofPixels_::Pixel;
%ignore ofPixels_::Pixels;
%ignore ofPixels_::Line;
%ignore ofPixels_::Lines;
%ignore ofPixels_::ConstPixels;
%ignore ofPixels_::ConstLine;
%ignore ofPixels_::ConstLines;

// DIFF:   ignoring iterators
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

// ----- ofRendererCollection.h -----

// not needed

// ----- ofCairoRenderer.h -----

// not needed

// ----- ofBitmapFont.h -----

// not needed

// ----- ofGraphics.h -----

// no PDF or SVG export support on mobile
#if defined(TARGET_IOS) || defined(TARGET_ANDROID)
	%ignore ofBeginSaveScreenAsPDF;
	%ignore ofEndSaveScreenAsPDF();
	%ignore ofBeginSaveScreenAsSVG;
	%ignore ofEndSaveScreenAsSVG();
#endif

// DIFF: ofGraphics.h:
// DIFF:   ignoring foDrawBitmapString template functions in favor of
// DIFF:   string versions target languages can handle the string conversions
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

// ----- ofImage.h -----

// handled in main.i

// ----- ofTessellator.h -----

// not needed

// ----- ofTrueTypeFont.h -----

// ignore internal font struct
%ignore charProps;

// DIFF: ofTrueTypeFont.h:
// DIFF:   ignoring ofTrueTypeShutdown() & ofExitCallback() friend
%ignore ofTrueTypeShutdown;
%ignore ofExitCallback();

// DIFF:   ignoring const & copy constructor in favor of && constructor
%ignore ofTrueTypeFont::ofTrueTypeFont(ofTrueTypeFont const &);

// string static const strings
%rename(TTF_SANS) OF_TTF_SANS;
%rename(TTF_SERIF) OF_TTF_SERIF;
%rename(TTF_MONO) OF_TTF_MONO;

%include "graphics/ofTrueTypeFont.h"
