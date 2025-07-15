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
var attackKeyPressed = keyboard_check_pressed(ord("C"));

// Concurrent state machine
switch(moveState) {
    case(PLAYER_STATES.IDLE): // ------------------------Idle
        //Sprite change
        if (dir == -1) {
            changeSprite(Sprt_player_idle_left);
        }
        else if (dir == 1){
            changeSprite(Sprt_player_idle_right);
        }
        
        Horiz_Movement();
        
        //State changes
        if (!place_meeting(x, y+stepHeight, tilemap)) {
            moveState = PLAYER_STATES.FALLING;
        }
        else if (rightKey or leftKey) {
            if !place_meeting(x + dir, y, tilemap) {
                moveState = PLAYER_STATES.RUNNING; //MAYBE change to walk when walk sprite made
            }
        }
        if (jumpKeyPressed) {
            yspd = jumpSpd;
            moveState = PLAYER_STATES.JUMPING;
        }
    break;
    case(PLAYER_STATES.WALKING):// ------------------------Walking
    break;
    case(PLAYER_STATES.RUNNING):// ------------------------Running
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
            moveState = PLAYER_STATES.APEX;
            framesWithJump = coyoteTimeVal;
        }
        else if (jumpKeyPressed) {
            yspd = jumpSpd;
            moveState = PLAYER_STATES.JUMPING;
        }
        else if (moveDir == 0) {
            moveState = PLAYER_STATES.IDLE;
        }
    break;
    case(PLAYER_STATES.JUMPING): // ------------------------Jumping
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
        if place_meeting(x, y + yspd, tilemap) {
            
            //same approaching movement as before
            var yPixelCheck = ySubPixel * sign(yspd);
            while !place_meeting(x, y + yPixelCheck, tilemap) {
                y += yPixelCheck;
            }
            
            //stop vertical movement
            yspd = 0;
            //moveState = PLAYER_STATES.FALLING;
        }   
    
        //if place_meeting(x + xspd, y + yspd, tilemap) {
            //move_and_collide(0, 0, tilemap);
            //yspd = 0;
        //}
        if (yspd >= -3 * apexScale) {
            moveState = PLAYER_STATES.APEX;
        }
        else {
    	    y = floor(y + yspd); 
        }
    break;
    
    case(PLAYER_STATES.APEX): // ------------------------Apex
        //Coyote Time
         if framesWithJump > 0 { 
            if (jumpKeyPressed) {
                yspd = jumpSpd;
                moveState = PLAYER_STATES.JUMPING;
            } else {
                framesWithJump--; 
            }
        }    
    
        //Sprite change
        if (dir > 0) {
            changeSprite(Sprt_apex_right);
        }
        else if (dir < 0) {
            changeSprite(Sprt_apex_left);
        }
    
        //vertical speed sprite changes
        if sprOverride == false {
            if (-3 * apexScale < yspd < -apexScale) {
                image_index = 1;
            }
            else if (-apexScale < yspd < apexScale) {
                image_index = 2;
            }
            else if (apexScale < yspd < 3 * apexScale) {
                image_index = 3;
            } else if (yspd >= 3 * apexScale) {
                moveState = PLAYER_STATES.FALLING;
            }
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
    
    case(PLAYER_STATES.FALLING): // ------------------------Falling
        if framesWithJump > 0 { 
            if (jumpKeyPressed) {
                yspd = jumpSpd;
                moveState = PLAYER_STATES.JUMPING;
            } else {
                framesWithJump--; 
            }
        }    
    
    
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
        if (attackKeyPressed) {
            whipStart = true;
            switch(whipCount) {
                case(1):
                attackState = PLAYER_STATES.WHIP1;
                break;
                
                case(2):
                attackState = PLAYER_STATES.WHIP2;
                break;
                
                case(3):
                attackState = PLAYER_STATES.WHIP3;
                break;
                
            }
            
        }
    break;
    case(PLAYER_STATES.WHIP1):
        
        if whipStart == true {
            whipStart = false;
            whipCount = 2;
            show_debug_message("one");
            show_debug_message(whipCount);
            
            //set sprite and have it override any sprite change calls
            sprOverride = true;
            if (dir > 0) {
                sprite_index = Sprt_whip_1_right;
            }
            else if (dir < 0) {
                sprite_index = Sprt_whip_1_left;
            }
            image_index = 0;
            
            //change movement
            acceleration = 0.2;
            xspd = 0;
            if yspd > 0 {
                yspd = 0;
            }
            
            //set alarm that ends cooldown for whip usage
            whippable = false;
            alarm[1] = 16;
            
            //set alarm to end sprite and change movement back
            alarm[0] = 20;
            
            //set alarm to reset whip counter;
            alarm[2] = 60;
        }
            
    if (!whipStart) && (attackKeyPressed || whipBuffer > 0) && whippable {
        whipStart = true;
        sprOverride = false;
        attackState = PLAYER_STATES.WHIP2;
    } else if attackKeyPressed {
        whipBuffer = 9
    }
    if whipBuffer > 0 {
        whipBuffer --
    }
    
    break;
    case(PLAYER_STATES.WHIP2):
        if whipStart == true {
            whipStart = false;
            whipCount = 3;
            show_debug_message("two");
            show_debug_message(whipCount);
            
            //set sprite and have it override any sprite change calls
            sprOverride = true;
            if (dir > 0) {
                sprite_index = Sprt_whip_2_right;
            }
            else if (dir < 0) {
                sprite_index = Sprt_whip_2_left;
            }
            image_index = 0;
            
            //change movement
            acceleration = 0.2;
            xspd = 0;
            if yspd > 0 {
                yspd = 0;
            }
            
            //set alarm that ends cooldown for whip usage
            whippable = false;
            alarm[1] = 16;
            
            //set alarm to end sprite and change movement back
            alarm[0] = 20
            
            //set alarm to reset whip counter;
            alarm[2] = 60;
        }
    if (!whipStart) && (attackKeyPressed || whipBuffer > 0) && whippable {
        whipStart = true;
        sprOverride = false;
        attackState = PLAYER_STATES.WHIP3;
    } else if attackKeyPressed {
        whipBuffer = 9
    }
    if whipBuffer > 0 {
        whipBuffer --
    }
    break;
    case(PLAYER_STATES.WHIP3):
         if whipStart == true {
            whipStart = false;
            whipCount = 1;
            show_debug_message("three");
            show_debug_message(whipCount);
            
            //set sprite and have it override any sprite change calls
            sprOverride = true;
            if (dir > 0) {
                sprite_index = Sprt_whip_3_right;
            }
            else if (dir < 0) {
                sprite_index = Sprt_whip_3_left;
            }
            image_index = 0;
            
            //change movement
            acceleration = 0.2;
            xspd = 0;
            if yspd > 0 {
                yspd = 0;
            }
            
            //set alarm that ends cooldown for whip usage
            whippable = false;
            alarm[1] = 18;
            
            //set alarm to end sprite and change movement back
            alarm[0] = 22;
        }
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
        if sprOverride == false && sprite_index != spr {
            sprite_index = spr;
        } 
}


function Horiz_Movement() {//x, y, xspd, yspd, tilemap, moveSpd, moveDir, stepHeight, ySubPixel, xSubPixel){
    //xspd = moveSpd * moveDir; // old code for calculating x velocity
    
    //new xspd code (uses acceleration)
    if moveDir == 0 {
        if abs(xspd) > 0 {
            a = sign(xspd);
            xspd -= sign(xspd) * acceleration;
            b = sign(xspd);
            
            //if player switches direction due to deceleration calculations, stop player movement
            if a != b {
                xspd = 0;
            }
        }
    } else if abs(xspd) < moveSpd {
        xspd += moveDir * acceleration;
    } else if xspd = -1 * (moveDir * moveSpd){ // this case accounts for if the player switches direction without slowing down
        xspd -= sign(xspd) * acceleration;
    } else {
        xspd = moveDir * moveSpd;
    }
    
    
        
    //X Collision
    if place_meeting(x + xspd, y, tilemap) {
        
        //Moving up a slope
        if (!place_meeting(x + xspd, y - stepHeight , tilemap)) {
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
            //moveState = PLAYER_STATES.IDLE;
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