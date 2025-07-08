//get inputs (maybe switch these to instance variables later)
var rightKey = keyboard_check(vk_right);
var leftKey = keyboard_check(vk_left);
if keyboard_check(vk_right) {
    dir = 1;
}
if keyboard_check(vk_left) {
    dir = -1;
}
var jumpKeyPressed = keyboard_check_pressed(vk_space);

// Concurrent state machine
switch(moveState) {
    case(PLAYER_STATES.IDLE):
        //Sprite change
        if (dir == -1) {
            changeSprite(Sprt_player_idle_left);
        }
        else if (dir == 1){
            changeSprite(Sprt_player_idle_right);
        }
        
        //State changes
        if (!place_meeting(x, y+stepHeight, tilemap)) {
            moveState = PLAYER_STATES.FALLING;
        }
        else if (rightKey or leftKey) {
            if !place_meeting(x + dir, y, tilemap) {
                moveState = PLAYER_STATES.RUNNING; //MAYBE change to walk when walk sprite made
            }
        }
        else if (jumpKeyPressed) {
            yspd = jumpSpd;
            moveState = PLAYER_STATES.JUMPING;
        }
    break;
    case(PLAYER_STATES.WALKING):
    break;
    case(PLAYER_STATES.RUNNING):
        //ADD ACCELERATION
    
        //Sprite change
        if (moveDir > 0) {
            changeSprite(Sprt_running_right);
            dir = 1; 
        }
        else if (moveDir < 0) {
            changeSprite(Sprt_running_left);
            dir = -1; 
        }
        
        //X Movement
        moveDir = rightKey-leftKey;
        Horiz_Movement();
    
        //State changes
        if (!place_meeting(x, y + 1, tilemap)) {
            moveState = PLAYER_STATES.FALLING;
        }
        else if (jumpKeyPressed) {
            yspd = jumpSpd;
            moveState = PLAYER_STATES.JUMPING;
        }
        else if (moveDir == 0) {
            moveState = PLAYER_STATES.IDLE;
        }
    break;
    case(PLAYER_STATES.JUMPING):
        //Sprite change
        if (dir > 0) {
            changeSprite(Sprt_jumping_right);
        }
        else if (dir < 0) {
            changeSprite(Sprt_jumping_left);
        }
    
        //Movement
        moveDir = rightKey-leftKey;
        Horiz_Movement();
    
        yspd = Apply_Grav(yspd);
    
        //State changes
        //if place_meeting(x, y - yspd, tilemap) {
            //
            ////same approaching movement as before
            //var yPixelCheck = ySubPixel * sign(yspd);
            //while !place_meeting(x, y + yPixelCheck, tilemap) {
                //y += yPixelCheck;
            //}
            //
            ////stop vertical movement
            //yspd = 0;
            //moveState = PLAYER_STATES.FALLING;
        //}   
    
        if place_meeting(x + xspd, y + yspd, tilemap) {
            move_and_collide(0, 0, tilemap);
            yspd = 0;
        }
        if (yspd >= 0) {
            moveState = PLAYER_STATES.FALLING;
        }
        else {
    	    y = floor(y + yspd); 
        }
    break;
    case(PLAYER_STATES.FALLING):
        //Sprite change
        if (dir > 0) {
            changeSprite(Sprt_falling_right);
        }
        else if (dir < 0) {
            changeSprite(Sprt_falling_left);
        }
    
        //Movement
        moveDir = rightKey-leftKey;
        Horiz_Movement();
        
        yspd = Apply_Grav(yspd);
    
        //State changes
        if place_meeting(x, y + yspd, tilemap) {
            
            //same approaching movement as before
            var yPixelCheck = ySubPixel * sign(yspd);
            while !place_meeting(x, y + yPixelCheck, tilemap) {
                y += yPixelCheck;
            }
            
            //stop vertical movement
            yspd = 0;
            if (xspd != 0){
                moveState = PLAYER_STATES.RUNNING;
            }
            else {
                moveState = PLAYER_STATES.IDLE;
            }
        }   
    
        if (jumpKeyPressed) {
            if place_meeting(x, y+1, tilemap) {
                yspd = jumpSpd;
                moveState = PLAYER_STATES.JUMPING;
            } 
            // Input buffering (forgiveness frames)
            else {
                jumpHoldTimer = 5;
            }
        }
        if !place_meeting(x, y+1, tilemap) && jumpHoldTimer != 0 {
            jumpHoldTimer --;
        }
        if place_meeting(x, y+1, tilemap) && jumpHoldTimer > 0{
            jumpHoldTimer = 0;
            yspd = jumpSpd;
            moveState = PLAYER_STATES.JUMPING;
        }
    
        y = floor(y + yspd); 
    break;
}

switch(attackState) {
    case(PLAYER_STATES.NULL):
        //set back to previous sprite
    break;
    case(PLAYER_STATES.PRIMARY_ATTACK):
        
    break;
    case(PLAYER_STATES.ATTACK_COMBO):
        
    break;
    case(PLAYER_STATES.SHOOT):
        
    break;
    case(PLAYER_STATES.BLOCK):
        
    break;
    case(PLAYER_STATES.PARRY):
        
    break;
}



function changeSprite(spr) {
        if sprite_index != spr {
            sprite_index = spr;
        } 
}

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
            moveState = PLAYER_STATES.IDLE;
        }    
        
    }

    //Go down slopes
    if yspd >= 0 && !place_meeting(x + xspd, y + 1, tilemap) && place_meeting(x + xspd, y + stepHeight, tilemap) {
        while !place_meeting(x + xspd, y + ySubPixel, tilemap) {
            y += ySubPixel;
        }
    }
    
    //Move
    x += xspd;    
}