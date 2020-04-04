//scr_swap_members(party member 1, party member 2)
//Swaps all of the attributes of member 1 and 2 around.
var mem1, mem2, temp;
mem1 = argument0;
mem2 = argument1;

//do the swaparoo
temp = character[mem1];
character[mem1] = character[mem2];
character[mem2] = temp;
