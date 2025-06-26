//Moving
moveDir = 0;
moveSpd = 2;
xspd = 0;
yspd = 0;

//jumping
gravScale = 1;
grav = gravScale * 0.3;
termVel = gravScale * 4.5;
jumpSpd = -6 * gravScale;


tilemap = layer_tilemap_get_id("colTiles");