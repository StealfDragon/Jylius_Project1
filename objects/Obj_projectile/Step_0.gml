//repeatedly check for damage
var collided_instance_id = instance_place(x, y, Obj_player);

if (collided_instance_id != noone) {
    collided_instance_id.takeDamage(damage, sign(xspd) * 5);
    instance_destroy();
}