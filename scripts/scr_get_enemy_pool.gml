#define scr_get_enemy_pool
//scr_get_enemy_pool
//Gets a pool of enemies that changes based off of the dungeon and floor
//TODO: actually have a way to define floors etc.
var pool;
pool = array_create(1);
pool[0] = 0;
return pool;

#define scr_set_up_enemy_hp
//scr_set_up_enemy_hp(number of enemies)
var enemNum, enemHP, i, t_enemy;
enemNum = argument0;
enemHP = array_create(enemNum);

for(i = 0; i < enemNum; i++){
    if(enemies[i] != -1){
    t_enemy = global.enemyStats[? string(enemies[i])];
    var t_hp = ds_map_find_value(t_enemy,string(enemy_constants.ENEMY_HP));
    enemHP[i] = t_hp;
    }
}
return enemHP;