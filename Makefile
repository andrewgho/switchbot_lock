# Makefile - create STL files from OpenSCAD source
# Andrew Ho (andrew@zeuscat.com)

ifeq ($(shell uname), Darwin)
  OPENSCAD = /Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD
else
  OPENSCAD = openscad
endif

TARGETS = adapter.stl

all: $(TARGETS)

adapter.stl: printable.scad adapter.scad thumbturn.scad spindle.scad
	$(OPENSCAD) -o adapter.stl printable.scad

clean:
	@rm -f $(TARGETS)
