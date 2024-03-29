#define scr_attack_script
//scr_attack_script
//The script for handling attacks - such as, selecting the enemy and so on.
if(prevState != STATE_TARGET){
    prevState = state;
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
    state = STATE_TURN_END;
    var turn;
    var character = obj_party.character[playerSelect];
    var skills = character[? obj_party.SKILLS];
    
    turn[0] = scr_turn_script;
    turn[1] = ds_list_find_value(skills,skillSelect);
    turn[2] = enemySelect;
    turn[3] = playerSelect;
    player_turns[playerSelect] = turn;
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
    if(state == STATE_ATTACK){
        state = STATE_MAIN;
    }
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
    var tState;
    tState = prevState;
    prevState = STATE_TARGET;
    state = tState;
}

#define scr_turn_script
//scr_turn_script(action id, t, source)
//Creates a turn, using the parameters given
var action, targ, source;
action = argument0;
targ = argument1;
source = argument2;
//First off, check who's the source of the attack. This allows us to handle enemies and players differently.
if(source < 5){
    var initHP = enemyHP[targ];
    var character = obj_party.character[source];
    var damage = 0;
    ds_queue_enqueue(battleMessageQueue,scr_player_select); //queue up the playerSelect script
    ds_queue_enqueue(battleMessageQueue,source); //and then the playerSelect variable, so the script is callec with the source as the argument.
    switch(action){
        case(0): { //generic attack
            ds_queue_enqueue(battleMessageQueue,character[? obj_party.NAMES] + " attempts to attack!");
            if(enemyHP[targ] <= 0){
                ds_queue_enqueue(battleMessageQueue,"But their target had been defeated...");
            } else {
                //ROUND(DAMAGE * (DAMAGE/DEF)) - this is the damage formula
                //DEF is defined by whether or not this is elemental damage. Currently, this is not accounted for in normal attacks (as I don't want to code in the other parts that'll require this)
                //Therefore, all normal attacks will be treated as physcial damage. This is defined by:
                //DEF + (VIT/DEF * DEF/2)
                var damage, def;
                attack = character[? obj_party.ATTACK];
                def = scr_calculate_physical_defense(5,10);
                damage = round(attack * (attack/def));
                
                ds_queue_enqueue(battleMessageQueue,"Enemy takes " + string(damage) + " damage!"); //TODO - replace this with the enemy's name
                ds_queue_enqueue(battleMessageQueue,scr_deal_damage);
                var damage_array = array_create(3);
                damage_array[0] = source;
                damage_array[1] = targ;
                damage_array[2] = damage;
                ds_queue_enqueue(battleMessageQueue,damage_array);
            }
            break;
        }
        default: {
            damage = scr_skills(action, targ, source);
            break;
        }
    }
    
    if(enemyHP[targ]-damage <= 0 && initHP != enemyHP[targ]){
        array = targ;
        ds_queue_enqueue(battleMessageQueue,scr_enemy_defeat);
        ds_queue_enqueue(battleMessageQueue,array);
        ds_queue_enqueue(battleMessageQueue,"Enemy down!");
        //also remove their turn from the priority queue
        ds_priority_delete_value(turn_queue,enemy_turns[targ]);
    }
} else {
    //it's the enemy's turn! Damage is calculated the same way. We're faking this - we're actually just going to do the AI here, during the turn_script.
    //We do not have a VIT for players yet, as I'm lazy. However, we can estimate it. It's their base max hp/5, rounded down.
    //AI is quite simple: choose a random player, then use the percentages in the enemy stats to determine the chances of a move happening (and how many moves, etc.)
    var attacker, attack, damage, def, target, character;
    source = source - 5;
    attacker = global.enemyStats[? string(enemies[source])];
    attack = attacker[? string(enemy_constants.ENEMY_ATTACK)];
    //There should be a check here to see if we're provoked/covered/whatever. This will influence where the damage actually goes.
    target = irandom(obj_party.partySize);
    character = obj_party.character[target];
    def = scr_calculate_physical_defense(character[? obj_party.DEFENSE],round(character[? obj_party.MAX_HP]/5));
    damage = round(attack * (attack/def));
    name = attacker[? string(enemy_constants.ENEMY_NAME)];
    ds_queue_enqueue(battleMessageQueue,name + " deals " + string(damage) + " damage to " + character[? obj_party.NAMES]);
    ds_queue_enqueue(battleMessageQueue,scr_deal_damage);
    var damage_array = array_create(3);
    damage_array[0] = source+5;
    damage_array[1] = target;
    damage_array[2] = damage;
    ds_queue_enqueue(battleMessageQueue,damage_array);
    
    //now we need to see if our target will die. If they have, we remove their action from the turn list.
    if(character[? obj_party.HP]-damage <= 0){
        ds_priority_delete_value(turn_queue,player_turns[target]);
    }
}

