extends Area2D;
class_name HitBox;

@export_range(0.0, 10.0, 0.1, "or_greater") var damage : float = 1.0;
@export var knockback_power : float = 150.0;
var knockback_direction : Vector2 = Vector2.ZERO;
signal hit(hurtbox : HurtBox);

func _on_area_entered(area : Area2D) -> void:
	if area is not HurtBox:
		return;
	hit.emit(area as HurtBox);

func get_damage() -> float:
	return self.damage;

func set_knockback_direction(direction : Vector2) -> void:
	if direction != Vector2.ZERO:
		self.knockback_direction = direction;

func get_knockback_direction() -> Vector2:
	return self.knockback_direction;

func get_knowckback_power() -> float:
	return self.knockback_power;
