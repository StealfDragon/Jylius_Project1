//Moving
moveDir = 0;
moveSpd = 3.5;
xspd = 0;
yspd = 0;

//jumping
jumpSpd = -6 * global.gravScale;
jumpHoldTimer = 0;
_subPixel = 0.5;

//inclines
stepHeight = 10;

tilemap = layer_tilemap_get_id("colTiles");

moveState = PLAYER_STATES.IDLE;
attackState = PLAYER_STATES.NULL;