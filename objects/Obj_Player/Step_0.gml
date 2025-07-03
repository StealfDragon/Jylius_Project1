//get inputs (maybe switch these to instance variables later)
var rightKey = keyboard_check(vk_right);
var leftKey = keyboard_check(vk_left);
var jumpKeyPressed = keyboard_check_pressed(vk_space);

// Concurrent state machine
switch(moveState) {
    case(PLAYER_STATES.IDLE):
        //Sprite change
        changeSprite(Sprt_player_idle);
        //if (direction < 0)
            //changeSprite(Sprt_idle_left);
        //else
            //changeSprite(Sprt_idle_right); uncomment if/else when sprites in
        
        //State changes
        if (!place_meeting(x, y+1, tilemap)) {
            moveState = PLAYER_STATES.FALLING;
        }
        else if (rightKey or leftKey) {
            moveState = PLAYER_STATES.RUNNING; //MAYBE change to walk when walk sprite made
        }
        else if (jumpKeyPressed) {
            moveState = PLAYER_STATES.JUMPING;
        }
    break;
    case(PLAYER_STATES.WALKING):
        
    break;
    case(PLAYER_STATES.RUNNING):
        // ADD ACCELERATION
    
        //Sprite change
        if (moveSpd < 0) {
            //changeSprite(Sprt_running_right); uncomment when sprite in
        }
        else if (moveSpd > 0) {
            changeSprite(Sprt_running_left);
        }
        
        //Movement
        
        //X Movement
        moveDir = rightKey-leftKey;
        xspd = moveSpd * moveDir;
        
        //X Collision
        var _subPixel = 0.5;
        if place_meeting(x + xspd, y, tilemap) {
            
            // Moving up a slope
            if (!place_meeting(x + xspd, y - stepHeight, tilemap)) {
                while place_meeting(x + xspd, y  - _subPixel, tilemap){
                    y -= _subPixel;
                }
            } else {
                
            //Scoot up to wall precisely
            var _pixelCheck = _subPixel * sign(xspd); // method gets positive/negative value of xspd, useful for future complicated player movement
            while !place_meeting(x + _pixelCheck, y, tilemap) {
                x += _pixelCheck;
            }
            
            //stop horizontal movement
            xspd = 0;
            }    
            
        }
    
        //Go down slopes
        if yspd >= 0 && !place_meeting(x + xspd, y + 1, tilemap) && place_meeting(x + xspd, y + stepHeight, tilemap) {
            while !place_meeting(x + xspd, y + _subPixel, tilemap) {
                y += _subPixel;
            }
        }
        
        //Move
        x += xspd;    
    
        //State changes
        if (!place_meeting(x, y + 1, tilemap)) {
            moveState = PLAYER_STATES.FALLING;
        }
        else if (jumpKeyPressed) {
            moveState = PLAYER_STATES.JUMPING;
        }
    break;
    case(PLAYER_STATES.JUMPING):
        //Sprite change
        if (direction < 0) {
            //changeSprite(Sprt_jump_right); uncomment when sprite in
        }
        else if (direction > 0) {
            //changeSprite(Sprt_jump_left); uncomment when sprite in
        }
    
        //Movement
    
        //State changes
    break;
    case(PLAYER_STATES.FALLING):
        //Sprite change
    
        //Movement
    
        //State changes
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


////X Movement
    //moveDir = rightKey-leftKey;
    //xspd = moveSpd * moveDir;
//
////remove this later and add it to the state machine :(
    //if xspd > 0  && yspd == 0{
        //changeSprite(Sprt_running_right);
    //} else {
        //changeSprite(Sprt_player_idle)
    //}
    //
    ////X Collision
    //var _subPixel = .5;
    //if place_meeting(x + xspd, y, tilemap) {
        //
        //// Moving up a slope
        //if (!place_meeting(x + xspd, y - stepHeight, tilemap)) {
            //while place_meeting(x + xspd, y  - _subPixel, tilemap){
                //y -= _subPixel;
            //}
        //} else {
            //
        ////Scoot up to wall precisely
        //var _pixelCheck = _subPixel * sign(xspd); // method gets positive/negative value of xspd, useful for future complicated player movement
        //while !place_meeting(x + _pixelCheck, y, tilemap) {
            //x += _pixelCheck;
        //}
        //
        ////stop horizontal movement
        //xspd = 0;
        //}    
        //
    //}
//
    ////Go down slopes
    //if yspd >=0 && !place_meeting(x + xspd, y + 1, tilemap) && place_meeting(x + xspd, y + stepHeight, tilemap) {
        //while !place_meeting(x + xspd, y + _subPixel, tilemap) {
            //y += _subPixel;
        //}
    //}
    //
    ////Move
    //x += xspd;

//Y Movement
    //Gravity
    yspd += grav;
    if yspd > termVel {
        yspd = termVel;
    }

    //jump
    if jumpKeyPressed {
        if place_meeting(x, y+1, tilemap) {
            yspd = jumpSpd;
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
    }

    //Y collision
    var _subPixel = 0.5; //either remove var or make new variable later
    if place_meeting(x, y + yspd, tilemap) {
        
        //same approaching movement as before
        var _pixelCheck = _subPixel * sign(yspd);
        while !place_meeting(x, y+_pixelCheck, tilemap) {
            y += _pixelCheck;
        }
        
        //stop vertical movement
        yspd = 0;
        
    }   

    //y += yspd;
    y = floor(y + yspd); 

function changeSprite(spr) {
        if sprite_index != spr {
            sprite_index = spr;
        } 
}