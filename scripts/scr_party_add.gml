#define scr_party_add
//scr_party_add
//Adds a party member to the party

#define scr_party_remove
//scr_party_remove

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
        t_class = menuSelect;
        break;
    case(3): //portrait: get the portrait
        t_portrait = menuSelect;
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
        menuSelect = state - 10;
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

#define scr_party_manage
//scr_party_manage
//Allows you to select a party member, and move them around if needed
if(keyboard_check_pressed(vk_shift)){
    menuSelect = state - 10;
    //save the new order to settings.ini, really quickly
    ini_open("settings.ini");
    var i, name;
    for(i = 0; i < 5; i++){
        with(obj_party) {
            name = ds_map_find_value(character[i],NAMES)
            ini_write_string('Party',i,name);
        }
    }
    ini_close();
    state = STATE_PARTY;
}

if(keyboard_check_pressed(vk_space)){
    if(t_var == -1){
        t_var = menuSelect;
    } else {
        if(t_var != menuSelect){
            with(obj_party){
                scr_swap_members(obj_town.t_var,obj_town.menuSelect); 
            }
        } else {
            
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
