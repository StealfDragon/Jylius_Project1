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
        
        alarm[0] = 30;
    
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
        //x += clamp(targetX - x, -moveSpd, moveSpd);
    
        moveDir = sign(targetX - x)
        Horiz_Movement();
    break;
    
    case (COM_ENEMY_STATES.ATTACKING):
        //attacking sprite (set by child but implemented here)
        //use attackDist to do a thing
    break;
    
}

//Gravity (put into its own external function)
if (!ignoreGrav) {
    yspd = Apply_Grav(yspd);
}

var ySubPixel = 0.5;
if place_meeting(x, y + yspd, tilemap) {
    yspd = 0;
}   

y = floor(y + yspd);



function Horiz_Movement() {//x, y, xspd, yspd, tilemap, moveSpd, moveDir, stepHeight, ySubPixel, xSubPixel){
    xspd = moveSpd * moveDir;
        
    //X Collision
    if place_meeting(x + xspd, y, tilemap) {
        
        //Moving up a slope
        if (!place_meeting(x + xspd, y - stepHeight, tilemap)) {
            while place_meeting(x + xspd, y  - ySubPixel, tilemap){
                y -= ySubPixel;
            }
        } 
        else {
            //Scoot up to wall precisely
            var xPixelCheck = xSubPixel * sign(xspd); // method gets positive/negative value of xspd, useful for future complicated player movement
            if (xPixelCheck != 0) {
                while !place_meeting(x + xPixelCheck, y, tilemap) {
                    x += xPixelCheck;
                }
            }
            
            //Stop horizontal movement
            xspd = 0;
        }    
        
    }

    //Go down slopes
    if yspd >= 0 && !place_meeting(x + xspd, y + 1, tilemap) && place_meeting(x + xspd, y + stepHeight, tilemap) {
        while !place_meeting(x + xspd, y + ySubPixel, tilemap) {
            y += ySubPixel;
        }
    }
    
    //Move
    //x += xspd; 
    if (xspd != 0) {
        x += clamp(targetX - x, -moveSpd, moveSpd);
    }  
}