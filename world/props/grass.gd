extends Node2D;

@export var GRASS_EFFECT : PackedScene;

func _ready() -> void:
	pass;


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.owner is Player:
		var grass_effect_instance = GRASS_EFFECT.instantiate();
		grass_effect_instance.global_position = self.global_position;
		self.get_tree().current_scene.add_child(grass_effect_instance);
		queue_free();
