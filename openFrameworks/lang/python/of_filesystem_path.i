// of::filesystem::path wrapper to convert to Python strings automatically
// adapted from SWIG Lib/python/std_string.i and Lib/typemaps/std_string.swg
// 2017,2023 Dan Wilcox <danomatika@gmail.com>

%include <typemaps/std_strings.swg>

%fragment("<string>");

// note: oF 0.12 wraps std::filesystem or boost::filesystem as of::filesystem
namespace of {
namespace filesystem {
	%naturalvar path;
	class path;
} // filesystem
} // of

%typemaps_std_string(of::filesystem::path, char, SWIG_AsCharPtrAndSize, SWIG_FromCharPtrAndSize, %checkcode(STDSTRING));
