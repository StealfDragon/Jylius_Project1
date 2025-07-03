arr = [layer_tilemap_get_id("colTiles"), Obj_door];

function place_meeting_collidables(x, y){   
    
    for (i = 0; i<array_length(arr); i++) {
        if place_meeting(x, y, arr[i]) {
            return true;
        }
    }
    
    return false;
}