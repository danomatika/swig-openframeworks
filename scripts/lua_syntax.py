#! /usr/bin/python
#
# convert the swig -debug-lsymbols output text file format into
# a simple list of lua module names and classes
#
# Dan Wilcox <danomatika@gmail.com> 2017
#
import sys
import re

if len(sys.argv) < 2:
    print("USAGE: lua_syntax.py MODULENAME INFILE")
    exit(0)

module = sys.argv[1]
infile = sys.argv[2]
sections = []
sectionIgnores = [ 
    "Vector",     # swig std::vector wrappers
    "  \n"        # weird empty line toward the beginning
]
lineIgnores = [ 
    "SwigStatic", # swig static class creators
    "Vector",     # swig std::vector wrappers
    "~",          # destructors
    "__",         # lua metatable __add, __sub, etc
    "lua:cdata",  # c pointers
]

for arg in sys.argv[3:]:
    sectionIgnores.append(arg)

# parse swig output into sections
file = open(infile)
section = []
for line in file:
    # ignore beginning and end lines
    if line.startswith("LANGUAGE"):
        continue
    # section headers are a series of = chars
    if line.startswith("="):
        if len(section) > 0 and not any(x in section[0] for x in sectionIgnores):
            sections.append(section)
        section = []
    # line within a section
    else:
        line = line.strip()
        if len(line) > 0:
            section.append(line)
file.close()
section = []

# output module & section names to each section line
file = open(module+"_syntax.txt", "w") 
for section in sections:
    # grab name from first line and output
    prefix = module
    className = ""
    match = re.match("\w+", section[0])
    if match: # found a class name
        className = match.group(0)
        prefix = module + "." + className
    if className == "string":
        continue
    # sort remaining lines and output with module.class prefix
    lines = section[1:]
    lines.sort()
    for line in lines:
        if line != "of"+className and not any(x in line for x in lineIgnores):
            file.write(prefix+"."+line+"\n")
file.close()
