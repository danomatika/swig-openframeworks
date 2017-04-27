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
#if defined(SWIGLUA)

	// args from lang in to C++ function
	%typemap(in) (unsigned char *STRING, int LENGTH) {
		$2 = (int)lua_tonumber(L, $input+1);
		$1 = (unsigned char *)lua_tolstring(L, $input, (size_t *)&$2);
	}

#endif
%apply(unsigned char *STRING, int LENGTH) {(unsigned char * buffer, int length)};

%include "communication/ofSerial.h"
