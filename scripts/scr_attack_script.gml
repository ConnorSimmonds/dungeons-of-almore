#define scr_attack_script
//scr_attack_script
//The script for handling attacks - such as, selecting the enemy and so on.
if(prevState != STATE_TARGET){
    state = STATE_TARGET;
} else { //We've selected a target, so we can create a turn
    var turn;
    turn[0] = scr_turn_script;
    turn[1] = 0;
    turn[2] = enemySelect;
    turn[3] = playerSelect;
    ds_priority_add(turn_queue,turn,obj_party.spd[playerSelect]);
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
source = argument2;

//First off, check we're still alive. This can also allow us to split players and enemies up easily
if(source < 5){
    switch(action){
        case(0): { //generic attack
            enemyHP[targ] -= 5;
            break;
        }
    }
    if(enemyHP[targ] <= 0){
        enemies[targ] = -1; //we baleet the enemy
    }
} else {
    
}



#define scr_turn_execute
//scr_turn_execute
//We go through our priority queue, and do our turn
var turn;
while(!ds_priority_empty(turn_queue)){
    turn = ds_priority_delete_max(turn_queue);
    script_execute(turn[0], turn[1], turn[2], turn[3]);
}

#define scr_round_end
//scr_round_end
//Cleans up any dead enemies etc. and resets enemySelect if needed
var i, i2, tempEnemies, tempHP;
i2 = 0; //we start i2 at the start
tempEnemies[0] = -1;
tempHP[0] = -1;
//Recreate arrays, if needed
for(i = 0; i < array_length_1d(enemies); i++){
    if(enemies[i] != -1){
        tempEnemies[i2] = enemies[i];
        tempHP[i2] = enemyHP[i];
        i2++;
    }
}

if(tempEnemies[0] != -1){
    enemies = tempEnemies;
    enemyHP = tempHP;
    enemySelect = 0;
}

playerSelect = 0;

//Check if all enemies are dead.
