// communication folder bindings
// 2017 Dan Wilcox <danomatika@gmail.com>

// ----- ofArduino.h -----

// DIFF: ofArduino.h: ignoring functions which return list points
%ignore ofArduino::getDigitalHistory(int);
%ignore ofArduino::getAnalogHistory(int);
%ignore ofArduino::getSysExHistory();
%ignore ofArduino::getStringHistory();

%include "communication/ofArduino.h"

// ----- ofSerial.h -----

// DIFF: ofSerial.h:
// DIFF:   pass binary data to ofSerial as full char strings
// DIFF:   pass binary data & byte length as a single argument for ofBuffer
%apply(unsigned char *STRING, int LENGTH) {(unsigned char * buffer, int length)};

%include "communication/ofSerial.h"

// clear typemap
%clear(unsigned char * buffer, int length);
