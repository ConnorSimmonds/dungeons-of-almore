//scr_combat_party_graphic
//Just sets up the party graphic stuff, and does any animation stuff
var i;
for(i = 0; i < 5; i++){
    if(playerSelect != i && (partyHeight[i] > 0)){
        partyHeight[i] -= 2;
    } else if(playerSelect == i && (partyHeight[i] < sprite_get_height(spr_faceplate))) {
        partyHeight[i] += 2;
    }
}
