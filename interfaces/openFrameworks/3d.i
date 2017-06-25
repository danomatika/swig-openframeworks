// 3d folder bindings
// 2017 Dan Wilcox <danomatika@gmail.com>

// ----- ofNode.h -----

// DIFF: ofNode.h: ignoring const & copy constructor in favor of && constructor
%ignore ofNode::ofNode(ofNode const &);

// process ofNode first since it's a base class
%include "3d/ofNode.h"

// ----- of3dUtils.h -----

%include "3d/of3dUtils.h"

// ----- ofCamera.h -----

%include "3d/ofCamera.h"

// ----- ofEasyCam.h -----

%include "3d/ofEasyCam.h"

// ----- ofMesh.h -----

// tesselator index
#ifdef TARGET_OPENGLES
	%typedef unsigned short TESSindex;
#else
	%typedef unsigned int TESSindex;
#endif

// add ofMesh virtual destructor
%extend ofMesh {
	virtual ~ofMesh() {
		$self->clear();
		delete $self;
	}
};

%include "3d/ofMesh.h"

// ----- of3dPrimitives.h -----

%include "3d/of3dPrimitives.h"
