#define scr_party_add
//scr_party_add
//Adds a party member to the party

#define scr_party_remove
//scr_party_remove

#define scr_party_create

#define scr_party_delete
//scr_party_delete

#define scr_party_manage
//scr_party_manage
//Allows you to select a party member, and move them around if needed
if(keyboard_check_pressed(vk_shift)){
    menuSelect = state - 10;
    //save the new order to settings.ini, really quickly
    ini_open("settings.ini");
    var i, name;
    for(i = 0; i < 5; i++){
        with(obj_party) {
            name = ds_map_find_value(character[i],NAMES)
            ini_write_string('Party',i,name);
        }
    }
    ini_close();
    state = STATE_PARTY;
}

if(keyboard_check_pressed(vk_space)){
    if(t_var == -1){
        t_var = menuSelect;
    } else {
        if(t_var != menuSelect){
            with(obj_party){
                scr_swap_members(obj_town.t_var,obj_town.menuSelect); 
            }
        } else {
            
        } 
        t_var = -1;
    }
}

if(menuMax != obj_party.partySize) menuMax = obj_party.partySize;
