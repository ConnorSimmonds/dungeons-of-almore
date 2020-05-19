#define scr_town_main
//scr_town_main
if(keyboard_check_pressed(vk_space)){
    state = menuSelect[0] + 1;
    menuSelect[0] = 0;
}

if(menuOptions != MAIN_OPTIONS) menuOptions = MAIN_OPTIONS;
if(menuMax != MAIN_MAX) menuMax = MAIN_MAX;

#define scr_town_party
//scr_town_party
if(keyboard_check_pressed(vk_space)){
    switch(menuSelect[0]){
        case(0): partyNames = scr_update_party_names(partyNames);
        state = STATE_PARTY_ADD;
        menuSelect[1] = 0;
        t_var = -1;  break;
        case(1): state = STATE_PARTY_REMOVE;
        menuSelect[1] = 0;
        t_var = -1;  break;
        case(2): partyNames = scr_update_party_names(partyNames);
        state = STATE_PARTY_MANAGE;
        menuSelect[1] = 0;
        t_var = -1; 
        break;
        case(3): state = STATE_PARTY_CREATE; break;
        case(4): state = STATE_PARTY_REMOVE; break;
        case(5): state = STATE_MAIN; 
            with(obj_party){
                scr_open_json();
                scr_close_json();
            }
            menuSelect[0] = STATE_PARTY-1; break;
    }
}

if(keyboard_check_pressed(vk_shift)){
    state = STATE_MAIN;
    with(obj_party){
        scr_open_json();
        scr_close_json();
    }
    menuSelect[0] = STATE_PARTY-1;
}

if(menuOptions != PARTY_OPTIONS) menuOptions = PARTY_OPTIONS;
if(menuMax != PARTY_MAX) menuMax = PARTY_MAX;

#define scr_town_dungeon
//scr_town_dungeon
//Takes us to the dungeon
room_goto(rm_dungeon);