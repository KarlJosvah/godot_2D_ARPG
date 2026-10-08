extends CharacterBody2D;

@export var detection_range := 128.0;
@export var speed := 30.0;

var player_is_visible : bool = false;

@onready var sprite_2d: Sprite2D = $Sprite2D;
@onready var animation_tree: AnimationTree = $AnimationTree;
@onready var playback : AnimationNodeStateMachinePlayback = animation_tree.get("parameters/StateMachine/playback") as AnimationNodeStateMachinePlayback;

func _physics_process(_delta: float) -> void:
	self.player_is_visible = self._check_player_visibility();
	
	var state = self.playback.get_current_node();
	match state:
		"Idle" : self._idle();
		"Chase" : self._chase();

func _idle() -> void:
	pass;

func _chase() -> void:
	var player = self._get_player();
	
	if self._player_is_valid(player):
		player = player as Player;
		var direction : Vector2 = self.global_position.direction_to(player.global_position);
		velocity = direction * self.speed;
	else:
		self.velocity = Vector2.ZERO;
	
	self._adjust_sprite_orientation();
	move_and_slide();

func _adjust_sprite_orientation() -> void:
	self.sprite_2d.scale.x = sign(self.velocity.x);

func _get_player() -> Player:
	return get_tree().get_first_node_in_group("player");
	
func _player_is_valid(target) -> bool:
	if not is_instance_valid(target):
		return false;
	if target is not Player:
		return false;
	return true;

func _check_player_visibility() -> bool:
	var player := self._get_player();
	if not self._player_is_valid(player):
		return false;
	
	if not self.is_player_in_range():
		return false;
	
	var space_state : PhysicsDirectSpaceState2D = self.get_world_2d().direct_space_state;
	var query : PhysicsRayQueryParameters2D = PhysicsRayQueryParameters2D.create(
		self.global_position,
		player.get_collision_position()
	);
	
	query.exclude = [self.get_rid()];
	query.collision_mask = 1 | 2;
	
	var result : Dictionary = space_state.intersect_ray(query);
	
	if not result.is_empty():
		return result.collider == player;
	
	return false;

func is_player_in_range() -> bool:
	var player : Player = self._get_player();
	
	if not self._player_is_valid(player):
		return false;
	
	var distance_to_player = self.global_position.distance_to(player.global_position);
	if distance_to_player <= self.detection_range:
		return true;
	else:
		return false;

func can_see_player() -> bool:
	return self.player_is_visible;

func _on_hurt_box_hurt(hitbox: HitBox) -> void:
	if hitbox.owner is not Player:
		return;
	self.queue_free();
