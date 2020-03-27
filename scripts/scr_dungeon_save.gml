#define scr_dungeon_save
//scr_dungeon_save
//A debug function for easy fungeon creation. Saves the layout to a txt file. It automatically determines the width and height.

//First, figure out the width/height
var maxWid, maxHig, wid, hig;
wid = 0;
hig = 0;
maxWid = -1;
maxHig = -1;

for(wid = 0; wid < array_height_2d(map); wid++){
    for(hig = 0; hig < array_length_2d(map,wid); hig++){
        if(map[wid,hig] == 1){
            //Update our max width/height
            if(wid > maxWid){
                maxWid = wid;
            }
            if(hig > maxHig) {
                maxHig = hig;
            }
        }
    }
}

//Now let's save this to a map. First off, prompt the user on where to save it (Windows only)
var file, filename, func;
filename = get_save_filename("dungeon|.dng", "dungeon.dng");
if(filename != ""){
    //Since they have given a valid name, we write it to a file
    file = file_text_open_write(filename);
    file_text_write_string(file, string(maxWid) + "," + string(maxHig)); //'Header' of the file
    file_text_writeln(file);
    for(hig = 0; hig <= maxHig; hig++){
        for(wid = 0; wid <= maxWid; wid++){
            switch(map[wid,hig]){
                case(1): file_text_write_string(file,"1"); //Floor
                    break;
                case(0): file_text_write_string(file,"0"); //Nothing
                    break;
            }
        }
        file_text_writeln(file);
    }
    file_text_close(file);
}
//Exit the scrip

#define scr_map_close
//scr_map_close
//Closes the map oobject
if(instance_exists(obj_map)){
    with(obj_map){
        state = STATE_CLOSE;
        if(debug){
            scr_dungeon_save();
        }
        
    }
}

#define scr_map_open
//scr_map_open
if(instance_exists(obj_map)){
    with(obj_map){
        state = STATE_DRAW;
    }
} else { //we... somehow lost the map
    instance_create(0,0,obj_map);
}
#define scr_map_minimize
with(obj_map){
        state = STATE_MINIMAP;  
    }
