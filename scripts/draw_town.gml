#define draw_town
//draw_town(state)
//Allows us to draw different stuff based off of the current state. This is mostly used for things such as the scr_party_manage script, where we will need to display the party names.
var state;
state = argument0;

if(state == STATE_PARTY_MANAGE){
    draw_town_party_names();
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
    if(t_var != -1) {
        draw_sprite(spr_town_arrow,0,90,38 + (menuSelect[1] * 15))
    } else {
        draw_sprite(spr_town_arrow,0,190,23 + (menuSelect[1] * 15))
    }
    draw_town_party_names();

    for(var i = 0; i < array_length_1d(partyNames); i++){
        draw_text(200, 15 + (15 * i), partyNames[i]);
    }
} else if(state == STATE_PARTY_REMOVE) {
     draw_sprite(spr_town_arrow,0,90,38 + (menuSelect[1] * 15))
     var i2 = 0;
    draw_town_party_names();
}

#define draw_town_party_names
//draw_town_party_names
//Draws the party names
var i = 0;
var i2 = 0;
for(i = 0; i <= obj_party.partySize; i2++;){
        var t_char;
        t_char = obj_party.character[i2];
        if(t_char != undefined){
            draw_text(100,35 + (15 * i2),t_char[? obj_party.NAMES]);
            i++;
        }
}