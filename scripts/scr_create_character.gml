//scr_create_character(name, class, max_hp, max_hp, skills, attack, defense, speed [optional: current hp, current mp, current exp])
//returns an array of the character attributes.
var num, character;

if(argument_count < 8){ //it's a new character
    character[9] = argument[2]; //current hp
    character[10] = argument[3]; //current mp
    character[11] = 0; //our current exp
}

for(i = 0; i < argument_count; i++){ //Just run through all of our arguments
    character[i] = argument[i]; //Each section correlates to the constants in obj_party
}

return character;
