#define scr_combat_party_graphic
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

if(string_length(battleMessageDisplay) != string_length(battleMessage)){
    battleMessageTimer++;
    if(battleMessageTimer == battleMessageMax){
        battleMessageTimer = 0;
        battleMessageDisplay += string_char_at(battleMessage,string_length(battleMessageDisplay)+1);
    }
}

#define scr_set_battle_message
//scr_set_battle_message(string message)
//sets the battle message and resets the display for you
if(battleMessage != argument0){
    battleMessage = argument0;
    battleMessageDisplay = "";
}
#define scr_get_playerDir
//scr_get_playerDir
//calculates the playerDir value
return 4 - ((obj_player.target_dir/90) mod 4);