#define scr_turn_execute
//scr_turn_execute
//We go through our priority queue, and do our turn
var turn;

while(!ds_priority_empty(turn_queue)){
    turn = ds_priority_delete_max(turn_queue);
    show_debug_message(string(turn[1]) + " - Action of " + string(turn[3]));
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
        scr_add_chain(0);
        if(chain_multiplier > 1){
            c_char = obj_party.character[source]
            ds_queue_enqueue(battleMessageQueue,scr_cutin_display)
            ds_queue_enqueue(battleMessageQueue,(c_char[? obj_party.IMAGE]));
        }
        ds_queue_enqueue(battleMessageQueue,"Skill Chain Test 1.");
        return 0;
    }
    case(2):{
        scr_add_chain(1);
        if(chain_multiplier > 1){
            c_char = obj_party.character[source]
            ds_queue_enqueue(battleMessageQueue,scr_cutin_display)
            ds_queue_enqueue(battleMessageQueue,(c_char[? obj_party.IMAGE]));
        }
        ds_queue_enqueue(battleMessageQueue,"Skill Chain Test 2.");
        return 0;
    }
    case(3):{
        var burst_damage;
        burst_damage = scr_activate_chain(10);
        if(burst_damage != 0){
            c_char = obj_party.character[source]
            ds_queue_enqueue(battleMessageQueue,scr_cutin_display)
            ds_queue_enqueue(battleMessageQueue,(c_char[? obj_party.IMAGE]));
        }
        ds_queue_enqueue(battleMessageQueue,"Chain Burst Test");
        if(burst_damage != 0) {
            ds_queue_enqueue(battleMessageQueue,"Enemy takes " + string(burst_damage) + " damage from the burst chain!");
        }
        var damage_array = array_create(3);
        damage_array[0] = source;
        damage_array[1] = targ;
        damage_array[2] = burst_damage;
        ds_queue_enqueue(battleMessageQueue,scr_deal_damage);
        ds_queue_enqueue(battleMessageQueue,damage_array);
        return burst_damage;
    }
    default: {
        show_debug_message("Skill not implemented yet.");
        ds_queue_enqueue(battleMessageQueue,"Skill has not been implemented yet.");
        return 0;
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
var activate_damage, burst_damage, combined_attack;
activate_damage = argument0;
combined_attack = 10;

burst_multiplier++;
burst_damage = ((combined_attack + activate_damage) * chain_multiplier) * burst_multiplier;

//Clear the variables for a (potential) next burst, outside of the burst multiplier.
chain_multiplier = 0;
ds_list_clear(element_chain_list);

return burst_damage;
#define scr_deal_damage
//scr_deal_damage(source, target, damage)
//Deals damage to the enemy. This is so we don't show the results of the turn visually
//TODO - maybe add a shake or something?
var source, target, damage;
source = argument0[0];
target = argument0[1];
damage = argument0[2];
if(source < 5){
    obj_combat.enemyHP[target] = obj_combat.enemyHP[target] - damage;
} else {
    character = obj_party.character[target];
    ds_map_replace(character,obj_party.HP,character[? obj_party.HP]-damage);
}
