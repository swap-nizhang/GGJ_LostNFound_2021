var damage = contact_damage;
var attackerId = id;
with (other) {
	takeHit(attackerId, damage);
}

var collision_direction = point_direction(id.x, id.y, other.x, other.y);
var collision_spreadout = 2;
other.x += lengthdir_x(collision_spreadout, collision_direction);
other.y += lengthdir_y(collision_spreadout, collision_direction);
id.x += lengthdir_x(collision_spreadout, 180-collision_direction);
id.y += lengthdir_y(collision_spreadout, 180-collision_direction);