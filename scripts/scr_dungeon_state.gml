#define scr_dungeon_state
//scr_dungeon_state
//Manages the states for the dungeon controller
switch(state){
    case(STATE_MENU): scr_menu();
    default: break;
}

#define scr_battle
//Calculate chances of a battle occuring
return random(2) < 0.25

#define scr_player_state
//scr_player_state
//State machinerino
switch(state){
    case(STATE_NORMAL): scr_player_move(); break;
    case(STATE_INIT_BATTLE): scr_player_init_battle(); break;
    case(STATE_BATTLE): scr_player_battle();
}

x = lerp(x,target_x,0.2);
y = lerp(y,target_y,0.2);
dir = lerp(dir,target_dir,0.1);

#define scr_player_move
//Movement - this should go into a script I guess
vect_x = lengthdir_x(32,target_dir);
vect_y = lengthdir_y(32,target_dir);

if(keyboard_check_pressed(vk_up)){
    if(!scr_check_oob() && !place_meeting(target_x+vect_x,target_y+vect_y,obj_wall)){
        target_x += vect_x;
        target_y += vect_y;
        
        if(scr_battle()){
            state = STATE_INIT_BATTLE;
        }
    }
} else if(keyboard_check_pressed(vk_down)){
    if(!scr_check_oob_behind() && !place_meeting(target_x-vect_x,target_y-vect_y,obj_wall) ){
        target_x -= vect_x;
        target_y -= vect_y;
        
        if(scr_battle()){
            state = STATE_BATTLE;
        }
    }
} else if(keyboard_check_pressed(vk_right)){
    target_dir -= 90;
} else if(keyboard_check_pressed(vk_left)){
    target_dir += 90;
}

#define scr_player_battle
//scr_player_battle
//nada

#define scr_player_init_battle
//scr_player_init_battle
//Inits the battle shtick
instance_create(0,0,obj_combat);
state = STATE_BATTLE;
