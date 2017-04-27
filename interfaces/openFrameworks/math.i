// math folder bindings
// 2017 Dan Wilcox <danomatika@gmail.com>

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

// ----- ofVec2f.h -----

%include "math/ofVec2f.h"

%extend ofVec2f {
	const char* __str__() {
		stringstream str;
		str << (*$self);
		return str.str().c_str();
	}
};

// ----- ofVec3f.h -----

%include "math/ofVec3f.h"

%extend ofVec3f {
	const char* __str__() {
		stringstream str;
		str << (*$self);
		return str.str().c_str();
	}
};

// ----- ofVec4f.h -----

%include "math/ofVec4f.h"

%extend ofVec4f {
	const char* __str__() {
		stringstream str;
		str << (*$self);
		return str.str().c_str();
	}
};

// ----- ofVectorMath.h-----

// not needed
