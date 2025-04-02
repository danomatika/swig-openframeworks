// events folder bindings
// 2017 Dan Wilcox <danomatika@gmail.com>

// ----- ofEvents.h -----

// DIFF: ofEvents.h:
// DIFF:   ignore event classes, event args, and registration functions
%ignore ofEventArgs;
%ignore ofEntryEventArgs;
%ignore ofKeyEventArgs;
%ignore ofMouseEventArgs;
// need ofTouchEventArgs for touch callbacks
%ignore ofAudioEventArgs;
%ignore ofResizeEventArgs;
%ignore ofWindowPosEventArgs;
%ignore ofMessage;

%ignore ofCoreEvents;

// DIFF:   ignore ofSendMessage() with ofMessage in favor of std::string
%ignore ofSendMessage(ofMessage msg);

%ignore ofEvents;

%ignore ofRegisterMouseEvents;
%ignore ofRegisterKeyEvents;
%ignore ofRegisterTouchEvents;
%ignore ofRegisterGetMessages;
%ignore ofRegisterDragEvents;
%ignore ofUnregisterMouseEvents;
%ignore ofUnregisterKeyEvents;
%ignore ofUnregisterTouchEvents;
%ignore ofUnregisterGetMessages;
%ignore ofUnregisterDragEvents;

// OF 0.12.1 prelim replace ofTimeMode with an enum that SWIG doesn't ignore
%inline %{
	enum ofTimeModeEnum : int {
		TimeMode_System,
		TimeMode_FixedRate,
		TimeMode_Filtered
	};
%}
%ignore ofTimeMode;

%include "events/ofEvents.h"

// DIFF:   added target language tostring wrapper for ofTouchEventArgs::operator <<
// TODO:   ofTouchEventArgs inheritance from glm::vec2 doesn't create x & y attributes
%extend ofTouchEventArgs {
	const char* __str__() {
		static char temp[256];
		std::stringstream str;
		str << (*self);
		std::strcpy(temp, str.str().c_str());
		return &temp[0];
	}
};

// manually create attributes since inheriting from
// glm::vec2 doesn't seem to create them
%attributeVar(ofTouchEventArgs, float, x, x, x);
%attributeVar(ofTouchEventArgs, float, y, y, y);
