//scr_enemy_stats
//This loads in a file of enemy stats. This can be called at any time to update the stats
//Format is:
//0: Name
//1: Base HP
//2: Level
//3: VIT
//4: DEF
//5: Attack
//6: Speed
//7: Image/Appearance
if(ds_exists(global.enemyStats,ds_type_map)) {
    ds_map_destroy(global.enemyStats); //we clear the data structure, to ensure there's no memory leaks
}
global.enemyStats = json_decode("enemies.json");
