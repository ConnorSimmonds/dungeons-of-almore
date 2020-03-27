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
} else if(scr_check_enemies()){
    scr_victory_script();
}

playerSelect = 0;

#define scr_check_enemies
//scr_check_enemies
//Checks if all of the enemies are dead
var i;
for(i = 0; i < array_length_1d(enemies); i++){
    if(enemies[i] != -1){
        return false;
    }
}
return true;
#define scr_player_turn_add
//scr_player_turn_add
//Adds the player turns into the priority queue
var i, temp_turn;

for(i = 0; i < 5; i++){
    temp_turn = player_turns[i];
    if(temp_turn[3] != i){
        //oh shoot we gotta use the PREVIOUS speed oh no
    } else {
        ds_priority_add(turn_queue,temp_turn,obj_party.spd[temp_turn[3]]);
    }
}
#define scr_victory_script
//scr_victory_script
//Displays gold, items, and exp gained. Destroys obj_combat at the end of it.
state = STATE_VICTORY;

//Calculate the items needed


instance_destroy();

#define scr_defeat_script
//scr_defeat_script
//Cleans up any state stuff, and boots the player back to town.
state = STATE_DEFEAT;
instance_destroy();
