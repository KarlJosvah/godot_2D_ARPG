extends CharacterBody2D;

@onready var sprite_2d: Sprite2D = $Sprite2D;
@onready var animation_tree: AnimationTree = $AnimationTree;
@onready var playback : AnimationNodeStateMachinePlayback = animation_tree.get("parameters/StateMachine/playback") as AnimationNodeStateMachinePlayback;

func _physics_process(_delta: float) -> void:
	var state = self.playback.get_current_node();
	match state:
		"Idle" : pass;
		"Chase" : pass;
