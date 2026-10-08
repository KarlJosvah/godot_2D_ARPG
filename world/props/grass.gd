extends Node2D;

@export var GRASS_EFFECT : PackedScene;

func _on_hurt_box_hurt(hitbox: HitBox, damage : float) -> void:
	if hitbox.owner is not Player:
		return;
	if damage > 0:
		self._trigger_grass_effect();
		self.queue_free();

func _trigger_grass_effect() -> void:
	var grass_effect_instance = GRASS_EFFECT.instantiate();
	grass_effect_instance.global_position = self.global_position;
	self.get_tree().current_scene.add_child(grass_effect_instance);
