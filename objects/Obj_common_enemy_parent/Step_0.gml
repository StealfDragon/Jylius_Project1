//Gravity
yspd += grav;
if yspd > termVel {
    yspd = termVel;
}

var _subPixel = 0.5;
if place_meeting(x, y + yspd, Obj_wall) {
    
    //same approaching movement as before
    //var _pixelCheck = _subPixel * sign(yspd);
    //while !place_meeting(x, y+_pixelCheck, Obj_wall) {
        //y += _pixelCheck;
    //}
    
    
    //stop vertical movement
    yspd = 0;
}   

y = floor(y + yspd);


//var horiz = clamp(targetX - x, -1, 1);
//move_and_collide(horiz, y, Obj_wall);
x += clamp(targetX - x, -1, 1);