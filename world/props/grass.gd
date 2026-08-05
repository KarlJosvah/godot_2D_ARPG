extends Node2D;

func _ready() -> void:
	pass;


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.owner is Player:
		queue_free();
