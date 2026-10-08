extends Area2D;
class_name HurtBox;

func take_damage(damage : float, hit_direction : Vector2) -> bool:
	if owner.has_method("take_damage"):
		owner.take_damage(damage, hit_direction);
		return true;
	return false;
