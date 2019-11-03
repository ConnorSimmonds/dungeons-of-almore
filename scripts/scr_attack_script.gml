#define scr_attack_script
//scr_attack_script
//The script for handling attacks - such as, selecting the enemy and so on.
if(prevState != STATE_TARGET){
    state = STATE_TARGET;
} else { //We've selected a target, so we can create a turn
    scr_turn_script(0,enemySelect);
    state = STATE_TURN_END;
}


#define scr_skill_script
//scr_skill_script
//Logic for skill selection etc
if(keyboard_check_pressed(vk_space)){
    prevState = state;
    state = STATE_TARGET;
}

if(keyboard_check_pressed(vk_shift)){
    state = STATE_MAIN;
}

//TODO: actually add in the skill amount etc.
if(keyboard_check_pressed(vk_up)){
    skillSelect--;
    
    if(skillSelect < 0){
        skillSelect = 9;
    }
}

if(keyboard_check_pressed(vk_down)){
    skillSelect++;
    
    if(skillSelect > 9){
        skillSelect = 0;
    }
}


#define scr_target_script
//scr_target_script
//The script for targeting enemies.
if(keyboard_check_pressed(vk_shift)){
    state = prevState;
} else if(keyboard_check_pressed(vk_left)){
    enemySelect--;
    if(enemySelect < 0){
        enemySelect = array_length_1d(enemies)-1;
    }
} else if(keyboard_check_pressed(vk_right)){
    enemySelect++;
    
    if(enemySelect > array_length_1d(enemies)-1){
        enemySelect = 0;
    }
} else if(keyboard_check_pressed(vk_space)){
    prevState = state;
    state = STATE_ATTACK;
}

#define scr_turn_script
//scr_turn_script(action id, target)
//Creates a turn, using the parameters given
var action, targ;
action = argument0;
targ = argument1;

action[playerSelect] = action;
target[playerSelect] = targ;
