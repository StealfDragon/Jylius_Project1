switch(state) {
    case (COM_ENEMY_STATES.IDLE):
        if (dir == -1) {
            changeSprite(Com_Enemy_Temp);
            image_xscale = -1;
        }
        else if (dir == 1){
            changeSprite(Com_Enemy_Temp);
            image_xscale = 1;
        }
    
        //idle sprite (set by child but implemented here)
        if (canPatrol) { //check for canPatrol because some enemies will be position locked
            state = COM_ENEMY_STATES.PATROLLING;
        }
    break;
    
    case (COM_ENEMY_STATES.PATROLLING):
        //patrol sprite (set by child but implemented here)
        //if (dir <= 0) {
            //changeSprite(Com_Enemy_Temp);
            //image_xscale = -1;
        //}
        //else if (dir == 1){
            //changeSprite(Com_Enemy_Temp);
            //image_xscale = 1;
        //}
    
        //implement path stuff upon new branch
        //also implement moving back to patrol position
        
        alarm[0] = 30;
    
        if (distance_to_object(Obj_player) < aggroDist) and (instance_exists(Obj_player)) { //if player is within aggro distance, switch to chasing state
            state = COM_ENEMY_STATES.CHASING;
        }
    break;
    
    case (COM_ENEMY_STATES.CHASING):
        show_debug_message("in chasing state");
        //chasing sprite (set by child but implemented here)
        if (dir == -1) {
            changeSprite(Com_Enemy_Temp_Chase);
            image_xscale = -1;
        }
        else if (dir == 1){
            changeSprite(Com_Enemy_Temp_Chase);
            image_xscale = 1;
        }
    
        if (distance_to_object(Obj_player) < attackDist and canAttack) {
            attackFrameNum = 1;
            state = COM_ENEMY_STATES.ATTACKING;
            break;
        }
        if (distance_to_object(Obj_player) > loseAggroDist) { //if player is no longer within aggro distance, switch to patrolling state
            state = COM_ENEMY_STATES.PATROLLING;
        }
            
    
        //x += clamp(targetX - x, -moveSpd, moveSpd);
    
        moveDir = sign(targetX - x);
        if (targetX - x != 0) {
            dir = -sign(targetX - x);
        }
        Horiz_Movement();
    break;
    
    case (COM_ENEMY_STATES.ATTACKING):
        show_debug_message("in attacking state");
        attackFrameNum++;
        //attacking sprite (set by child but implemented here)
        //if (dir == -1) {
            //changeSprite(Com_Enemy_Temp_Atk);
            //image_xscale = -1;
        //}
        //else if (dir == 1){
            //changeSprite(Com_Enemy_Temp_Atk);
            //image_xscale = 1;
        //}
        
        if (image_index == sprite_get_number(Com_Enemy_Temp_Atk)) {
            alarm[1] = attackCooldown;
            show_debug_message("set alarm");
            canAttack = false;
            state = COM_ENEMY_STATES.CHASING;
        }
        if (attackFrameNum == 60) {
            alarm[1] = attackCooldown;
            //show_debug_message("set alarm");
            canAttack = false;
            state = COM_ENEMY_STATES.CHASING;
        }
        
        
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

function changeSprite(spr) {
    if sprite_index != spr {
        sprite_index = spr;
    } 
}