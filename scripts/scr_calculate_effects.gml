#define scr_calculate_effects
//scr_calculate_effects(id to calculate)
//Note: id can be -1 to indicate all should be calculated.
var partyID, i, equipStats, effects, totalEffect, startParse, parseCount, key, value;

partyID = argument0;
totalEffect = "";

if(partyID == -1){
    for(i = 0; i < partySize; i++){
        scr_calculate_effects(i);
    }
} else {
    for(i = 0; i < 6; i++){
        var tEffect;
        equipStats = ds_map_find_value(global.equipment_stats,string(equipment[partyID,i]));
        if(equipStats != undefined){
            tEffect = ds_map_find_value(equipStats,"Effects");
            totalEffect += tEffect + ",";
        }
    }
    
    //clean up the total effect by merging together effects of the same type - I WOULD use someone else's solution but...
    effects = ds_map_create();
    startParse = 1;
    parseCount = 0;
    for(i = 0; i < string_length(totalEffect); i++){
        if(string_char_at(totalEffect,i) == ",") {
            if(ds_map_exists(effects,key)){ //Check to see if we've already done this effect before
                value = ds_map_find_value(effect,key);
                value += real(string_copy(totalEffect,startParse,parseCount));
                ds_map_replace(effects,key,value);
            } else {
                ds_map_add(effects,key,real(string_copy(totalEffect,startParse,parseCount)));
            } //Reset the values
            startParse = i+2;
            key = "";
            parseCount = 0;
        } else if(string_char_at(totalEffect,i) == ":") {
            key = string_copy(totalEffect,startParse,parseCount);
            startParse = i+2;
            parseCount = 0;
        } else {
            parseCount++;
        }
    }
    
    secondaryEffects[partyID] = effects;
}

#define scr_get_equipment
//scr_get_equipment
//Loads in the equipment for the party from the map we got from the JSON
#define scr_calculate_main
//scr_calculate_main
//Calculates the main stat from the equipment and adds it to the array(s), as well as main stat increases
var partyID, i, equipStats, totalEffect, startParse, parseCount, key, value, mainType;

partyID = argument0;
totalEffect = "";

if(partyID == -1){
    for(i = 0; i < partySize; i++){
        scr_calculate_effects(i);
    }
} else {
    for(i = 0; i < 6; i++){
        var tEffect;
        equipStats = ds_map_find_value(global.equipment_stats,string(equipment[partyID,i]));
        if(equipStats != undefined){
            tEffect = ds_map_find_value(equipStats,"StatIncrease");
            totalEffect += tEffect + ",";
            
            //Add the main stat increases
            mainType = ds_map_find_value(equipStats,"Type");
            
            switch(mainType){
                case(0):{
                    main_increases[2] += ds_map_find_value(equipStats,"Main");
                }
            }
        }
    }
    
    //clean up the total effect by merging together effects of the same type - I WOULD use someone else's solution but...
    startParse = 1;
    parseCount = 0;
    for(i = 0; i < string_length(totalEffect); i++){
        if(string_char_at(totalEffect,i) == ",") {
            main_increases[real(key)] += real(string_copy(totalEffect,startParse,parseCount));
            //Reset the values
            startParse = i+2;
            key = "";
            parseCount = 0;
        } else if(string_char_at(totalEffect,i) == ":") {
            key = string_copy(totalEffect,startParse,parseCount);
            startParse = i+2;
            parseCount = 0;
        } else {
            parseCount++;
        }
    }
}
