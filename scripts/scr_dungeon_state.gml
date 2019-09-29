#define scr_dungeon_state
//scr_dungeon_state
//Manages the states for the dungeon controller
switch(state){
    case(PLAYER_IDLE): scr_player_idle(); break;
    case(PLAYER_MOVE): scr_player_move(); break;
    case(STATE_INTERACT): scr_player_interact(); break
    case(STATE_MENU): scr_menu();
    default: break;
}

#define scr_player_idle
//Map stuff
if(keyboard_check_pressed(ord('A')) && !instance_exists(obj_map)){
    instance_create(0,0,obj_map);
}

//Movement
if(keyboard_check_pressed(vk_up)){
    state = PLAYER_MOVE;
    move_action = PLAYER_FORWARD;
} else if(keyboard_check_pressed(vk_down)){
    state = PLAYER_MOVE;
    move_action = PLAYER_BACK;
} else if(keyboard_check_pressed(vk_right)){
    state = PLAYER_MOVE;
    move_action =PLAYER_TURN_LEFT;
} else if(keyboard_check_pressed(vk_left)){
    state = PLAYER_MOVE;
    move_action = PLAYER_TURN_RIGHT;
}

if(keyboard_check_pressed(vk_space)){
    state = STATE_INTERACT;
}

if(keyboard_check_pressed(vk_shift)){
    state = STATE_MENU;
}

#define scr_player_move
//scr_player_move
switch(move_action){
    case(PLAYER_FORWARD): scr_player_forward(); break;
    case(PLAYER_BACK): scr_player_back(); break;
    case(PLAYER_TURN_LEFT): scr_player_turn_left(); break
    case(PLAYER_TURN_RIGHT): scr_player_turn_right(); break;
}

scr_calculate_fore_mid();

//We calculate if we get a battle or not here
if(scr_battle()){

} else {
    state = PLAYER_IDLE;
    move_action = PLAYER_NULL
}

#define scr_player_forward
//scr_player_forward
switch(dir){
    case(UP): playerY--; break;
    case(DOWN): playerY++; break;
    case(LEFT): playerX--; break;
    case(RIGHT): playerX++; break;
}

if(scr_check_oob()){
    scr_player_back();
} else if(dungeon_map[playerX,playerY] == -1){
    scr_player_back();
}

#define scr_player_interact


#define scr_player_back
//scr_player_back
switch(dir){
    case(UP): playerY++; break;
    case(DOWN): playerY--; break;
    case(LEFT): playerX++; break;
    case(RIGHT): playerX--; break;
}

if(scr_check_oob()){
    scr_player_forward();
} else if(dungeon_map[playerX,playerY] == -1){
    scr_player_forward();
}

#define scr_player_turn_left
//scr_player_turn_left
dir--;

if(dir < UP){
    dir = RIGHT;
}

#define scr_player_turn_right
//scr_player_turn_right
dir++;
if(dir > RIGHT){
    dir = UP;
}
#define scr_battle
//Calculate chances of a battle occuring
return false;