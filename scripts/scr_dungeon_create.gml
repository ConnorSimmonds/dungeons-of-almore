#define scr_dungeon_create
//scr_dungeon_create
//This will load from a file in the future, but for now, it just returns a basic dungeon
var tempX, tempY, maxX, maxY, file, temp_string, temp_map, playerX, playerY;

file = file_text_open_read("dungeon.dng");
temp_string = file_text_readln(file);
items = scr_dungeon_load_objects();

//Get the max x/y and set up the room
maxX = real(string_copy(temp_string,0,string_pos(",",temp_string)-1));
maxY = real(string_copy(temp_string,string_pos(",",temp_string)+1,string_length(temp_string)-string_pos(",",temp_string)));
room_set_width(rm_dungeon,32*maxX);
room_set_height(rm_dungeon,(32*maxY));

//Handle the networking stuff - this should go into it's own method eventually
if(instance_exists(obj_network)){
    obj_network.maxX = maxX;
    obj_network.maxY = maxY;
    with(obj_network){ //tell the server to open map 1_1
     scr_handle_messages(13,1,1);
    }
}


//Init player X/Y
temp_string = file_text_readln(file);
playerX = real(string_copy(temp_string,0,string_pos(",",temp_string)-1));
playerY = real(string_copy(temp_string,string_pos(",",temp_string)+1,string_length(temp_string)-string_pos(",",temp_string)));
room_instance_add(rm_dungeon,(32*playerX)+16, (32*playerY)+16, obj_player);
room_instance_add(rm_dungeon,0,0,obj_floor);

for(tempY = 0; tempY < maxY; tempY++){
    temp_string = file_text_readln(file);
    for(tempX = 0; tempX < maxX; tempX++){
        switch(string_char_at(temp_string,tempX+1)){
            case('0'): temp_obj = obj_wall; break;
            case('C'): temp_obj = obj_chest; break;
            case('B'): temp_obj = obj_button; break;
            case('P'): temp_obj = obj_pillar; break;
            case('D'): temp_obj = obj_door; break;
            default: temp_obj = -1; break;
        }
        if(temp_obj != -1){        
            room_instance_add(rm_dungeon,tempX*32,tempY*32,temp_obj);
        }
    }
}

file_text_close(file);

#define scr_dungeon_load_objects
//scr_dungeon_load_objects
//load the object details in from the dungeon details file
file = file_text_open_read("dungeondetails");
temp_collection = ds_map_create();

while (!file_text_eof(file)){
    //Get the line and then split it up. This is SUPER hacky
    temp_string = file_text_readln(file);
    show_debug_message(string_count(",",temp_string));
    temp_array = array_create(string_count(",",temp_string));
    object = string_copy(temp_string,0,string_pos("-",temp_string)-1);
    show_debug_message(object);
    temp_string = string_delete(temp_string,1,2);
    show_debug_message(array_length_1d(temp_array));
    for(i = 0; i < array_length_1d(temp_array); i++){ //read through the line, cut out the part that's relevant, then add it to the array
        obj_details = string_copy(temp_string,1,string_pos(",",temp_string));
        temp_string = string_delete(temp_string,1,string_pos(",",temp_string));
        index = real(string_copy(obj_details,1,string_pos(":",obj_details)));
        t_id = real(string_copy(obj_details,string_pos(":",obj_details),string_length(obj_details)));
        show_debug_message(string(index) + " " + string(t_id));
        temp_array[index] = t_id;
    }
    ds_map_add(temp_collection,object,temp_array);
}
file_text_close(file);
return temp_collection;

#define scr_check_oob
//scr_check_oob
//Returns if we're out of bounds or not
return (target_x+vect_x > room_width || target_y+vect_y > room_height || (target_x+vect_x  < 0 || target_y+vect_y < 0))

#define scr_check_oob_behind
return (target_x-vect_x > room_width || target_y-vect_y > room_height || (target_x-vect_x  < 0 || target_y-vect_y < 0))