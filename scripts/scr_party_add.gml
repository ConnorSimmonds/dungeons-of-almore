#define scr_party_add
//scr_party_add
//Adds a party member to the party

#define scr_party_remove
//scr_party_remove

#define scr_party_create

#define scr_party_delete
//scr_party_delete

#define scr_party_manage
//scr_party_manage
//Allows you to select a party member, and move them around if needed
if(keyboard_check_pressed(vk_shift)){
    menuSelect = state - 10;
    state = STATE_PARTY;
}

if(keyboard_check_pressed(vk_space)){
    if(t_var == -1){
        t_var = menuSelect;
    } else {
        with(obj_party){
        scr_swap_members(obj_town.t_var,obj_town.menuSelect);
        }
        t_var = -1;
    }
}

if(menuMax != obj_party.partySize) menuMax = obj_party.partySize;