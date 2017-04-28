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

// DIFF:   ignoring string, filebuf, & std::filesystem::path operators
%ignore ofBuffer::operator string() const;
%ignore ofFile::getFileBuffer() const;
%ignore ofFile::operator std::filesystem::path();
%ignore ofDirectory::operator std::filesystem::path();

%include "utils/ofFileUtils.h"

// clear typemaps
%clear(const char *buffer, std::size_t size);
%clear(const char *_buffer, std::size_t _size);

// ----- ofLog.h -----

// function wrapper for ofLog class
%inline %{
	void log(ofLogLevel level, const string & message) {
		ofLog(level, message);
	}
%}

// DIFF: ofLog.h:
// DIFF:   ignore stream-based log classes since target languages won't support it
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

// ----- ofUtils.h -----

// DIFF: ofUtils.h:
// DIFF:   ignoring ofFromString as templating results in too much overloading
%ignore ofFromString;

// DIFF:   variable argument support is painful, safer to ignore
// see http://www.swig.org/Doc2.0/Varargs.html
%ignore ofVAArgsToString;

// DIFF:   ignoring ofUTF8Iterator
%ignore ofUTF8Iterator;

%include "utils/ofUtils.h"
