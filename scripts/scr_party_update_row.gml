#define scr_party_update_row
//scr_party_update_row
//Updates the x/y values based off of the party composition
var row1 = -1;
var row2 = -1;

for(var i = 0; i < 3; i++){
    if(formation[0,i] != -1){
        row1++;
    }
    
    if(formation[1,i] != -1){
        row2++;
    }
}

row1X = scr_return_x_values(row1);
row2X = scr_return_x_values(row2);
/*
row1X = (view_wport[0]*(3/9)); //this is the 3-person row
row2X = (view_wport[0]*(4/10)); //this is the 2-person row
*/

#define scr_return_x_values
//scr_return_x_values
//Returns the x values based off of the argument provided
switch(argument0){
    case(0): return (view_wport[0]*(5/10));
    case(1): return (view_wport[0]*(4/10));
    case(2): return (view_wport[0]*(7/20));
    default: return (view_wport[0]*(5/10));
}
#define scr_update_party_names
//scr_update_party_names(Array party_names)
//Updates the party names to the given array
var party_names;
party_names = argument0;
party_names[0] = ds_map_find_first(obj_party.entireParty);
for(var i = 1; i < ds_map_size(obj_party.entireParty); i++){
    party_names[i] = ds_map_find_next(obj_party.entireParty,party_names[i-1]);
}
return party_names;
