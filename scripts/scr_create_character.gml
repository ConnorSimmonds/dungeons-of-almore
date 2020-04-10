#define scr_create_character
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
scr_character_json(character);
return character;

#define scr_character_json
//scr_character_json
//adds the character map given to the party.json file
var file, json_string;
json_string = json_encode(argument0);
file = file_text_open_write("party.json");
file_text_write_string(file,json_string);
file_text_close(file);
global.json_hash = md5_file("party.json");

