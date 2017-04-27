// sound folder bindings
// 2017 Dan Wilcox <danomatika@gmail.com>

// ----- ofBaseSoundPlayer.h -----

// not needed

// ----- ofBaseSoundStream.h -----

// not needed

// ----- ofFmodSoundPlayer.h -----

// not needed

// ----- ofOpenALSoundPlayer.h -----

// not needed

// ----- ofRtAudioSoundStream.h -----

// not needed

// ----- ofSoundBuffer.h -----

// not needed

// ----- ofSoundStream.h -----

// ignore overloaded functions
%ignore ofSoundStream::setInput(ofBaseSoundInput &soundInput);
%ignore ofSoundStream::setOutput(ofBaseSoundOutput &soundOutput);

%include "sound/ofSoundStream.h"

// ----- ofSoundPlayer.h -----

%ignore ofBaseSoundPlayer;
class ofBaseSoundPlayer {};

// DIFF: ofSoundPlayer.h: warnings say "FIX THIS SHIT", so leaving out fmod global functions
%ignore ofSoundStopAll;
%ignore ofSoundShutdown;
%ignore ofSoundSetVolume;
%ignore ofSoundUpdate;
%ignore ofSoundGetSpectrum;

%include "sound/ofSoundPlayer.h"

// ----- ofSoundUtils.h -----

// not needed
