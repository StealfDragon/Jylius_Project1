if (instance_exists(Obj_player) and (distance_to_object(Obj_player) < aggroDist)) {
    targetX = Obj_player.x;
}
//add wandering later

alarm[0] = 30;