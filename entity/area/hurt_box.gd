extends Area2D;
class_name HurtBox;

signal hurt(hitbox : HitBox);

func _on_area_entered(area : Area2D) -> void:
	if area is not HitBox:
		return;
	var damage := (area as HitBox).get_damage();
	hurt.emit(area, damage);
