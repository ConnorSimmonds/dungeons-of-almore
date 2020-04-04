#define scr_town
//scr_town
//Handles all of the menu selection logic
if(keyboard_check_pressed(vk_up)){
    menuSelect--;
} else if(keyboard_check_pressed(vk_down)){
    menuSelect++;
}

if(menuSelect > menuMax){
    menuSelect = 0;
} else if(menuSelect < 0){
    menuSelect = menuMax;
}

#define scr_town_state
//scr_town_state(state)
//Calls the corresponding script to the current state
switch(argument0){
    case(STATE_MAIN): scr_town_main(); break;
    case(STATE_PARTY): scr_town_party(); break;
    case(STATE_DUNGEON): scr_town_dungeon(); break;
    
    case(STATE_PARTY_ADD): scr_party_add(); break;
    case(STATE_PARTY_REMOVE): scr_party_remove(); break;
    case(STATE_PARTY_CREATE): scr_party_create(); break;
    case(STATE_PARTY_DELETE): scr_party_delete(); break;
    case(STATE_PARTY_MANAGE): scr_party_manage(); break;
}
