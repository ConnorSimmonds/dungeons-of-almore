//scr_skill_names(skillList)
var skillList, i, skillString;
skillList = argument0;
skillString = "";
if(ds_exists(skillList,ds_type_list)){ //Make sure our data structure IS an actual data structure
    skillElemArray = array_create(ds_list_size(skillList));
    for(i = 0; i < ds_list_size(skillList); i++){
        switch(ds_list_find_value(skillList,i)){
            case(0): exit;
            case(1): skillString += "Skill Chain Test 1"; skillElemArray[i] = 0; break;
            case(2): skillString += "Skill Chain Test 2"; skillElemArray[i] = 1; break;
            case(3): skillString += "Chain Burst Test"; skillElemArray[i] = 2; break;
        }
        skillString += "#";
    }
}

return skillString;
