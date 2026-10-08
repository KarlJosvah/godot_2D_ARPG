extends Area2D;
class_name HitBox;

@export var can_damage : bool = true;
const DEFAULT_DAMAGE : float = 1.0;
var damage : float;

func _ready() -> void:
	if owner.has_method("get_damage"):
		self.damage = owner.get_damage();
	else:
		self.damage = self.DEFAULT_DAMAGE;

func set_enable(enable : bool) -> void:
	self.can_damage = enable;

func _on_area_entered(area: Area2D) -> void:
	if not self.can_damage:
		return;
	if area is HurtBox:
		(area as HurtBox).take_damage(self.damage, owner.global_position);
		if self.owner.has_method("hitted_something"):
			self.owner.hitted_something();
