extends Area2D;
class_name HitBox;

signal hit(hurtbox : HurtBox);

func _on_area_entered(area : Area2D) -> void:
	if area is not HurtBox:
		return;
	hit.emit(area);
