event_inherited();

if (!instance_exists(o_player)) {state = AI_IDLE;}
// AI State management
var next_state = state;
switch (state) {
	case AI_IDLE:
		if (idle_move_cooldown-- <= 0) {
			idle_move_cooldown = irandom_range(idle_move_cooldown_min, idle_move_cooldown_max);
			var move_dist = irandom_range(idle_move_range_min, idle_move_range_max);
			var move_dir = irandom_range(0,360);
			move_target[0] = x + lengthdir_x(move_dist, move_dir);
			move_target[1] = y + lengthdir_y(move_dist, move_dir);
		}
		if (idle_aggro_timer-- <= 0 || (instance_exists(o_player) && distance_to_object(o_player)) < idle_aggro_distance) {
			next_state = AI_AGGRO;
			break;
		}
		break;
	case AI_AGGRO:
		if (distance_to_object(o_player) >= aggro_attack_range_min && distance_to_object(o_player) <= aggro_attack_range_max) {
			if (aggro_attack_cooldown-- <= 0) {
				aggro_attack_cooldown = irandom_range(aggro_attack_cooldown_min, aggro_attack_cooldown_min);
				attack_target[0] = o_player.x;
				attack_target[1] = o_player.y;
				move_target = [];
			}
		} else if (aggro_move_cooldown-- <= 0) {
			aggro_move_cooldown = irandom_range(aggro_move_cooldown_min, aggro_move_cooldown_min);
			var move_dist = irandom_range(aggro_move_range_min, aggro_move_range_max);
			var move_dir = point_direction(x, y, o_player.x, o_player.y);
			move_target[0] = x + lengthdir_x(move_dist, move_dir);
			move_target[1] = y + lengthdir_y(move_dist, move_dir);
		}
		break;
	case AI_RETREAT:
		break;
}

state = next_state;

// attack virtual function her
if (array_length_1d(attack_target) > 0) {
	//draw correct direction
	var attack_direction = point_direction(x, y, attack_target[0], attack_target[1]);
	image_xscale = (attack_direction > 90 && attack_direction < 270) ? -1 : 1;
	switch (aggro_attack_method) {
		case ATTACK_DASH:
			if (aggro_attack_delay-- <= 0) {
				aggro_attack_delay = irandom_range(aggro_attack_delay_min, aggro_attack_delay_max);
				attack_target = moveTo(attack_target[0], attack_target[1], movespeed * aggro_attack_dash_multi);
				return;
			}
			break;
		case ATTACK_PROJ:
			if (aggro_attack_delay-- <= 0) {
				aggro_attack_delay = irandom_range(aggro_attack_delay_min, aggro_attack_delay_max);
				var newProj = instance_create_layer(x, y, "Effects", aggro_attack_projectile_object);
				var mobId = id;
				with (newProj) {
					parent_id = mobId;
					projectile_start = [mobId.x, mobId.y];
					projectile_target = mobId.attack_target;
				}
				attack_target = [];
				return;
			}
			break;
	}
}

if (array_length_1d(move_target) > 0) {
	//draw correct direction
	var move_direction = point_direction(x, y, move_target[0], move_target[1]);
	image_xscale = (move_direction > 90 && move_direction < 270) ? -1 : 1;
	move_target = moveTo(move_target[0], move_target[1], movespeed);
	return;
}