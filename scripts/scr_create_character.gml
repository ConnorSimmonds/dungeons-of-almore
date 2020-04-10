//scr_create_character(name, class, max_hp, max_hp, skills, attack, defense, speed [optional: current hp, current mp, current exp])
//returns an array of the character attributes.
var num, character;
character = ds_map_create();
if(argument_count < 11){ //it's a new character
    character[? HP] = argument[2]; //current hp
    character[? MP] = argument[3]; //current mp
    character[? EXP_PTS] = 0; //our current exp
}

for(i = 0; i < argument_count; i++){ //Just run through all of our arguments
    character[? i] = argument[i]; //Each section correlates to the constants in obj_party
}

return character;
