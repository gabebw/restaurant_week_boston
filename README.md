# Restaurant Week Boston

This is just a silly little gem I made that parses the [Restaurant Week
Boston](http://www.restaurantweekboston.com/) website and lets you mark which
ones you want to go to for lunch, dinner, or lunch and dinner. This gem assumes
you have a few restaurants in mind and want to quickly compare their
lunch/dinner menus. It prints out direct links to lunch/dinner menus, which you
can then open in your browser or send to a friend.

## Installation

    gem install restaurant_week_boston

##  Usage

Use the `restaurant_week_boston` command line script. Call it with `--help` for
help.

So if you want to go to Bond and Aquitaine Bis for lunch or dinner, you'd do:

    $ restaurant_week_boston --any 'aquitaine bis',bond

If you want to check out Artu for lunch:

    $ restaurant_week_boston --lunch artu

Or maybe Artu's dinner sounds better:

    $ restaurant_week_boston --dinner artu

### More involved demo

    $ restaurant_week_boston -a 'aquitaine bis' -l bond,asana -d bergamot,clink
    Getting doc...done.
    Parsing doc...done.

    === LUNCH ===
    Name: Asana
    Meals: Lunch, Dinner
    Neighborhood: Back Bay
    Phone: 617-535-8800
    Lunch Menu: http://www.restaurantweekboston.com/fetch/asana/lunch/
    Dinner Menu: http://www.restaurantweekboston.com/fetch/asana/dinner/
    Map: http://www.restaurantweekboston.com/map/back-bay/asana/#topOfMap
    --------------------------------------------------------------------------------
    Name: Bond
    Meals: Lunch, Dinner
    Neighborhood: Downtown
    Phone: 617-451-1900
    Lunch Menu: http://www.restaurantweekboston.com/fetch/bond/lunch/
    Dinner Menu: http://www.restaurantweekboston.com/fetch/bond/dinner/
    Map: http://www.restaurantweekboston.com/map/downtown/bond/#topOfMap

    === DINNER ===
    Name: Bergamot
    Meals: Dinner
    Neighborhood: Somerville
    Phone: <no phone given>
    Dinner Menu: http://www.restaurantweekboston.com/fetch/bergamot/dinner/
    Map: http://www.restaurantweekboston.com/map/somerville/bergamot/#topOfMap
    --------------------------------------------------------------------------------
    Name: Clink. at the Liberty Hotel
    Meals: Lunch, Dinner
    Neighborhood: Beacon Hill
    Phone: 617-224-4004
    Lunch Menu: http://www.restaurantweekboston.com/fetch/clink/lunch/
    Dinner Menu: http://www.restaurantweekboston.com/fetch/clink/dinner/
    Map: http://www.restaurantweekboston.com/map/beacon-hill/clink/#topOfMap

    === LUNCH OR DINNER ===
    Name: Aquitaine Bis
    Meals: Lunch, Dinner
    Neighborhood: Chestnut Hill
    Phone: 617-734-8400
    Lunch Menu: http://www.restaurantweekboston.com/fetch/aquitaine-bis/lunch/
    Dinner Menu: http://www.restaurantweekboston.com/fetch/aquitaine-bis/dinner/
    Map: http://www.restaurantweekboston.com/map/chestnut-hill/aquitaine-bis/#topOfMap
