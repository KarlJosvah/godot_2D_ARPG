extends Node2D;

@export var GRASS_EFFECT : PackedScene;

func _ready() -> void:
	pass;

func take_damage(_damage : float, _hit_position : Vector2):
	var grass_effect_instance = GRASS_EFFECT.instantiate();
	grass_effect_instance.global_position = self.global_position;
	self.get_tree().current_scene.add_child(grass_effect_instance);
	queue_free();
