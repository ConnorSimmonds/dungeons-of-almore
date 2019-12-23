#define scr_dungeon_create
//scr_dungeon_create
//This will load from a file in the future, but for now, it just returns a basic dungeon
var tempX, tempY, maxX, maxY, file, temp_string, temp_map;

file = file_text_open_read("dungeon.dng");
temp_string = file_text_readln(file);

//Get the max x/y
maxX = real(string_copy(temp_string,0,string_pos(",",temp_string)-1));
maxY = real(string_copy(temp_string,string_pos(",",temp_string)+1,string_length(temp_string)-string_pos(",",temp_string)));
temp_map[maxX,maxY] = -1;

for(tempY = 0; tempY < maxY; tempY++){
    temp_string = file_text_readln(file);
    for(tempX = 0; tempX < maxX; tempX++){
        temp_map[tempX,tempY] = real(string_char_at(temp_string,tempX+1))-1;
    }
}

return temp_map;

#define scr_calculate_fore_mid
//scr_calculate_fore_mid
 //calculates fore and midground values based off of the player's current view
foreground = 0; //base values
midground = 0;
background = 0;

var empty = 0;

//TODO: refactor this so it's not as cluttered.
//I think I can merge a lot of this into the same script, with some tinkering. There's a lot of repeated code and minor changes.

