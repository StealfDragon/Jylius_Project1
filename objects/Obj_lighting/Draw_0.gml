if surface_exists(light_surf) { 
    surface_set_target(light_surf);
    draw_clear(c_black);
    
    with (Obj_light) {
        gpu_set_blendmode(bm_normal);
        draw_sprite_ext(Sprt_simple_light, 0, x, y, 0.4, 0.4, 0, c_white, .7);
    }
    
    with (Obj_siren) {
        gpu_set_blendmode(bm_normal);
        draw_sprite_ext(Sprt_siren_light_2, floor(imageFrame), x, y, 0.6, 0.6, 0, c_white, .7);
    }
    
    gpu_set_blendmode(bm_normal);
    surface_reset_target();
    draw_surface_ext(light_surf, 0, 0, 1, 1, 0, c_white, darkness);
    
    
} else {
    light_surf = surface_create(room_width, room_height);
}