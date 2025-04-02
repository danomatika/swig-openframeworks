// communication folder bindings
// 2017 Dan Wilcox <danomatika@gmail.com>

// ----- ofArduino.h -----

// DIFF: ofArduino.h: ignoring functions which return list points
%ignore ofArduino::getDigitalHistory(int);
%ignore ofArduino::getAnalogHistory(int);
%ignore ofArduino::getSysExHistory;
%ignore ofArduino::getStringHistory;

// DIFF: ofArduino.h: pass binary data to I2C as full char strings
%apply(const char *STRING, int LENGTH) {(const char * buffer, int numOfBytes)};

// DIFF: ofArduino.h: ignoring sendI2CWriteRequest() overloads in favor of
// DIFF:              version which takes bytes as a const char *
%ignore ofArduino::sendI2CWriteRequest(char, unsigned char *, int, int);
%ignore ofArduino::sendI2CWriteRequest(char, char *, int, int);
%ignore ofArduino::sendI2CWriteRequest(char, std::vector<char>, int);

// ... and again to handle the last argument's default value default causing
// SWIG to create the following function overloads
%ignore ofArduino::sendI2CWriteRequest(char, unsigned char *, int);
%ignore ofArduino::sendI2CWriteRequest(char, char *, int);
%ignore ofArduino::sendI2CWriteRequest(char, std::vector<char>);

%include "communication/ofArduino.h"

// clear typemap
%clear(const char * buffer, int numOfBytes);

// ----- ofSerial.h -----

// DIFF: ofSerial.h: pass binary data as full char strings
%apply(unsigned char *STRING, int LENGTH) {(unsigned char * buffer, int length)};

// DIFF: ofSerial.h:
// DIFF:   OF 0.12.1 prelim hides OF_SERIAL_ERROR and OF_SERIAL_NO_DATA but
// DIFF:   ofSerial will return them, so define in the wrapper when needed
#ifndef OF_SERIAL_NO_DATA
#define OF_SERIAL_NO_DATA -2
#endif
#ifndef OF_SERIAL_ERROR
#define OF_SERIAL_ERROR -1
#endif

%include "communication/ofSerial.h"

// clear typemap
%clear(unsigned char * buffer, int length);
