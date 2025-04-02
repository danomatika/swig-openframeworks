// math folder bindings
// 2017 Dan Wilcox <danomatika@gmail.com>

// ----- ofMath.h -----

// DIFF: ofMath.h: ignoring ofMin & ofMax version for differing types
%ignore ofMin(const T &, const Q &);
%ignore ofMax(const T &, const Q &);

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

// ----- ofMathConstants.h -----

// handled in main.i

// ----- ofMatrix3x3.h -----

// DIFF: ofMatrix3x3.h: renaming glm::mat3 operator to mat3()
%rename(mat3) ofMatrix3x3::operator glm::mat3;

%include "math/ofMatrix3x3.h"

%extend ofMatrix3x3 {
	const char* __str__() {
		static char temp[256];
		std::stringstream str;
		str << (*self);
		std::strcpy(temp, str.str().c_str());
		return &temp[0];
	}
};

// ----- ofMatrix4x4.h -----

// DIFF: ofMatrix4x4.h: ignoring operator(size_t, size_t) const overload
%ignore ofMatrix4x4::operator()(std::size_t, std::size_t) const;

// DIFF: ofMatrix4x4.h: renaming glm::mat4 operator to mat4()
%rename(mat4) ofMatrix4x4::operator glm::mat4;

%include "math/ofMatrix4x4.h"

%extend ofMatrix4x4 {
	const char* __str__() {
		static char temp[256];
		std::stringstream str;
		str << (*self);
		std::strcpy(temp, str.str().c_str());
		return &temp[0];
	}
};

// ----- ofQuaternion.h -----

// DIFF: ofQuaternion.h: renaming glm::quat operator to quat()
%rename(quat) ofQuaternion::operator glm::quat;

// silence warning as SWIG ignores these anyway
// since it uses the non-const versions
%ignore ofQuaternion::x() const;
%ignore ofQuaternion::y() const;
%ignore ofQuaternion::z() const;
%ignore ofQuaternion::w() const;

%include "math/ofQuaternion.h"

%extend ofQuaternion {
	const char* __str__() {
		static char temp[256];
		std::stringstream str;
		str << (*self);
		std::strcpy(temp, str.str().c_str());
		return &temp[0];
	}
};

// ----- ofVec2f.h -----

// DIFF: ofVec2f.h: renaming glm::vec2 operator to vec2()
%rename(vec2) ofVec2f::operator glm::vec2;

%include "math/ofVec2f.h"

%extend ofVec2f {
	const char* __str__() {
		static char temp[256];
		std::stringstream str;
		str << (*self);
		std::strcpy(temp, str.str().c_str());
		return &temp[0];
	}
};

// ----- ofVec3f.h -----

// DIFF: ofVec3f.h: renaming glm::vec3 operator to vec3()
%rename(vec3) ofVec3f::operator glm::vec3;

%include "math/ofVec3f.h"

%extend ofVec3f {
	const char* __str__() {
		static char temp[256];
		std::stringstream str;
		str << (*self);
		std::strcpy(temp, str.str().c_str());
		return &temp[0];
	}
};

// ----- ofVec4f.h -----

// DIFF: ofVec4f.h: renaming glm::vec4 operator to vec4()
%rename(vec4) ofVec4f::operator glm::vec4;

%include "math/ofVec4f.h"

%extend ofVec4f {
	const char* __str__() {
		static char temp[256];
		std::stringstream str;
		str << (*self);
		std::strcpy(temp, str.str().c_str());
		return &temp[0];
	}
};
