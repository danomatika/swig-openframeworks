// Python specific code

// ----- pythoncode -----

%pythoncode %{

# handle typedefs which swig doesn't wrap
ofPoint = ofVec3f

# renaming log -> ofLog
ofLog = log
del log

%}