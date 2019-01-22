CC = gnatmake

all: recipe

.PHONY: clean

all: recipe recipe_csv

recipe:
	$(CC) test_recipe.adb
recipe_csv:
	$(CC) recipe_csv.adb test_csv.adb

clean:
	$(RM) *.o *.ali test_recipe test_csv
