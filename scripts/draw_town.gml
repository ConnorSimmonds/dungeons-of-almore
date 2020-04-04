//draw_town(state)
//Allows us to draw different stuff based off of the current state. This is mostly used for things such as the scr_party_manage script, where we will need to display the party names.
var state;
state = argument0;

if(state == STATE_PARTY_MANAGE){
    for(i = 0; i <= obj_party.partySize; i++){
        var t_char;
        t_char = obj_party.character[i];
        draw_text(100,35 + (15 * i),t_char[obj_party.NAMES]);
    }
    
    draw_sprite(spr_town_arrow,0,90,43 + (menuSelect * 15))
}
