state = closed;
sprite_index = Sprt_door_closed;
openDist = 50;
closeDist = 80;

function openingCondition() {
    if (distance_to_object(Obj_player) < openDist) and (instance_exists(Obj_player)) { //if player is within opening distance
        return true;
    }
    return false;
}

function closingCondition() {
    if (distance_to_object(Obj_player) < closeDist) and (instance_exists(Obj_player)) { //if player is within opening distance
        return false;
    }
    return true;
}


function closed() {
    if openingCondition() {
        sprite_index = Sprt_door_opening;
    }
}

function open() {
    if alarm[0] = -1 {
        alarm_set(0, 30);
    }
}