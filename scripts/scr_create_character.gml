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
scr_character_json(character,true);
partySize++;
return character;

#define scr_character_json
//scr_character_json(character_map,is new character?, json_file)
//adds the character map given to the party.json file
var file, json_string, is_create, str;
json_string = json_encode(argument0);
is_create = argument1;
if(is_create){
    //This is if we have a NEW character
    json_string = json_encode(argument0);
    if(partySize >= 0) {
        json_start = ',"' + argument0[? NAMES] + '" : ';
    } else {
        json_start = '"' + argument0[? NAMES] + '" : ';
    }
    file_text_write_string(global.party_json,json_start + json_string);
    global.party_hash = md5_file("party.json");
}

#define scr_load_party
//scr_load_party
//Loads in an ENTIRE party from the json file (I know)
var party;
if(md5_file("party.json") == global.party_hash){
    //then we load it in
    party = json_decode("party.json");
}

#define scr_open_json
//scr_open_json
//Returns the ENTIRE json file
//That's right, the ENTIRE json file
file_text_close(global.party_json); //we close it, on the off-chance we've opened it already
global.party_json = file_text_open_write("party.json");
file_text_write_string(global.party_json,"{"); //initial json value

#define scr_close_json
//scr_close_json
file_text_write_string(global.party_json,"}");
file_text_close(global.party_json);

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
var i, name, size, entire_party;
ini_open("settings.ini");
global.party_json = file_text_open_read("party.json")
entire_party = json_decode(file_text_readln(global.party_json));
//firstly, check to see if it's an entire structure or not


size = -1;
for(i = 0; i < 5; i++){
    name = ini_read_string('Party',i,"");
    if(name != ""){
        character[i] = entire_party[? name]
        size++;
    }
}
ini_close();
return size;
