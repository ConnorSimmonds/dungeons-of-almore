#define scr_swap_members
//scr_swap_members(party member 1, party member 2)
//Swaps all of the attributes of member 1 and 2 around.
var mem1, mem2, temp;
mem1 = argument0;
mem2 = argument1;

//do the swaparoo for secondary effects and characters
temp = character[mem1];
character[mem1] = character[mem2];
character[mem2] = temp;

temp = secondaryEffects[mem1];
secondaryEffects[mem1] = secondaryEffects[mem2];
seondaryEffects[mem2] = temp;

//reload in their gear and recalculate mainstat increases
scr_get_equipment(mem1);
scr_get_equipment(mem2);

scr_calculate_additions(mem1);
scr_calculate_additions(mem2);

#define scr_add_member
//scr_swap_members((String) new party member, replaced party member spot)
//Swaps the attributes of that spot to 
var mem, pos, memVal;
mem = argument0;
pos = argument1;
//do the swaparoo
memVal = ds_map_find_value(entireParty,mem);
character[pos] = memVal;
partySize++;

#define scr_remove_member
//scr_remove_member(member to remove)
//This is easy - just the array index
var mem;
mem = argument0;
character[mem] = undefined;
ds_map_destroy(secondaryEffects[mem]);
partySize--;
