// deprecations to ignore (aka not wrapped),
// these are functions wrapped by the OF_DEPRECATED_MSG macro
// 2015 Dan Wilcox <danomatika@gmail.com>

// ----- ofFbo.h -----

%ignore ofFbo::destroy;
%ignore ofFbo::getTextureReference;
%ignore ofFbo::getFbo;

// ----- ofTexture.h -----

%ignore ofSetTextureWrap;
%ignore ofGetUsingCustomTextureWrap;
%ignore ofRestoreTextureWrap;
%ignore ofSetMinMagFilters;
%ignore ofGetUsingCustomMinMagFilters;
%ignore ofRestoreMinMagFilters;
%ignore ofTexture::bAllocated;
%ignore ofTexture::getTextureReference;
%ignore ofTexture::texData;

// ----- ofImage.h -----

%ignore ofImage_::bAllocated;
%ignore ofImage_::loadImage;
%ignore ofImage_::getTextureReference;
%ignore ofImage_::getPixelsRef;
%ignore ofImage_::getPixels;
%ignore ofImage_::saveImage;

// ----- ofSoundStream.h -----

%ignore ofSoundStream::listDevices;

// ----- ofSoundPlayer.h -----

%ignore ofSoundPlayer::loadSound;
%ignore ofSoundPlayer::unloadSound;
%ignore ofSoundPlayer::getIsPlaying;

// ----- ofURLFileLoader.h -----

%ignore ofHttpRequest::getID;

// ----- ofAppRunner.h -----

%ignore ofSetupOpenGL(ofAppBaseWindow *, int, int, int);
%ignore ofRunApp(ofBaseApp *);

// ----- ofSerial.h -----

%ignore ofSerial::enumerateDevices;

// ----- ofPixels.h -----

%ignore ofPixels_::getPixels;
%ignore ofPixels_::operator PixelType*();
%ignore ofPixels_::operator const PixelType*();

// ----- ofPath.h -----

%ignore ofPath::setArcResolution;
%ignore ofPath::getArcResolution;

// ----- ofGraphics.h -----

%ignore ofGetBackground();
%ignore ofbClearBg;
%ignore ofTriangle;
%ignore ofCircle;
%ignore ofEllipse;
%ignore ofLine;
%ignore ofRect;
%ignore ofRectRounded;
%ignore ofCurve;
%ignore ofBezier;
%ignore ofSetupScreenPerspective(float, float, ofOrientation);
%ignore ofSetupScreenPerspective(float, float, ofOrientation, bool);
%ignore ofSetupScreenPerspective(float, float, ofOrientation, bool, float);
%ignore ofSetupScreenPerspective(float, float, ofOrientation, bool, float, float);
%ignore ofSetupScreenPerspective(float, float, ofOrientation, bool, float, float, float);
%ignore ofSetupScreenOrtho(float, float, ofOrientation);
%ignore ofSetupScreenOrtho(float, float, ofOrientation, bool);
%ignore ofSetupScreenOrtho(float, float, ofOrientation, bool, float);
%ignore ofSetupScreenOrtho(float, float, ofOrientation, bool, float, float);

// ----- of3dGraphics.h -----

%ignore ofSphere;
%ignore ofCone;
%ignore ofBox;

// ----- ofTrueTypeFont.h -----

%ignore ofTrueTypeFont::loadFont;

// ----- ofVec2f.h -----

%ignore ofVec2f::rescaled;
%ignore ofVec2f::rescale;
%ignore ofVec2f::rotated;
%ignore ofVec2f::normalized;
%ignore ofVec2f::limited;
%ignore ofVec2f::perpendiculared;
%ignore ofVec2f::interpolated;
%ignore ofVec2f::middled;
%ignore ofVec2f::mapped;
%ignore ofVec2f::distanceSquared;
%ignore ofVec2f::rotated;

// ----- ofVec3f.h -----

%ignore ofVec3f::rescaled;
%ignore ofVec3f::rescale;
%ignore ofVec3f::rotated;
%ignore ofVec3f::normalized;
%ignore ofVec3f::limited;
%ignore ofVec3f::crossed;
%ignore ofVec3f::perpendiculared;
%ignore ofVec3f::mapped;
%ignore ofVec3f::distanceSquared;
%ignore ofVec3f::interpolated;
%ignore ofVec3f::middled;
%ignore ofVec3f::rotated;

// ----- ofVec4f.h -----

%ignore ofVec4f::rescaled;
%ignore ofVec4f::rescale;
%ignore ofVec4f::normalized;
%ignore ofVec4f::limited;
%ignore ofVec4f::distanceSquared;
%ignore ofVec4f::interpolated;
%ignore ofVec4f::middled;

// ----- ofFileUtils.h -----

%ignore ofBuffer::getBinaryBuffer();
%ignore ofBuffer::getBinaryBuffer() const;
%ignore ofBuffer::getNextLine();
%ignore ofBuffer::getFirstLine();
%ignore ofBuffer::isLastLine();
%ignore ofBuffer::resetLineReader();
%ignore ofDirectory::numFiles();

// ----- ofVideoGrabber.h -----

%ignore ofVideoGrabber::initGrabber;
%ignore ofVideoGrabber::getPixelsRef;
%ignore ofVideoGrabber::getTextureReference;

// ----- ofVideoPlayer.h -----

%ignore ofVideoPlayer::initGrabber;
%ignore ofVideoPlayer::loadMovie;
%ignore ofVideoPlayer::getPixelsRef;
%ignore ofVideoPlayer::getTextureReference;
