targetX = target_id.x;
x += floor(xspd);
xspd -= xdirection * 0.3;
if (xdirection < 0 && x > targetX) || (xdirection > 0 && x <  targetX) {
    instance_destroy();
}