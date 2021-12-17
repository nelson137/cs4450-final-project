# Pokemon master name
name = "Ash Ketchum"

# Pokemon Health Points
charmender_HP = 110
squirtle_HP = 125
bulbasaur_HP = 150

# Pokemon Attack Points
charmender_attack = 40
squirtle_attack = 35
bulbasaur_attack = 25

turn = 1

# Print winner pokemon
if charmender_HP >= 1:
    print(name+"'s Charmender won!")
elif squirtle_HP >= 1:
    print(name+"'s Squirtle won!")
else:
    print("Something went wrong!!!")
