event_inherited();

move_target = [];
attack_target = [];

state = AI_IDLE;

idle_move_range_min = 32;
idle_move_range_max = 32;

idle_move_cooldown = 0;
idle_move_cooldown_min = 120;
idle_move_cooldown_max = 180;

idle_aggro_distance = 120;

idle_aggro_timer = 0;
idle_aggro_timer_min = 300;
idle_aggro_timer_max = 900;

aggro_move_range_min = 32;
aggro_move_range_max = 32;

aggro_move_cooldown = 0;
aggro_move_cooldown_min = 55;
aggro_move_cooldown_max = 65;

aggro_attack_range_min = 0;
aggro_attack_range_max = 64;

aggro_attack_cooldown = 0;
aggro_attack_cooldown_min = 45;
aggro_attack_cooldown_max = 45;

aggro_attack_delay = 0;
aggro_attack_delay_min = 0;
aggro_attack_delay_max = 0;
aggro_attack_dash_multi = 1;

contact_damage = 1;

aggro_attack_method = ATTACK_DASH;

aggro_attack_projectile_object = noone;