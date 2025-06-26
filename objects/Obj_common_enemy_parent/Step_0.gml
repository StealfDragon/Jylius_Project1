//Gravity
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