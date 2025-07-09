//Moving
moveDir = 0;
moveSpd = 3.5;
xspd = 0;
yspd = 0;

//jumping
jumpSpd = -6 * global.gravScale;
jumpHoldTimer = 0;
coyoteTimeVal = 7;
framesWithJump = 0;
apexScale = 0.25

//inclines
stepHeight = 10;
xSubPixel = 0.5;
ySubPixel = 0.5;

tilemap = layer_tilemap_get_id("colTiles");

moveState = PLAYER_STATES.IDLE;
attackState = PLAYER_STATES.NULL;

cantRun = false;

dir = 1;