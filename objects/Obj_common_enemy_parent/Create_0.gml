hp = 20;
moveSpd = 3.3;
aggroDist = 250;
loseAggroDist = aggroDist + 50;
attackDist = 10;
canPatrol = true;
ignoreGrav = false;

targetX = x;

yspd = 0;

tilemap = layer_tilemap_get_id("colTiles");

state = COM_ENEMY_STATES.IDLE;