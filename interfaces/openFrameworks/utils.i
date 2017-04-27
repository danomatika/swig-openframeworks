// utils folder bindings
// 2017 Dan Wilcox <danomatika@gmail.com>

// ----- ofFpsCounter.h -----

%include "utils/ofFpsCounter.h"

// ----- ofTimer.h -----

// not needed

// ----- ofXml.h -----

// DIFF: ofXml.h: ignoring PocoDocument & PocoElement getters
%ignore ofXml::getPocoDocument;
%ignore ofXml::getPocoElement;

%include "utils/ofXml.h"

// ----- ofMatrixStack.h -----

%include "utils/ofMatrixStack.h"

// ----- ofConstants.h -----

// handled in main.i

// ----- ofFileUtils.h -----

// SWIG needs to know about boost::filesystem or it throws an error
namespace boost {
	namespace filesystem {}
}

// forward declare fstream for ofFile
%ignore fstream;
class fstream {};

// DIFF: ofFileUtils.h:
// DIFF:   ignoring iterators
%ignore ofBuffer::begin;
%ignore ofBuffer::end;
%ignore ofBuffer::rbegin;
%ignore ofBuffer::rend;
%ignore ofDirectory::begin;
%ignore ofDirectory::end;
%ignore ofDirectory::rbegin;
%ignore ofDirectory::rend;

// DIFF:   ignoring ofBuffer istream & ostream functions
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

// DIFF:   pass binary data to ofBuffer as full char strings
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

// DIFF:   ignoring nested ofBuffer Line & Lines structs
%ignore ofBuffer::Line;
%ignore ofBuffer::Lines;
%ignore ofBuffer::getLines();
%ignore ofBuffer::Lines::end();

#if OF_VERSION_MINOR > 9
// DIFF:   ignoring nested ofBuffer RLine & RLines structs
%ignore ofBuffer::RLine;
%ignore ofBuffer::RLines;
%ignore ofBuffer::getReverseLines();
%ignore ofBuffer::RLines::end();
#endif

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

#if OF_VERSION_MINOR > 9
// extend with std::string wrappers for std::filesystem::path
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
#endif

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

// DIFF:   ignoring string, filebuf, & std::filesystem::path operators
%ignore ofBuffer::operator string() const;
%ignore ofFile::getFileBuffer() const;
%ignore ofFile::operator std::filesystem::path();
%ignore ofFile::operator const std::filesystem::path() const;
%ignore ofDirectory::operator std::filesystem::path();
%ignore ofDirectory::operator const std::filesystem::path() const;

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

// DIFF: ofLog.h:
// DIFF:   ignore stream based log classes since target languages won't support it
%ignore ofLog;
%ignore ofLogVerbose;
%ignore ofLogNotice;
%ignore ofLogWarning;
%ignore ofLogError;
%ignore ofLogFatalError;

// DIFF:   ignore logger channel classes
%ignore ofBaseLoggerChannel;
%ignore ofSetLoggerChannel;
%ignore ofConsoleLoggerChannel;
%ignore ofFileLoggerChannel;

%include "utils/ofLog.h"

// ----- ofNoise.h -----

// not needed

// ----- ofSystemUtils.h -----

%include "utils/ofSystemUtils.h"

// ----- ofThread.h -----

// not needed

// ----- ofURLFileLoader.h -----

// DIFF: ofURLFileLoader.h: ignoring ofHttpResponse ofBuffer operator
%ignore ofHttpResponse::operator ofBuffer&();

%include "utils/ofURLFileLoader.h"

#if OF_VERSION_MINOR > 9
%inline %{

ofHttpResponse ofSaveURLTo(const string& url, const string& path) {
	return ofSaveURLTo(url, std::filesystem::path(path));
}

int ofSaveURLAsync(const string& url, const string& path) {
	return ofSaveURLAsync(url, std::filesystem::path(path));
}

%}
#endif

// ----- ofUtils.h -----

// DIFF: ofUtils.h:
// DIFF:   ignoring ofFromString as templating results in too much overloading
%ignore ofFromString;

// DIFF:   variable argument support is painful, safer to ignore
// see http://www.swig.org/Doc2.0/Varargs.html
%ignore ofVAArgsToString;

// DIFF:   ignoring ofUTF8Iterator
%ignore ofUTF8Iterator;
#ifdef SWIGLUA // ignore these to silence Warning 314
	%ignore ofUTF8Iterator::end;
#endif

%include "utils/ofUtils.h"
