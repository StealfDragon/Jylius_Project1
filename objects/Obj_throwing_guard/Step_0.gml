switch(state) {
    case (COM_ENEMY_STATES.IDLE):
        if (dir <= 0) {
            changeSprite(Prison_Guard);
            image_xscale = -1;
        }
        else if (dir == 1){
            changeSprite(Prison_Guard);
            image_xscale = 1;
        }
    
        //idle sprite (set by child but implemented here)
        if (canPatrol) { //check for canPatrol because some enemies will be position locked
            state = COM_ENEMY_STATES.PATROLLING;
        }
    break;
    
    case (COM_ENEMY_STATES.PATROLLING):
        //patrol sprite (set by child but implemented here)
        //if (dir <= 0) {
            //changeSprite(Com_Enemy_Temp);
            //image_xscale = -1;
        //}
        //else if (dir == 1){
            //changeSprite(Com_Enemy_Temp);
            //image_xscale = 1;
        //}
    
        //implement path stuff upon new branch
        //also implement moving back to patrol position
        
        alarm[0] = 30;
    
        if (distance_to_object(Obj_player) < aggroDist) and (instance_exists(Obj_player)) { //if player is within aggro distance, switch to chasing state
            state = COM_ENEMY_STATES.CHASING;
        }
    break;
    
    case (COM_ENEMY_STATES.CHASING):
        //chasing sprite (set by child but implemented here)
        if (dir <= 0) {
            changeSprite(Prison_Guard);
            image_xscale = -1;
        }
        else if (dir == 1){
            changeSprite(Prison_Guard);
            image_xscale = 1;
        }
    
        if (distance_to_object(Obj_player) < attackDist and canAttack) {
            state = COM_ENEMY_STATES.ATTACKING;
            break;
        }
        if (distance_to_object(Obj_player) > loseAggroDist) { //if player is no longer within aggro distance, switch to patrolling state
            state = COM_ENEMY_STATES.PATROLLING;
        }
            
    
        //x += clamp(targetX - x, -moveSpd, moveSpd);
    
        moveDir = sign(targetX - x)
        dir = -sign(targetX - x)
        //Horiz_Movement();
    break;
    
    case (COM_ENEMY_STATES.ATTACKING):
        //attacking sprite (set by child but implemented here)
        //if (dir <= 0) {
            //changeSprite(Prison_Guard);
            //image_xscale = -1;
        //}
        //else if (dir == 1){
            //changeSprite(Prison_Guard);
            //image_xscale = 1;
        //}
        
        //if (image_index == sprite_get_number((Prison_Guard))) {
            //state = COM_ENEMY_STATES.CHASING;
            //alarm[1] = attackCooldown;
            //canAttack = false;
        //}
    
        dir = -sign(targetX - x)
        if (distance_to_object(Obj_player) > stopAttackDist) {
            state = COM_ENEMY_STATES.CHASING;
        }
    break;
    
}

//Gravity (put into its own external function)
if (!ignoreGrav) {
    yspd = Apply_Grav(yspd);
}

var ySubPixel = 0.5;
if place_meeting(x, y + yspd, tilemap) {
    yspd = 0;
}   

y = floor(y + yspd);

function changeSprite(spr) {
    if sprite_index != spr {
        sprite_index = spr;
    } 
}