//get inputs
rightKey = keyboard_check(vk_right);
leftKey = keyboard_check(vk_left);
jumpKeyPressed = keyboard_check_pressed(vk_space);

//X Movement
    moveDir = rightKey-leftKey;
    xspd = moveSpd * moveDir;
    
    //X Collision
    var _subPixel = .5;
    if place_meeting(x + xspd, y, Obj_wall) {
        
        //move up to wall precisely
        var _pixelCheck = _subPixel * sign(xspd); // method gets positive/negative value of xspd, useful for future complicated player movement
        while !place_meeting(x + _pixelCheck, y, Obj_wall) {
            x += _pixelCheck;
        }
        
        //stop horizontal movement
        xspd = 0;
        
    }
    
    //Move
    x += xspd;

//Y Movement
    //Gravity
    yspd += grav;
    if yspd > termVel {
        yspd = termVel;
    }

    //jump
    if jumpKeyPressed && place_meeting(x, y+1, Obj_wall) {
        yspd = jumpSpd;
    }

    //Y collision
    var _subPixel = 0.5;
    if place_meeting(x, y + yspd, Obj_wall) {
        
        //same approaching movement as before
        var _pixelCheck = _subPixel * sign(yspd);
        while !place_meeting(x, y+_pixelCheck, Obj_wall) {
            y += _pixelCheck;
        }
        
        //stop vertical movement
        yspd = 0;
        
        
    }   

    y += yspd; 
    
    
    