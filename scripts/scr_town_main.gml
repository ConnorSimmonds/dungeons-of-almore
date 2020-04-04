#define scr_town_main
//scr_town_main
if(keyboard_check_pressed(vk_space)){
    state = menuSelect + 1;
}

if(menuOptions != MAIN_OPTIONS) menuOptions = MAIN_OPTIONS;
if(menuMax != MAIN_MAX) menuMax = MAIN_MAX;

#define scr_town_dungeon
//scr_town_dungeon
//Takes us to the dungeon
room_goto(rm_dungeon);
