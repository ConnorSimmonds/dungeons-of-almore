#define scr_town_main
//scr_town_main
if(keyboard_check_pressed(vk_space)){
    state = menuSelect + 1;
    menuSelect = 0;
}

if(menuOptions != MAIN_OPTIONS) menuOptions = MAIN_OPTIONS;
if(menuMax != MAIN_MAX) menuMax = MAIN_MAX;

#define scr_town_party
//scr_town_party
if(keyboard_check_pressed(vk_space)){
    switch(menuSelect){
        case(0): state = STATE_PARTY_ADD; break;
        case(1): state = STATE_PARTY_REMOVE; break;
        case(2): state = STATE_PARTY_MANAGE; break;
        case(3): state = STATE_PARTY_CREATE; break;
        case(4): state = STATE_PARTY_REMOVE; break;
        case(5): state = STATE_MAIN; menuSelect = STATE_PARTY-1; break;
    }
}

if(keyboard_check_pressed(vk_shift)){
    state = STATE_MAIN;
    menuSelect = STATE_PARTY-1;
}

if(menuOptions != PARTY_OPTIONS) menuOptions = PARTY_OPTIONS;
if(menuMax != PARTY_MAX) menuMax = PARTY_MAX;

#define scr_town_dungeon
//scr_town_dungeon
//Takes us to the dungeon
room_goto(rm_dungeon);
