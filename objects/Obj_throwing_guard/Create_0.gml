hp = 20;
moveSpd = 3.3;
aggroDist = 250;
loseAggroDist = aggroDist + 50;
attackDist = 150;
stopAttackDist = 180;
canPatrol = true;
ignoreGrav = false;

canAttack = true;
attackCooldown = 90;
attackFrameNum = 1;

if (instance_exists(Obj_player)) {
    targetX = Obj_player.x;
} else {
    targetX = x;
}


moveDir = 0;
dir = 1;

stepHeight = 10;
xSubPixel = 0.5;
ySubPixel = 0.5;

yspd = 0;

tilemap = layer_tilemap_get_id("colTiles");

state = COM_ENEMY_STATES.IDLE;