//get inputs
rightKey = keyboard_check(vk_right);
leftKey = keyboard_check(vk_left);
jumpKeyPressed = keyboard_check_pressed(vk_space);


//X Movement
    moveDir = rightKey-leftKey;
    xspd = moveSpd * moveDir;
    
    //X Collision
    var _subPixel = .5;
    if place_meeting(x + xspd, y, tilemap) {
        
        //move up to wall precisely
        var _pixelCheck = _subPixel * sign(xspd); // method gets positive/negative value of xspd, useful for future complicated player movement
        while !place_meeting(x + _pixelCheck, y, tilemap) {
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
    if jumpKeyPressed && place_meeting(x, y+1, tilemap) {
        yspd = jumpSpd;
    }

    //Y collision
    var _subPixel = 0.5;
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
    
    
    