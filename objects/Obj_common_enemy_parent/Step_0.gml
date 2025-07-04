switch(state) {
    case (COM_ENEMY_STATES.IDLE):
        //idle sprite (set by child but implemented here)
        if (canPatrol) { //check for canPatrol because some enemies will be position locked
            state = COM_ENEMY_STATES.PATROLLING;
            break;
        }
    break;
    
    case (COM_ENEMY_STATES.PATROLLING):
        //patrol sprite (set by child but implemented here)
    
        //implement path stuff upon new branch
        //also implement moving back to patrol position
        
        alarm[0] = 60;
    
        if (distance_to_object(Obj_player) < aggroDist) and (instance_exists(Obj_player)) { //if player is within aggro distance, switch to chasing state
            state = COM_ENEMY_STATES.CHASING;
            break;
        }
    break;
    
    case (COM_ENEMY_STATES.CHASING):
        //chasing sprite (set by child but implemented here)
        if (distance_to_object(Obj_player) > loseAggroDist) { //if player is no longer within aggro distance, switch to patrolling state
            state = COM_ENEMY_STATES.PATROLLING;
            break;
        }
        x += clamp(targetX - x, -moveSpd, moveSpd);
    break;
    
    case (COM_ENEMY_STATES.ATTACKING):
        //attacking sprite (set by child but implemented here)
        //use attackDist to do a thing
    break;
    
}

//Gravity (put into its own external function)
if (!ignoreGrav) {
    yspd += global.grav;
    if yspd > global.termVel {
        yspd = global.termVel;
    }
}

var _subPixel = 0.5;
if place_meeting(x, y + yspd, tilemap) {
    yspd = 0;
}   

y = floor(y + yspd);

//var horiz = clamp(targetX - x, -1, 1);
//move_and_collide(horiz, y, tilemap); 
//    x += clamp(targetX - x, -1, 1);