PRJ=bartender

all: gui

.PHONY: clean

gui: clean
	gprbuild 

clean:
	$(RM) *.cgpr *.deps *.a *.d *.o *.ali *.std* *.bexch b__$(PRJ).* $(PRJ)
