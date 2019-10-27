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
}

if(keyboard_check_pressed(vk_down)){
    menu++;
    
    if(menu > FLEE_OPTION){
        menu = ATTACK_OPTION;
    }
}

if(keyboard_check_pressed(vk_space)){
    scr_combat_select_main();
}

//Android/Mouse controls
if(device_mouse_check_button(0,mb_left)){
    if(device_mouse_x_to_gui(0) < selectWidth){
        if(device_mouse_y_to_gui(0) >= 48*guiScale && device_mouse_y_to_gui(0) < sprite_get_height(spr_menuBar)*guiScale){
            menu = floor((device_mouse_y_to_gui(0) - (48*guiScale))/(15*guiScale))
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
