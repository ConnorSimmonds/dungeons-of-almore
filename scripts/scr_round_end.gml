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