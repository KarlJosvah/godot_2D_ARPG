extends Area2D;
class_name HitBox;

@export_range(0.0, 10.0, 0.1, "or_greater") var damage : float = 1.0;

signal hit(hurtbox : HurtBox, damage);

func _on_area_entered(area : Area2D) -> void:
	if area is not HurtBox:
		return;
	hit.emit(area, self.damage);

func get_damage() -> float:
	return self.damage;
