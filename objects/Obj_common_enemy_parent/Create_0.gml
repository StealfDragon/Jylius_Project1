hp = 20;
moveSpd = 2;
aggroDist = 120;
loseAggroDist = 140;
attackDist = 10;
canPatrol = true;

targetX = x;
y -= 0.5; //might be leftover, check later

gravScale = 1; //put into global variables object/script
grav = gravScale * 0.3;
yspd = 0;
termVel = gravScale * 4.5;

alarm[0] = 60;

tilemap = layer_tilemap_get_id("colTiles"); //this too

state = C_ENEMY_STATES.STATE_IDLE;