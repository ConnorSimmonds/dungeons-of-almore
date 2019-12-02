#define scr_menu
//scr_menu
//Contains all the menu logic
if(keyboard_check_pressed(vk_up)){
    menu--;
    
} else if(keyboard_check_pressed(vk_down)){
    menu++;
    
}

#define scr_menu_combat
//scr_menu_combat
//Logic for the combat menus
if(keyboard_check_pressed(vk_up)){
    menu--;
    
    if(menu < ATTACK_OPTION){
        menu = FLEE_OPTION;
    }
} else if(keyboard_check_pressed(vk_down)){
    menu++;
    
    if(menu > FLEE_OPTION){
        menu = ATTACK_OPTION;
    }
} else if(keyboard_check_pressed(vk_space)){
    scr_combat_select_main();
} else if(keyboard_check_pressed(vk_shift)){
    
}

//Android/Mouse controls
if(device_mouse_check_button(0,mb_left)){
    if(device_mouse_x_to_gui(0) < selectWidth){
        if(device_mouse_y_to_gui(0) >= 48*guiScale && device_mouse_y_to_gui(0) <= (sprite_get_height(spr_menuBar))*guiScale){
            menu = floor((device_mouse_y_to_gui(0) - (48*guiScale))/(18*guiScale))
        }
    }
} else if(device_mouse_check_button_released(0,mb_left)){
    if(device_mouse_x_to_gui(0) < selectWidth){
        if(device_mouse_y_to_gui(0) >= 48*guiScale && device_mouse_y_to_gui(0) < sprite_get_height(spr_menuBar)*guiScale){
            scr_combat_select_main();
        }
    }
}

#define scr_combat_state
//scr_combat_state
//Manages the state of combat, which dictates what the menus can/can't do
switch(state){
    case(STATE_MAIN):{
        scr_menu_combat();
        break;
    }
    case(STATE_ATTACK):{
        scr_attack_script();
        break;
    }
    case(STATE_SKILL):{
        scr_skill_script();
        break;
    }
    case(STATE_DEFEND):{
        break;
    }
    case(STATE_ITEM):{
        break;
    }
    case(STATE_DOUBLE_ATTACK):{
        break;
    }
    case(STATE_FLEE):{
        break;
    }
    case(STATE_TARGET):{
        scr_target_script();
        break;
    } case(STATE_TURN_END):{
        scr_turn_end();
        break;
    } case(STATE_EXECUTE):{
        scr_turn_execute(); //Based off of that information, we execute the turn order
    }
}

#define scr_combat_select_main
prevState = state;
    switch(menu){
        case(ATTACK_OPTION): state = STATE_ATTACK; break;
        case(SKILL_OPTION): state = STATE_SKILL; break;
        case(DEFEND_OPTION): state = STATE_DEFEND; break;
        case(ITEM_OPTION): state = STATE_ITEM; break;
        case(DOUBLE_OPTION): state = STATE_DOUBLE_ATTACK; break;
        case(FLEE_OPTION): state = STATE_FLEE; break;
    }
#define scr_turn_end
//scr_turn_end
//Ends the turn
if(playerSelect < 4){
    playerSelect++;
    state = STATE_MAIN;
} else {
    state = STATE_EXECUTE;
}

#define scr_turn_back
//scr_turn_back
//Ends the turn
if(playerSelect != 0){ 
    playerSelect--;
    state = STATE_MAIN;
} else {
    //give some feedback
}

#define scr_combat_execute
//scr_combat_execute