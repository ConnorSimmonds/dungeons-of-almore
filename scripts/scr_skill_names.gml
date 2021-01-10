//scr_skill_names(skillList)
var skillList, i, skillString;
skillList = argument0;
skillString = "";
if(ds_exists(skillList,ds_type_list)){ //Make sure our data structure IS an actual data structure
    for(i = 0; i < ds_list_size(skillList); i++){
        switch(ds_list_find_value(skillList,i)){
            case(0): exit;
            case(1): skillString += "Skill Chain Test 1"; break;
            case(2): skillString += "Skill Chain Test 2"; break;
            case(3): skillString += "Chain Burst Test"; break;
        }
        skillString += "#";
    }
}

return skillString;
