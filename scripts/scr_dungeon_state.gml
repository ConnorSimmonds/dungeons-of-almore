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
    case(STATE_BATTLE): scr_player_battle(); break;
    case(STATE_MENU): scr_player_menu(); break;
}

x = lerp(x,target_x,0.2);
y = lerp(y,target_y,0.2);
dir = lerp(dir,target_dir,0.1);

#define scr_player_move
//Movement - this should go into a script I guess
vect_x = lengthdir_x(32,target_dir);
vect_y = lengthdir_y(32,target_dir);

if(keyboard_check_pressed(vk_up)){
    if((!scr_check_oob() && !place_meeting(target_x+vect_x,target_y+vect_y,obj_solid)) || place_meeting(target_x+vect_x,target_y+vect_y,obj_door) && collision_point(target_x+vect_x,target_y+vect_y,obj_door, true, true).is_open){
        target_x += vect_x;
        target_y += vect_y;
        
        if(scr_battle()){
            state = STATE_INIT_BATTLE;
        }
    }
} else if(keyboard_check_pressed(vk_down)){
    if(!scr_check_oob_behind() && !place_meeting(target_x-vect_x,target_y-vect_y,obj_solid) ){
        target_x -= vect_x;
        target_y -= vect_y;
        
        if(scr_battle()){
            state = STATE_INIT_BATTLE;
        }
    }
} else if(keyboard_check_pressed(vk_right)){
    target_dir -= 90;
    if(instance_exists(obj_map)){
        obj_map.playerDir = scr_get_playerDir();
    }
} else if(keyboard_check_pressed(vk_left)){
    target_dir += 90;
    if(instance_exists(obj_map)){
        obj_map.playerDir = scr_get_playerDir();
    }
}

if(keyboard_check_pressed(ord('A'))){
    if(!instance_exists(obj_map)){
        instance_create(0,0,obj_map);
    }
}

if(keyboard_check_pressed(vk_enter)){
    state = STATE_MENU;
    //d3d_end();
}

#define scr_player_battle
//scr_player_battle
//nada

#define scr_player_init_battle
//scr_player_init_battle
//Inits the battle shtick
scr_map_close();
with(obj_dungeon){
    audio_stop_sound(music);
    music = audio_play_sound(msc_common_encounter,5,true);
}
instance_create(0,0,obj_combat);
state = STATE_BATTLE;

#define scr_player_menu
//scr_player_menu
//This is for any 2D-only menus (maybe?)
if(keyboard_check_pressed(vk_enter)){
    //d3d_start();
    state = STATE_NORMAL;
}

#define scr_set_up_combat
//Set up the enemy encounter
enemy_num = irandom(3) +1;

enemies[enemy_num] = -1;
for(i = 0; i < enemy_num; i++){
    enemies[i] = obj_dungeon.enemyPool[irandom(array_length_1d(obj_dungeon.enemyPool)-1)]; //there's only one enemy type currently, this will be changed to select from a random pool which is determined by the dungeon
}

switch(battle_type){
    case(1): //ambush encounter (you go first)
    battleMessage = "You catch sight of the ";
    if(enemy_num == 1){
        battleMessage += "enemy!"
    } else {
        battleMessage += "enemies!";
    }
    break;
    case(2): //enemy ambush encounter (enemies go first)
    battleMessage = "You've been amushed!"
    break;
    default: //normal encounter, assume it's normal for any other number
    if(enemy_num == 1){
        battleMessage = "An enemy"
    } else {
        battleMessage = string(enemy_num) + "  enemies";
    }
    battleMessage += " approaches!";
    break;
}

return enemies;