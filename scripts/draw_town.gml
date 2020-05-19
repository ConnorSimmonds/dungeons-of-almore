//draw_town(state)
//Allows us to draw different stuff based off of the current state. This is mostly used for things such as the scr_party_manage script, where we will need to display the party names.
var state;
state = argument0;

if(state == STATE_PARTY_MANAGE){
    for(i = 0; i <= obj_party.partySize; i++){
        var t_char;
        t_char = obj_party.character[i];
        draw_text(100,35 + (15 * i),t_char[? obj_party.NAMES]);
    }
    
    draw_sprite(spr_town_arrow,0,90,43 + (menuSelect[1] * 15))
    if(t_var != -1){
        draw_sprite(spr_town_arrow,0,90,43 + (t_var * 15))
    }
} else if(state == STATE_PARTY_CREATE){
    draw_text(100,35,menuSelect[1]);
    draw_text(100,50,t_name);
    draw_text(100,65,t_class);
    draw_text(100,80,t_portrait);
} else if(state == STATE_PARTY_DELETE){
    if(t_var != -1){
        var i;
        for(i = 0; i < array_length_1d(t_var); i++){
            draw_text(100,35 + (15 * i), t_var[i]);
        }
    }
} else if(state == STATE_PARTY_ADD) {
    for(var i = 0; i < array_length_1d(party_name); i++){
        draw_text(100, 35 + (15 * i), party_name[i]);
    }
}
