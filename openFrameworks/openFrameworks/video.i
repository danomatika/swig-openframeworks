// video folder bindings
// 2017 Dan Wilcox <danomatika@gmail.com>

// ----- ofVideoBaseTypes.h -----

// handled in main.i

// ----- ofVideoGrabber.h -----

// DIFF: ofVideoGrabber.h: ignore getGrabber/setGrabber
%ignore setGrabber(shared_ptr<ofBaseVideoPlayer>);
%ignore getGrabber();
%ignore getGrabber() const;

%include "video/ofVideoGrabber.h"

// ----- ofVideoPlayer.h -----

// DIFF: ofVideoPlayer.h: ignore getPlayer/setPlayer
%ignore setPlayer(shared_ptr<ofBaseVideoPlayer>);
%ignore getPlayer();
%ignore getPlayer() const;

%include "video/ofVideoPlayer.h"
