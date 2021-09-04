#define scr_combat_party_graphic
//scr_combat_party_graphic
//Just sets up the party graphic stuff, and does any animation stuff
var i;
for(i = 0; i < 5; i++){
    if((playerSelect != i &&  state != STATE_DOUBLE_ATTACK) && (partyHeight[i] > 0)){
        partyHeight[i] -= 2;
    } else if((playerSelect == i || state == STATE_DOUBLE_ATTACK) && (partyHeight[i] < sprite_get_height(spr_faceplate)) && (partyHeight[i] < sprite_get_height(spr_faceplate))) {
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

if(cutin_id >= 0){
    switch(cutin_state){
        case CUTIN_STATE_UP: {
        cutin_current_y = cutin_current_y * 0.9;
        cutin_time += 1;
        if(cutin_current_y <= 0.05){
            cutin_current_y = 0;
        }
        if(cutin_time >= 120){
            cutin_state = CUTIN_STATE_DISAPPEAR;
            cutin_time = 0;
        }
        break;
        }
        case CUTIN_STATE_DISAPPEAR:{
        cutin_transparency = cutin_transparency*.8;
        if(cutin_transparency <= 0.05){
            cutin_id = -1;
            cutin_current_y = 560;
            cutin_state = CUTIN_STATE_UP;
        }
        break;
        }
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

#define scr_draw_sprite_tiled_restrain
//scr_draw_sprite_tiled_restrain(sprite, subimg, x, y, width, height, scale, image colour, image alpha)
//Draws a sprite that will be tiled across the screen. Gotten from https://www.reddit.com/r/gamemaker/comments/8s6op2/efficient_way_to_draw_repeatingtiled_textures/

var sprite_to_draw = argument0;
var sprite_sub_index = argument1;
var x_pos = argument2;
var y_pos = argument3;
var width = argument4;
var height = argument5;
var uv_scale = argument6;
var colour = argument7;
var alpha = argument8;

var tex = sprite_get_texture(sprite_to_draw, sprite_sub_index);
var tex_w = texture_get_texel_width(tex);
var tex_h = texture_get_texel_height(tex);

//NOTE: Change this to gpu_set_texrepeat if GM2
texture_set_repeat(true); //This will set the texture mode to tile instead of wrap

draw_primitive_begin_texture(pr_trianglestrip, tex);
    draw_vertex_texture_colour(x_pos, y_pos+height, 0, height*tex_h*uv_scale,colour, alpha);
    draw_vertex_texture_colour(x_pos, y_pos, 0, 0,colour, alpha);
    draw_vertex_texture_colour(x_pos+width, y_pos+height, width*tex_w*uv_scale, height*tex_h*uv_scale,colour, alpha);;
    draw_vertex_texture_colour(x_pos+width, y_pos, width*tex_w*uv_scale, 0,colour, alpha);;
draw_primitive_end();
#define scr_enemy_defeat
//scr_enemy_defeat(enemy)
//Defeats the enemy. In the future, it'll have a fancy shmancy fade out.
enemies[argument0] = -1;
#define scr_player_select
//scr_player_select
//A script to set the playerSelect variable to the argument
playerSelect = argument0;
#define scr_cutin_display
//scr_cutin_display(cutin id)
//Displays a cutin (with some slight movement) for skill chains and magic bursts
cutin_id = argument0;
cutin_time = 0;
cutin_current_y = view_hport[0];
cutin_transparency = 1;
cutin_state = CUTIN_STATE_UP;