switch(dir){
    case(UP):{
        if(playerY != 0 && dungeon_map[playerX,playerY-1] == 0){
            if(playerX != 0){
                if(dungeon_map[playerX-1,playerY-1] == 0){
                    midground += 1;
                }
            }
            
            if(playerX != array_height_2d(dungeon_map)){
                if(dungeon_map[playerX+1,playerY-1] == 0){
                    midground += 2;
                }
            }
            
            //We've calculated the midground - now we have to calculate if it's in an open area or not.
            if(midground != 0 && playerY != 1){
                //Since midground isn't a corridor, we calculate whether or not there's an open space around it. But first, we must make sure we can actually see into that area
                if(dungeon_map[playerX,playerY-2] == 0){
                    if(playerX != 0){
                        if(dungeon_map[playerX-1,playerY-2] == 0){
                            empty += 1;
                        }
                    }
            
                    if(playerX != array_height_2d(dungeon_map)){
                        if(dungeon_map[playerX+1,playerY-2] == 0){
                           empty += 2;
                        }
                    }
                    if(empty == midground || empty == 3 || dungeon_map[playerX,playerY-2] == -1){
                        midground += 4;
                    } else if(midground == 3){
                        midground = empty + 4;
                    }
                } else {
                     midground += 4;
                     background = 2;
                }
            }
        }
            //We check the midground (playerY - 1) and foreground (playerY)
            if(playerX != 0){
                if(dungeon_map[playerX-1,playerY] == 0){
                    foreground += 1;
                }
            }
            
            if(playerX != array_height_2d(dungeon_map)){
                if(dungeon_map[playerX+1,playerY] == 0){
                    foreground += 2;
                }
            }
            
            if(foreground != 0 && playerY != 0){
                empty = 0;
                if(dungeon_map[playerX,playerY-1] == 0){
                    if(playerX != 0){
                        if(dungeon_map[playerX-1,playerY-1] == 0){
                            empty += 1;
                        }
                    }
            
                    if(playerX != array_height_2d(dungeon_map)){
                        if(dungeon_map[playerX+1,playerY-1] == 0){
                            empty += 2;
                        }
                    }
                    
                    if(empty == foreground || empty == 3){
                        foreground += 4;
                    } else if(foreground == 3){
                        
                        if((playerX != array_height_2d(dungeon_map) && playerX != 0)){
                            if((dungeon_map[playerX+1,playerY-1] == 0 && dungeon_map[playerX-1,playerY-1] == -1)){
                                foreground = 9;
                            } else if((dungeon_map[playerX+1,playerY-1] == -1 && dungeon_map[playerX-1,playerY-1] == 0)){
                                foreground = 8;
                            } else if((dungeon_map[playerX+1,playerY-1] == 0 && dungeon_map[playerX-1,playerY-1] == 0)){
                                foreground = empty + 4;
                            }
                        }
                    }
                }
            }
            //The background - this is, well, kinda hacky but it works.
            background = 1;
            if(playerY - 2 >= 0){
                if(dungeon_map[playerX,playerY - 2] != -1){
                    background = 0;
                }
            }
            
            if(playerY == 0 || dungeon_map[playerX,playerY-1] == -1){
                midground = 8;
                if(foreground == 0){
                    foreground = 0;
                } else if(foreground == 3){
                    foreground = 4;
                } else {
                    foreground += 4;
                }
               
                background = 2;
            } 
            
        break;
    }
    case(DOWN):{
        if(playerY != array_height_2d(dungeon_map)){
            if(playerX != 0){
                if(dungeon_map[playerX-1,playerY+1] == 0){
                    midground += 2;
                }
            }
            
            if(playerX != array_height_2d(dungeon_map)){
                if(dungeon_map[playerX+1,playerY+1] == 0){
                    midground += 1;
                }
            }
            
            if(midground != 0 && playerY != array_height_2d(dungeon_map)-1){
                //Since midground isn't a corridor, we calculate whether or not there's an open space around it. But first, we must make sure we can actually see into that area
                if(dungeon_map[playerX,playerY+1] == 0){
                    if(playerX != 0){
                        if(dungeon_map[playerX-1,playerY+2] == 0){
                            empty += 2;
                        }
                    }
            
                    if(playerX != array_height_2d(dungeon_map)){
                        if(dungeon_map[playerX+1,playerY+2] == 0){
                           empty += 1;
                        }
                    }
                    if(empty == midground || empty == 3 || dungeon_map[playerX,playerY+2] == -1){
                        midground += 4;
                    } else if(midground == 3){
                        midground = empty + 4;
                    }
                } else {
                     midground += 4;
                     background = 2;
                }
            }
        }
            //As with UP, we check both fore and midgrounds
            if(playerX != 0){
                if(dungeon_map[playerX-1,playerY] == 0){
                    foreground += 2;
                }
            }
            
            if(playerX != array_height_2d(dungeon_map)){
                
                if(dungeon_map[playerX+1,playerY] == 0){
                    foreground += 1;
                }
            }
            
            if(foreground != 0 && playerY != 0){
                empty = 0;
                if(dungeon_map[playerX,playerY+1] == 0){
                    if(playerX != 0){
                        if(dungeon_map[playerX-1,playerY+1] == 0){
                            empty += 2;
                        }
                    }
            
                    if(playerX != array_height_2d(dungeon_map)){
                        if(dungeon_map[playerX+1,playerY+1] == 0){
                            empty += 1;
                        }
                    }
                    
                    if(empty == foreground || empty == 3){
                        foreground += 4;   
                    } else if(foreground == 3){
                        
                        if((playerX != array_height_2d(dungeon_map) && playerX != 0)){
                            if((dungeon_map[playerX+1,playerY+1] == 0 && dungeon_map[playerX-1,playerY+1] == -1)){
                                foreground = 8;
                            } else if((dungeon_map[playerX+1,playerY+1] == -1 && dungeon_map[playerX-1,playerY+1] == 0)){
                                foreground = 9;
                            } else if((dungeon_map[playerX+1,playerY+1] == 0 && dungeon_map[playerX-1,playerY+1] == 0)){
                                foreground = empty + 4;
                            }
                        }
                    }
                }
            }
            
            
            background = 1;
            if(playerY + 2 <= array_height_2d(dungeon_map)){
                if(dungeon_map[playerX,playerY + 2] != -1){
                    background = 0
                }
            }
            
            if(playerY == array_height_2d(dungeon_map) || dungeon_map[playerX,playerY+1] == -1){
                midground = 8;
                if(foreground == 0){
                    foreground = 0;
                } else if(foreground == 3){
                    foreground = 4;
                } else {
                    foreground += 4;
                }
               
                background = 2;
            } 
        break;
    }
    case(LEFT):{
        if(playerX != 0){
            if(playerY != 0){
                if(dungeon_map[playerX-1,playerY-1] == 0){
                    midground += 2;
                }
            }
            
            if(playerY != array_height_2d(dungeon_map)){
                if(dungeon_map[playerX-1,playerY+1] == 0){
                    midground += 1;
                }
            }
            
            //We've calculated the midground - now we have to calculate if it's in an open area or not.
            if(midground != 0 && playerX != 1){
                //Since midground isn't a corridor, we calculate whether or not there's an open space around it. But first, we must make sure we can actually see into that area
                if(dungeon_map[playerX-2,playerY] == 0){
                    if(playerY != 0){
                        if(dungeon_map[playerX-2,playerY-1] == 0){
                            empty += 2;
                        }
                    }
            
                    if(playerX != array_height_2d(dungeon_map)){
                        if(dungeon_map[playerX-2,playerY+1] == 0){
                           empty += 1;
                        }
                    }
                    if(empty == midground || empty == 3 || dungeon_map[playerX-2,playerY] == -1){
                        midground += 4;
                    } else if(midground == 3){
                        midground = empty + 4;
                    }
                } else {
                     midground += 4;
                     background = 2;
                }
            }
        }
            //Repeat from before except now it's on the X axis
            if(playerY != 0){
                if(dungeon_map[playerX,playerY-1] == 0){
                    foreground += 2;
                }
            }
            
            if(playerY != array_height_2d(dungeon_map)){
                if(dungeon_map[playerX,playerY+1] == 0){
                    foreground += 1;
                }
            }
            
            if(foreground != 0 && playerX != 0){
                empty = 0;
                if(dungeon_map[playerX-1,playerY] == 0){
                    if(playerY != 0){
                        if(dungeon_map[playerX-1,playerY-1] == 0){
                            empty += 2;
                        }
                    }
            
                    if(playerY != array_length_2d(dungeon_map,0) ){
                        if(dungeon_map[playerX-1,playerY+1] == 0){
                            empty += 1;
                        }
                    }
                    
                    if(empty == foreground || empty == 3){
                        foreground += 4;   
                    } else if(foreground == 3){
                        if((playerY != array_length_2d(dungeon_map,0) && playerY != 0)){
                            if((dungeon_map[playerX-1,playerY+1] == 0 && dungeon_map[playerX-1,playerY-1] == -1)){
                                foreground = 9;
                            } else if((dungeon_map[playerX-1,playerY+1] == -1 && dungeon_map[playerX-1,playerY+1] == 0)){
                                foreground = 8;
                            } else if((dungeon_map[playerX-1,playerY+1] == 0 && dungeon_map[playerX-1,playerY+1] == 0)) {
                                foreground = empty + 4;
                            }
                        }
                    }
                }
            }
            
            
            background = 1;
            if(playerX - 2 >= 0){
                if(dungeon_map[playerX - 2,playerY] != -1){
                    background = 0
                }
            }
            
            if(playerX == 0 || dungeon_map[playerX-1,playerY] == -1){
                midground = 8;
                if(foreground == 0){
                    foreground = 0;
                } else if(foreground == 3){
                    foreground = 4;
                } else {
                    foreground += 4;
                }
               
                background = 2;
            }
        break;
    }
    case(RIGHT):{
            if(playerX != array_length_2d(dungeon_map,0)){
                if(playerY != 0){
                    if(dungeon_map[playerX+1,playerY-1] == 0){
                        midground += 1;
                    }
                }
                if(playerY != array_height_2d(dungeon_map)){
                    if(dungeon_map[playerX+1,playerY+1] == 0){
                        midground += 2;
                    }
                }
                
                //We've calculated the midground - now we have to calculate if it's in an open area or not.
            if(midground != 0 && playerX != array_height_2d(dungeon_map)-1){
                //Since midground isn't a corridor, we calculate whether or not there's an open space around it. But first, we must make sure we can actually see into that area
                if(dungeon_map[playerX+2,playerY] == 0){
                    if(playerY != array_length_2d(dungeon_map,0)){
                        if(dungeon_map[playerX+2,playerY+1] == 0){
                            empty += 2;
                        }
                    }
            
                    if(playerY != 0){
                        if(dungeon_map[playerX+2,playerY-1] == 0){
                           empty += 1;
                        }
                    }
                    if(empty == midground || empty == 3 || dungeon_map[playerX+2,playerY] == -1){
                        midground += 4;
                    } else if(midground == 3){
                        midground = empty + 4;
                    }
                } else {
                     midground += 4;
                     background = 2;
                }
            }
            }
             //Repeat from before except now it's on the Y axis
            if(playerY != 0){   
                if(dungeon_map[playerX,playerY-1] == 0){
                    foreground += 1;
                }
            }
            
            if(playerY != array_length_2d(dungeon_map,0)){
                if(dungeon_map[playerX,playerY+1] == 0){
                    foreground += 2;
                }
            }
            
            if(foreground != 0 && playerX != array_height_2d(dungeon_map)){
                empty = 0;
                if(dungeon_map[playerX+1,playerY] == 0){
                    if(playerY != 0){
                        if(dungeon_map[playerX+1,playerY-1] == 0){
                            empty += 1;
                        }
                    }
            
                    if(playerY != array_length_2d(dungeon_map,0)){
                        if(dungeon_map[playerX+1,playerY+1] == 0){
                            empty += 2;
                        }
                    }
                    
                    if(empty == foreground || empty == 3){
                        foreground += 4;   
                    } else if(foreground == 3){
                        if((playerY != array_length_2d(dungeon_map,0)  && playerY != 0)){
                            if((dungeon_map[playerX+1,playerY+1] == 0 && dungeon_map[playerX+1,playerY-1] == -1)){
                                foreground = 8;
                            } else if((dungeon_map[playerX+1,playerY+1] == -1 && dungeon_map[playerX+1,playerY+1] == 0)){
                                foreground = 9;
                            } else if((dungeon_map[playerX+1,playerY+1] == 0 && dungeon_map[playerX+1,playerY+1] == 0)) {
                                foreground = empty + 4;
                            }
                        }
                    }
                }
            }
            
            //The background - this is, well, kinda hacky but it works.
            background = 1;
            if(playerX + 2 <= array_length_2d(dungeon_map,0)){
                if(dungeon_map[playerX + 2,playerY] != -1){
                    background = 0
                }
            }
            
            if(playerX == array_length_2d(dungeon_map,0) || dungeon_map[playerX+1,playerY] == -1){
                midground = 8;
                if(foreground == 0){
                    foreground = 0;
                } else if(foreground == 3){
                    foreground = 4;
                } else {
                    foreground += 4;
                }
               
                background = 2;
            }
        }
        break;
    }

#define scr_check_oob
//scr_check_oob
//Returns if we're out of bounds or not
return (playerX > array_height_2d(dungeon_map) || playerY > array_length_2d(dungeon_map,0) || (playerX < 0 || playerY < 0))