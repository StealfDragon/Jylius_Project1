switch(state) {
    case (C_ENEMY_STATES.STATE_IDLE):
        //idle sprite (set by child but implemented here)
        if (canPatrol) { //check for canPatrol because some enemies will be position locked
            state = C_ENEMY_STATES.STATE_PATROLLING;
            break;
        }
    break;
    
    case (C_ENEMY_STATES.STATE_PATROLLING):
        //patrol sprite (set by child but implemented here)
    
        //implement path stuff upon new branch
        //also implement moving back to patrol position
    
        if (x - Obj_player.x < aggroDist or Obj_player.x - x < aggroDist) and (instance_exists(Obj_player)) { //if player is within aggro distance, switch to chasing state
            state = C_ENEMY_STATES.STATE_CHASING;
            break;
        }
    break;
    
    case (C_ENEMY_STATES.STATE_CHASING):
        //chasing sprite (set by child but implemented here)
        if (x - Obj_player.x > loseAggroDist or Obj_player.x - x > loseAggroDist) { //if player is no longer within aggro distance, switch to patrolling state
            state = C_ENEMY_STATES.STATE_PATROLLING;
            break;
        }
        x += clamp(targetX - x, -moveSpd, moveSpd);
    break;
    
    case (C_ENEMY_STATES.STATE_ATTACKING):
        //attacking sprite (set by child but implemented here)
        //use attackDist to do a thing
    break;
    
}

//Gravity (put into its own external function)
yspd += grav;
if yspd > termVel {
    yspd = termVel;
}

var _subPixel = 0.5;
if place_meeting(x, y + yspd, tilemap) {
    
    //same approaching movement as before
    //var _pixelCheck = _subPixel * sign(yspd);
    //while !place_meeting(x, y+_pixelCheck, tilemap) {
        //y += _pixelCheck;
    //}
    
    
    //stop vertical movement
    yspd = 0;
}   

y = floor(y + yspd);

//var horiz = clamp(targetX - x, -1, 1);
//move_and_collide(horiz, y, tilemap);
x += clamp(targetX - x, -1, 1);