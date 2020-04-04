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
}else if(scr_check_enemies()){ //At the end of the round, check to see if either all players or enemies are dead
    scr_victory_script();
} else if(scr_check_players()){
    scr_defeat_script();
}

temp_turn = scr_player_intended_turn(); //reset the turn order
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
#define scr_check_players
//scr_check_players
//Checks if all of the player's party members are dead
var i;
with(obj_party){
    for(i = 0; i < array_length_1d(hp); i++){
        if(hp[i] != -1){
            return false;
        }
    }
}
return true;

#define scr_player_turn_add
//scr_player_turn_add
//Adds the player turns into the priority queue
var i, lowest_speed, lowest_index;
lowest_index = 0;
lowest_speed = 255;

for(i = 0; i < 5; i++){
    var t_char = obj_party.character[temp_turn[i]];
    if(temp_turn[i] != intended_turn_order[i]){
        //oh shoot we gotta use the PREVIOUS speed oh no
        if(t_char[obj_party.SPEED] < lowest_speed){
            lowest_speed = t_char[obj_party.SPEED];
            lowest_index = i;
        }
        ds_priority_add(turn_queue,player_turns[temp_turn[i]],lowest_speed - (i - lowest_index));
    } else {
        ds_priority_add(turn_queue,player_turns[temp_turn[i]],t_char[obj_party.SPEED]);
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
#define scr_player_intended_turn
//scr_player_intended_turn
//Creates an array of what the intended player turns are supposed to be
var i, i2, player_turns;
for(i = 0; i < 5; i++){
    player_turns[i] = i;
}

for(i = 0; i < 5; i++){
    for(i2 = i; i2 < 5; i2++){
        var first = obj_party.character[i];
        var second = obj_party.character[i2];
        if(first[obj_party.SPEED] < second[obj_party.SPEED]){ //if the one we found is bigger 
            var temp = player_turns[i];
            player_turns[i] = player_turns[i2];
            player_turns[i2] = temp;
        }
    }
}
return player_turns;