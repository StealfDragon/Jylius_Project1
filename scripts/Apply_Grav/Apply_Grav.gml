function Apply_Grav(_yspd){
    _yspd += global.grav;
    return min(_yspd, global.termVel);
}