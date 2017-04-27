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
%ignore ofMessage;

// DIFF:   ignore ofSendMessage() with ofMessage in favor of std::string
%ignore ofSendMessage(ofMessage msg);

%ignore ofCoreEvents;
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

%ignore ofNotifySetup;
%ignore ofNotifyUpdate;
%ignore ofNotifyDraw;
%ignore ofNotifyKeyPressed;
%ignore ofNotifyKeyReleased;
%ignore ofNotifyKeyEvent;
%ignore ofNotifyMousePressed;
%ignore ofNotifyMouseReleased;
%ignore ofNotifyMouseDragged;
%ignore ofNotifyMouseMoved;
%ignore ofNotifyMouseEvent;
%ignore ofNotifyExit;
%ignore ofNotifyWindowResized;
%ignore ofNotifyWindowEntry;
%ignore ofNotifyDragEvent;

%include "events/ofEvents.h"

// ----- ofEventUtils.h -----

// not needed
