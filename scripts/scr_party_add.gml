#define scr_party_add
//scr_party_add
//Adds a party member to the party
if(keyboard_check_pressed(vk_space)){
    if(t_var == -1){
        //First off, check that we don't have more than 5 party members
        if(obj_party.partySize >= 5){
            //display an error message re:party size limits
        } else if(scr_party_check_dupe_selected(partyNames[menuSelect[1]])){
            //display an error message re:duplicate
        } else {
            t_var = menuSelect[1];
            menuSelect[1] = 0;
        }
    } else {
        //swap the two cahracters around
        with(obj_party){
            scr_add_member(obj_town.partyNames[obj_town.t_var],obj_town.menuSelect[1]); 
        }
        menuSelect[1] = t_var;
        t_var = -1;   
         
    }
}
if(keyboard_check_pressed(vk_shift)) {
    if(t_var == -1){
        menuSelect[1] = state - 10;
        scr_update_ini();
        //update party formation and row x/y
        state = STATE_PARTY;
    } else {
        menuSelect[1] = t_var;
        t_var = -1; 
    }
}

#define scr_party_remove
//scr_party_remove
if(keyboard_check_pressed(vk_space)){
    with(obj_party){
        if(partySize >= 0) {
            scr_remove_member(obj_town.menuSelect[1]); 
        } else {
            //display an error message about not being able to remove no party members
        }
    }
}
if(keyboard_check_pressed(vk_shift)) {
    if(t_var == -1){
        menuSelect[1] = state - 10;
        scr_update_ini();
        //update party formation and row x/y
        state = STATE_PARTY;
    }
}

#define scr_party_create
//scr_party_create
//Creates a member, and adds them to the entire party
if(keyboard_check_pressed(vk_shift)){
    t_var--;
    if(t_var == -1){
        t_var = 6;
    }
}

if(keyboard_check_pressed(vk_space)){
    t_var++;
}

switch(t_var){
    case(0): //name: get the name
        t_name = get_string_async("Please enter a name: ",t_name);
        t_var++;
        break;
    case(1): //we've input the name, so now we'll just confirm it rq
    
        break;
    case(2): //class: get the class
        t_class = menuSelect[1];
        break;
    case(3): //portrait: get the portrait
        t_portrait = menuSelect[1];
        break;
    case(4): //confirm: if the details are gucci, we create the party member

        break;
    case(5): //we actually create the party member here
        with(obj_party){
            scr_create_character(obj_town.t_name,obj_town.t_class,10,10,"",10,10,10,1, obj_town.t_portrait);
        }
        t_var = 6;
        break;
    case(6): //exit
        t_var = -1;
        menuSelect[1] = state - 10;
        state = STATE_PARTY;
    default: //this is when we first enter the menu
        t_var = 0;
        t_name = "";
        t_portrait = 0;
        t_class = 0;
        break; 
}

#define scr_party_delete
//scr_party_delete
//deletes a party member. This should be surprisingly easy
if(t_var == -1){
    t_var[0] = ds_map_find_first(obj_party.entireParty);
    var i;
    menuMax = ds_map_size(obj_party.entireParty)
    for(i = 1; i < menuMax; i++){
        t_var[i] = ds_map_find_next(obj_party.entireParty,t_var[i-1]);
    }
}

if(keyboard_check_pressed(vk_space)){
    ds_map_delete(obj_party.entireParty,t_var[menuSelect[1]]);
}

#define scr_party_manage
//scr_party_manage
//Allows you to select a party member, and move them around if needed
if(keyboard_check_pressed(vk_shift)){
    if(t_var == -1){
        menuSelect[1] = state - 10;
        scr_update_ini();
        //update party formation and row x/y
        state = STATE_PARTY;
    } else {
        menuSelect[1] = t_var;
        t_var = -1;
    }
}

if(keyboard_check_pressed(vk_space)){
    if(t_var == -1){
        t_var = menuSelect[1];
    } else {
        if(t_var != menuSelect){
            with(obj_party){
                scr_swap_members(obj_town.t_var,obj_town.menuSelect[1]); 
            }
        } else {
            //open up a new menu and let the player swap this character with another
        } 
        t_var = -1;
    }
}

if(menuMax != obj_party.partySize) menuMax = obj_party.partySize;

#define scr_party_check_dupe
//scr_party_check_dupe
//Checks to see if there's a duplicate name or not.
if(argument0 == ""){
    return true; //well, they're called nothing
}

with(obj_party){
    return !is_undefined(ds_map_find_value(entireParty,argument0))
}
#define scr_party_check_dupe_selected
//scr_party_check_dupe_selected(selected member)
//Checks the current party to make sure that the member we selected ISN'T in the party already
var mem, t_char;
mem = argument0;
for(var i = 0; i < 6; i++){
    with(obj_party){
        t_char = character[i];
        if(t_char != undefined){
            if(t_char[? NAMES] == mem) return true;
        }
    }
}
return false;

#define scr_update_ini
//scr_update_ini
//save the new order to settings.ini, really quickly
        ini_open("settings.ini");
        var i, name;
        for(i = 0; i <= 5; i++){
            with(obj_party) {
                if(character[i] != undefined){
                    name = ds_map_find_value(character[i],NAMES)
                    ini_write_string('Party',i,name);
                } else {
                    //we have a blank spot - make this spot nothing
                    ini_write_string('Party',i,"");
                }
            }
        }
        ini_close();