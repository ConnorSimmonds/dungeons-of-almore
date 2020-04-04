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
    case(STATE_DUNGEON): scr_town_dungeon(); break;
}
