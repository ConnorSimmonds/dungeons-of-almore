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
    scr_turn_back();
}

//Android/Mouse controls
if(device_mouse_check_button(0,mb_left)){
    if(device_mouse_x_to_gui(0) < selectWidth){
        if(device_mouse_y_to_gui(0) >= 48*global.guiScale && device_mouse_y_to_gui(0) <= (sprite_get_height(spr_menuBar))*global.guiScale){
            menu = floor((device_mouse_y_to_gui(0) - (48*global.guiScale))/(18*global.guiScale))
        }
    }
} else if(device_mouse_check_button_released(0,mb_left)){
    if(device_mouse_x_to_gui(0) < selectWidth){
        if(device_mouse_y_to_gui(0) >= 48*global.guiScale && device_mouse_y_to_gui(0) < sprite_get_height(spr_menuBar)*global.guiScale){
            scr_combat_select_main();
        }
    }
}

#define scr_combat_state
//scr_combat_state
//Manages the state of combat, which dictates what the menus can/can't do
switch(state){
    case(STATE_MAIN):{
        scr_set_battle_message("Choose an action.");
        scr_menu_combat();
        break;
    }
    case(STATE_ATTACK):{
        scr_attack_script();
        break;
    }
    case(STATE_SKILL):{
        scr_set_battle_message("Select a skill.");
        scr_skill_script();
        break;
    }
    case(STATE_DEFEND):{
        break;
    }
    case(STATE_ITEM):{
        scr_set_battle_message("Select an item.");
        break;
    }
    case(STATE_DOUBLE_ATTACK):{
        scr_turn_edit();
        break;
    }
    case(STATE_FLEE):{
        
        break;
    }
    case(STATE_TARGET):{
        scr_set_battle_message("Select a target.");
        scr_target_script();
        break;
    } case(STATE_TURN_END):{
        scr_turn_end();
        break;
    } case(STATE_EXECUTE):{
        scr_turn_execute(); //Based off of that information, we execute the turn order
        battleMessageGetNext = true;
        state = STATE_MESSAGE;
    } case(STATE_MESSAGE):{
        scr_battle_message();
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

#define scr_turn_end
//scr_turn_end
//Ends the turn
if(playerSelect < 4){
    playerSelect++;
    prevState = STATE_MAIN;
    state = STATE_MAIN;
} else {
    scr_player_turn_add();
    state = STATE_EXECUTE;
}

#define scr_turn_back
//scr_combat_go_back()
//Goes back to the previous person in the party list
if(playerSelect != 0){
    playerSelect--;
    ds_priority_delete_value(turn_queue,player_turns[playerSelect]);
    prevState = STATE_MAIN;
} else {
    //give some feeedback
}
#define scr_battle_message
//scr_battle_message
//Displays the battle message until you press accept, then displays the next. Also handles things such as battle animations etc.
if(keyboard_check_pressed(vk_space)){
    battleMessageGetNext = true;
}

if(battleMessageGetNext && (string_length(battleMessage)/2 <= string_length(battleMessageDisplay))){
    battleMessageGetNext = false;
    if(ds_queue_empty(battleMessageQueue)){
        scr_round_end();
        state = STATE_MAIN;
    } else {
        //Let's check if we have a string or not
        var message;
        message = ds_queue_dequeue(battleMessageQueue);
        if(is_string(message)){
            scr_set_battle_message(message);
        } else { //It's very likely the custom message script
            script_execute(message,ds_queue_dequeue(battleMessageQueue));
            battleMessageGetNext = true;
        }
    }
}

#define scr_turn_edit
//scr_turn_edit
//Script for editing turns
if(keyboard_check_pressed(vk_shift)){
    skillSelect = 0;
    state = STATE_MAIN;
}

if(keyboard_check_pressed(vk_up)){
    skillSelect--;
} else if(keyboard_check_pressed(vk_down)){
    skillSelect++;
}