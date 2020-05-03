#define scr_create_character
//scr_create_character(name, class, max_hp, max_hp, skills, attack, defense, speed, portrait [optional: current hp, current mp, current exp])
//returns an array of the character attributes.
var num, character;
character = ds_map_create();
if(argument_count < 11){ //it's a new character
    character[? HP] = argument[2]; //current hp
    character[? MP] = argument[3]; //current mp
    character[? EXP_PTS] = 0; //our current exp
}

for(i = 0; i < argument_count; i++){ //Just run through all of our arguments
    character[? string(i)] = argument[i]; //Each section correlates to the constants in obj_party
}
scr_character_json(character,true);
return character;

#define scr_character_json
//scr_character_json(character_map,is new character?)
//adds the character map given to the party.json file
var json_string, is_create, str, json_start;
json_string = argument0[? NAMES];
is_create = argument1;
if(is_create){
    ds_map_add_map(entireParty,json_string,argument0);
}

#define scr_load_party
//scr_load_party
//Loads in an ENTIRE party from the json file (I know)
if(md5_file("party.json") == global.party_hash){
    //then we load it in
    global.entire_party = json_decode("party.json");
}

#define scr_open_json
//scr_open_json
//Returns the ENTIRE json file
//That's right, the ENTIRE json file
file_text_close(global.party_json); //we close it, on the off-chance we've opened it already
global.party_json = file_text_open_write("party.json");

#define scr_close_json
//scr_close_json
var json_str;
json_str = json_encode(entireParty);
file_text_write_string(global.party_json,json_str);
file_text_close(global.party_json);
global.party_hash = md5_file("party.json");

#define scr_character_check
//scr_character_check
//checks to see if we have anything in party.json, and if so, we load in the relevant party members from the settings.ini file
//if(file_exists("party.json")){ //first off, check if we even have it. This is always a great way to start.
    global.party_json = file_text_open_read("party.json");
    if(!file_text_eof(global.party_json)){
        return true;
    } else {
        return false;
    }

#define scr_character_load
//scr_character_load
//Using the information from party.json and settings.ini, we load in our party
var i, name, size;
ini_open("settings.ini");
global.party_json = file_text_open_read("party.json")
ds_map_destroy(entireParty); //quickly destroy this so we don't get mem leaks
entireParty = json_decode(file_text_readln(global.party_json));

size = -1;
for(i = 0; i < 6; i++){
    name = ini_read_string('Party',i,"");
    if(name != ""){
        character[i] = entireParty[? name]
        size++;
        formation[i/2,i mod 2] = i;
    }
}
ini_close();
return size;

#define scr_json_update
//scr_json_update
//That's right, we're going to update our json. This is going to be trash
scr_open_json();
scr_close_json();

//That's it