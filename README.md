# Bartender

## How to run

    - make
    - ./bartender

## Configuration

### Pumps (pumps.csv)

The default configuration assumes that you have pumps pluged on GPIO 2, 3, 4 and
17. 
The pump configuration file needs to be correctly formated as it is essential
for the programm to function properly.

format:
`GpioNumber,Flow,IngredientName,Quantity`
Gpio number -> number of the GPIO on wich is plugged the pump.
Flow -> Pump flow in milliter by seconds
IngredientName -> Name of the bottle content
Quantity -> Ingredient quantity in milliliters

If no change are made on the pump (GPIO or flow), there is no need
to change the default configuration, bottle changes are handled from
the graphic interface. The configuration file is automatically updated
when bottles are use or changed.

### Recipes (recipes.csv)

format:
`RecipeName,IngredientsNumber,IngredientName, Volume, ...`
RecipeName -> Name of the cocktail
IngredientsNumber -> Number of ingredients in the cocktail
IngredientName -> Name of the ingredient
Volume -> Required volume of the ingredient in millimeter

There must be as much pair of name and volume of ingredient as the
given number of ingredients.

There is no need to change manually the configuration file, new recipes
can be added from the graphic interface.

## Requirements

- GtkAda is required to run this program
- This program needs to be run on a raspberry pi

## Equipment

This is a list of equipment we used during the project:
* Raspberry pi 3B
* Peristaltic pumps 12V
* Relay
* Silicone tubing - 3 and 4 mm
