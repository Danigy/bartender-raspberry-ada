# Bartender

## Requirements

- GtkAda is required to run this program
- This program needs to be run on a raspberry pi

## How to run

    - make
    - ./bartender

## Equipment

This is a list of equipment we used during the project:
* Raspberry pi 3B
* Peristaltic pumps 12V
* Relay
* Silicone tubing - 3 and 4 mm

## Configuration

### Pumps (pumps.csv)

The pump configuration file needs to be correctly formated as it is essential
for the programm to function properly.

format:
`GpioNumber,Flow,IngredientName,Quantity`
Gpio number -> number of the GPIO on wich is plugged the pump.
Flow -> Pump flow in milliter per seconds
IngredientName -> Name of the bottle content
Quantity -> Ingredient quantity in milliliters

For our test we had pumps pluged on GPIO 2, 3, 4 and 17.

If you use the same configuration as us (GPIO or flow), there is no need
to change the default csv, bottle changes are handled from
the graphic interface. The configuration file is automatically updated
when bottles are use or changed.

Be carefull while choosing your pumps.
We used pumps with very low flow and it takes time to do coktails with them.
We also used pumps with very high flow and the volumes aren't that accurate.


### Recipes (recipes.csv)

Be carefull on how you name your ingredients, they must match your bottle names.

There is no need to change manually the configuration file, new recipes
can be added from the graphic interface.

format:
`RecipeName,IngredientsNumber,IngredientName, Volume, ...`
RecipeName -> Name of the cocktail that will be displayed
IngredientsNumber -> Number of ingredients in the cocktail
IngredientName -> Name of the ingredient
Volume -> Required volume of the ingredient in millimeter

There must be as much pair of name and volume of ingredient as the
given number of ingredients.
