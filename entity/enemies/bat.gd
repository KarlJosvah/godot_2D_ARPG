extends CharacterBody2D;

@export var detection_range := 128.0;
@export var speed := 30.0;

@onready var sprite_2d: Sprite2D = $Sprite2D;
@onready var animation_tree: AnimationTree = $AnimationTree;
@onready var playback : AnimationNodeStateMachinePlayback = animation_tree.get("parameters/StateMachine/playback") as AnimationNodeStateMachinePlayback;

func _physics_process(_delta: float) -> void:
	var state = self.playback.get_current_node();
	match state:
		"Idle" : self._idle();
		"Chase" : self._chase();

func _idle() -> void:
	pass;

func _chase() -> void:
	var player = self._get_player();
	
	if player is Player:
		player = player as Player;
		var direction : Vector2 = self.global_position.direction_to(player.global_position);
		velocity = direction * self.speed;
	else:
		self.velocity = Vector2.ZERO;
	
	move_and_slide();

func _get_player() -> Player:
	return get_tree().get_first_node_in_group("player");

func _is_player_in_range() -> bool:
	var player : Player = self._get_player();
	
	if player is not Player:
		return false;
	
	var distance_to_player = self.global_position.distance_to(player.global_position);
	if distance_to_player <= self.detection_range:
		return true;
	else:
		return false;
