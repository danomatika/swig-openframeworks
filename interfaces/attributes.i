/*
	scripting language attributes to add using getters/setters 

	2015 Dan Wilcox <danomatika@gmail.com>
*/

// ATTR: ofFbo.h: getter: allocated, texture, depthTexture, width, height,
// ATTR: ofFbo.h:         numTextures, id, idDrawBuffer, depthBuffer, stencilBuffer
// ATTR: ofFbo.h: getter/setter: defaultTexture
%attribute(ofFbo, bool, allocated, isAllocated);
%attribute(ofFbo, int, defaultTexture, getDefaultTextureIndex, setDefaultTextureIndex);
%attribute(ofFbo, ofTexture &, texture, getTexture);
%attribute(ofFbo, ofTexture &, depthTexture, getDepthTexture);
%attribute(ofFbo, float, width, getWidth);
%attribute(ofFbo, float, height, getHeight);
%attribute(ofFbo, int, numTextures, getNumTextures);
%attribute(ofFbo, unsigned int, id, getId);
%attribute(ofFbo, unsigned int, idDrawBuffer, getIdDrawBuffer);
%attribute(ofFbo, unsigned int, depthBuffer, getDepthBuffer);
%attribute(ofFbo, unsigned int, stencilBuffer, getStencilBuffer);

// ATTR: ofTexture.h: getter: allocated, width, height, usingTextureMatrix, textureData
// ATTR: ofTexture.h: getter/setter: textureMatrix
%attribute(ofTexture, bool, allocated, isAllocated);
%attribute(ofTexture, float, width, getWidth);
%attribute(ofTexture, float, height, getHeight);
%attribute(ofTexture, ofMatrxi4x4 &, textureMatrix, getTextureMatrix, setTextureMatrix);
%attribute(ofTexture, bool, usingTextureMatrix, isUsingTextureMatrix);
%attribute(ofTexture, ofTextureData &, textureData, getTextureData);

// ATTR: ofImage.h: getter: allocated, texture, pixels, width, height, imageType
// ATTR: ofImage.h: getter/setter: usingTexture
%attribute(ofImage_<unsigned char>, bool, allocated, isAllocated);
%attribute(ofImage_<unsigned char>, bool, usingTexture, isUsingTexture, setUseTexture);
%attribute(ofImage_<unsigned char>, ofTexture &, texture, getTexture);
%attribute(ofImage_<unsigned char>, ofPixels &, pixels, getPixels);
%attribute(ofImage_<unsigned char>, float, width, getWidth);
%attribute(ofImage_<unsigned char>, float, height, getHeight);
%attribute(ofImage_<unsigned char>, ofImageType, imageType, getImageType, setImageType);

%attribute(ofImage_<float>, bool, allocated, isAllocated);
%attribute(ofImage_<float>, bool, usingTexture, isUsingTexture, setUseTexture);
%attribute(ofImage_<float>, ofTexture &, texture, getTexture);
%attribute(ofImage_<float>, ofPixels &, pixels, getPixels);
%attribute(ofImage_<float>, float, width, getWidth);
%attribute(ofImage_<float>, float, height, getHeight);
%attribute(ofImage_<float>, ofImageType, imageType, getImageType, setImageType);

%attribute(ofImage_<unsigned short>, bool, allocated, isAllocated);
%attribute(ofImage_<unsigned short>, bool, usingTexture, isUsingTexture, setUseTexture);
%attribute(ofImage_<unsigned short>, ofTexture &, texture, getTexture);
%attribute(ofImage_<unsigned short>, ofPixels &, pixels, getPixels);
%attribute(ofImage_<unsigned short>, float, width, getWidth);
%attribute(ofImage_<unsigned short>, float, height, getHeight);
%attribute(ofImage_<unsigned short>, ofImageType, imageType, getImageType, setImageType);

// ATTR: ofSoundStream.h: getter: tickCount, numInputChannels, numOutputChannels,
// ATTR: ofSoundStream.h:         sampleRate, bufferSize
%attribute(ofSoundStream, unsigned long, tickCount, getTickCount);
%attribute(ofSoundStream, int, numInputChannels, getNumInputChannels);
%attribute(ofSoundStream, int, numOutputChannels, getNumOutputChannels);
%attribute(ofSoundStream, int, sampleRate, getSampleRate);
%attribute(ofSoundStream, int, bufferSize, getBufferSize);

// ATTR: ofSoundPlayer.h: getter: playing, loaded
// ATTR: ofSoundPlayer.h: getter/setter: volume, pan, speed, position, positionMS
%attribute(ofSoundPlayer, float, volume, getVolume, setVolume);
%attribute(ofSoundPlayer, float, pan, getPan, setPan);
%attribute(ofSoundPlayer, float, speed, getSpeed, setSpeed);
%attribute(ofSoundPlayer, float, position, getPosition, setPosition);
%attribute(ofSoundPlayer, int, positionMS, getPositionMS, setPositionMS);
%attribute(ofSoundPlayer, bool, playing, isPlaying);
%attribute(ofSoundPlayer, bool, loaded, isLoaded);

// ATTR: ofFpsCounter.h: getter: fps, numFrames, lastFrameNanos, lastFrameSecs
%attribute(ofFpsCounter, double, fps, getFps);
%attribute(ofFpsCounter, uint64_t, numFrames, getNumFrames);
%attribute(ofFpsCounter, uint64_t, lastFrameNanos, getFrameNanos);
%attribute(ofFpsCounter, double, lastFrameSecs, getLastFrameSecs);

// ATTR: ofBufferObject.h: getter: allocated, id
%attribute(ofBufferObject, bool, allocated, isAllocated);
%attribute(ofBufferObject, unsigned int, id, getId);

// ATTR: ofPixels.h: getter: width & height
%attribute(ofPixels_<unsigned char>, float, width, getWidth);
%attribute(ofPixels_<unsigned char>, float, height, getHeight);

%attribute(ofPixels_<float>, float, width, getWidth);
%attribute(ofPixels_<float>, float, height, getHeight);

%attribute(ofPixels_<unsigned short>, float, width, getWidth);
%attribute(ofPixels_<unsigned short>, float, height, getHeight);

// ATTR: ofTrueTypeFont.h: getter/setter: lineHeight, letterSpacing, & spaceSize
%attribute(ofTrueTypeFont, float, lineHeight, getLineHeight, setLineHeight);
%attribute(ofTrueTypeFont, float, letterSpacing, getLetterSpacing, setLetterSpacing);
%attribute(ofTrueTypeFont, float, spaceSize, getSpaceSize, setSpaceSize);
