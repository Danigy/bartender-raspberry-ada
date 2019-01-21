CC = gnatmake

all: bottle

.PHONY: clean

bottle:
	$(CC) bottles.adb test_bottle.adb

clean:
	$(RM) *.o *.ali test_bottle
