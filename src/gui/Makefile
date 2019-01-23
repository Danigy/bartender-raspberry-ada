PRJ=test_gui

all: gui



.PHONY: clean

gui:
	gprbuild #$(CC) $(CFLAGS) test_gui.adb

clean:
	$(RM) *.o *.ali *.std* *.bexch b__$(PRJ).* $(PRJ)
