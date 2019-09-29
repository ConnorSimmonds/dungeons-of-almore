#define scr_attack_script
//scr_attack_script
//The script for handling attacks - such as, selecting the enemy and so on.
state = STATE_TARGET;


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
}

if(keyboard_check_pressed(vk_left)){
    enemySelect--;
    if(enemySelect < 0){
        enemySelect = array_length_1d(enemies)-1;
    }
}

if(keyboard_check_pressed(vk_right)){
    enemySelect++;
    
    if(enemySelect > array_length_1d(enemies)-1){
        enemySelect = 0;
    }
}