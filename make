.PHONY: clean check default show

FILES=$(sort $(wildcard *cpp))
BINARIES=$(patsubst %.cpp,%,$(FILES))

#TARGET=raytracer2
TARGET=$(lastword $(BINARIES))
THREADS=4

ifeq ($(DEBUG),yes)
  CXXFLAGS=-std=c++11 -pthread -g -O0 -Wall -pedantic -D_GLIBCXX_DEBUG -fopenmp
else
  CXXFLAGS=-std=c++11 -pthread -O3 -Wall -march=native -fopenmp
#  CXXFLAGS=-std=c++11 -pthread -O3 -Wall -march=native -DNOPPM
endif

default: $(TARGET) check


check: 
	time -p ./$(TARGET) $(THREADS)
	md5sum untitled.ppm
	@echo "09042d2566e20716029330d16850b1b8  reference.ppm (reference for 100 spheres)"

show: 
	@echo "FILES:    $(FILES)"
	@echo "BINARIES: $(BINARIES)"
	@echo "TARGET:   $(TARGET)"

clean:
	rm -f $(BINARIES)
	rm -f *~ untitled.ppm 
