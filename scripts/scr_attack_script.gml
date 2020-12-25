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
    player_turns[playerSelect] = turn;
    state = STATE_TURN_END;
}


#define scr_skill_script
//scr_skill_script
//Logic for skill selection etc
if(prevState == STATE_TARGET){
    var turn;
    var character = obj_party.character[playerSelect];
    var skills = character[? obj_party.SKILLS];
    
    turn[0] = scr_turn_script;
    turn[1] = skills[skillSelect];
    turn[2] = enemySelect;
    turn[3] = playerSelect;
    player_turns[playerSelect] = turn;
    state = STATE_TURN_END;
} else {    
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
    state = prevState;
    prevState = state = STATE_TARGET;
    
}

#define scr_turn_script
//scr_turn_script(action id, target)
//Creates a turn, using the parameters given
var action, targ;
action = argument0;
targ = argument1;
source = argument2;
//First off, check who's the source of the attack. This allows us to handle enemies and players differently.
if(source < 5){
    var initHP = enemyHP[targ];
    var character = obj_party.character[source];
    ds_queue_enqueue(battleMessageQueue,scr_player_select); //queue up the playerSelect script
    ds_queue_enqueue(battleMessageQueue,source); //and then the playerSelect variable, so the script is callec with the source as the argument.
    show_debug_message(string(source) + " " + string(action));
    switch(action){
        case(0): { //generic attack
            ds_queue_enqueue(battleMessageQueue,character[? obj_party.NAMES] + " attempts to attack!");
            if(enemyHP[targ] <= 0){
                ds_queue_enqueue(battleMessageQueue,"But their target had been defeated...");
            } else {
                enemyHP[targ] -= 5;
                ds_queue_enqueue(battleMessageQueue,"Enemy takes " + string(5) + " damage!");
            }
            break;
        }
        default: {
            scr_skills(action, targ, source);
            break;
        }
    }
    
    if(enemyHP[targ] <= 0 && initHP != enemyHP[targ]){
        array = targ;
        ds_queue_enqueue(battleMessageQueue,scr_enemy_defeat);
        ds_queue_enqueue(battleMessageQueue,array);
        ds_queue_enqueue(battleMessageQueue,"Enemy down!");
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
#define scr_skills
//scr_skills(action, targ, source);
//A giant ass script of all of the skills. Done to make turn_execute less unreadable.
var skill, targ, source;
skill = argument0;
targ = argument1;
source = argument2;

switch(skill){
    case(1): {
        ds_queue_enqueue(battleMessageQueue,"Skill has not been implemented yet.");
        scr_add_chain(0);
        break;
    }
    case(2):{
        scr_add_chain(1);
        break;
    }
    case(3):{
        var burst_damage;
        burst_damage = scr_activate_chain(10);
        break;
    }
    default: {
        show_debug_message("Skill not implemented yet.");
        ds_queue_enqueue(battleMessageQueue,"Skill has not been implemented yet.");
        break;
    }
}

#define scr_add_chain
//scr_add_chain(element)
//Adds the element to the list for the chain, and increases the multiplier. Returns if it was succesful (0) or if something went wrong (0>)
var element;
element = argument0;

if(chain_multiplier == 0){
    chain_multiplier = 1;
    return 0;
} else {
    if(ds_list_find_value(element_chain_list,element) != -1){
        chain_multiplier += 0.5;
        return 0;
    }
    last_element = ds_list_find_index(element_chain_list,ds_list_size(element_chain_list)-1);
    /**
        NOTE: elements are as follows:
        0 = Fire
        1 = Wind
        2 = Earth
        3 = Lightning
        4 = Water
    **/
    switch(last_element){
        case(0): if(element == 4){chain_multiplierf += 1.5; return 0} break;
        case(1): if(element == 0){chain_multiplierf += 1.5; return 0} break;
        case(2): if(element == 1){chain_multiplierf += 1.5; return 0} break;
        case(3): if(element == 2){chain_multiplierf += 1.5; return 0} break;
        case(4): if(element == 3){chain_multiplierf += 1.5; return 0} break;   
    }
    
    chain_multiplier += 1; //None of the above applies, so it's just +1
}

#define scr_activate_chain
//scr_activate_chain(damage)
//Activates the skill chain (if it's there). This occurs on every spell, and certain abilities.
var activate_damage, burst_damage;
activate_damage = argument0;

burst_multiplier++;
burst_damage = ((combined_attack + activate_damage) * chain_multiplier) * burst_multiplier;

//Clear the variables for a (potential) next burst, outside of the burst multiplier.
chain_multiplier = 0;
ds_list_clear(element_chain_list);

return burst_damage;