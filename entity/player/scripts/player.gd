extends CharacterBody2D;

@onready var animation_tree: AnimationTree = $AnimationTree;
@onready var playback : AnimationNodeStateMachinePlayback = animation_tree.get("parameters/StateMachine/playback") as AnimationNodeStateMachinePlayback;

const SPEED : float = 100.0;
const ROLL_SPEED : float = 125.0;

var input_vector : Vector2 = Vector2.ZERO;
var last_input_vector : Vector2 = Vector2.ZERO;

func _physics_process(_delta: float) -> void:
	var state = self.playback.get_current_node();
	match state:
		"Move_State": self._move_state();
		"Attack_State": self._attack_state();
		"Roll_State": self._roll_state();
	

func _move_state() -> void:
	self.velocity = Vector2.ZERO;
	
	self.input_vector = Input.get_vector("move_left", "move_right", "move_up", "move_down");
	
	if self.input_vector != Vector2.ZERO:
		self.last_input_vector = self.input_vector;
		self._update_blend_position(self.input_vector);
	
	if Input.is_action_just_pressed("attack"):
		self.playback.travel("Attack_State");
	if Input.is_action_just_pressed("roll"):
		self.playback.travel("Roll_State");
	
	self.velocity = self.input_vector * self.SPEED;
	self.move_and_slide();

func _attack_state() -> void:
	pass;

func _roll_state() -> void:
	self.velocity = self.last_input_vector * self.ROLL_SPEED;
	self.move_and_slide();

func _update_blend_position(direction : Vector2) -> void:
	self.animation_tree.set("parameters/StateMachine/Move_State/Stand_State/blend_position", direction);
	self.animation_tree.set("parameters/StateMachine/Move_State/Run_State/blend_position", direction);
	self.animation_tree.set("parameters/StateMachine/Attack_State/blend_position", direction);
	self.animation_tree.set("parameters/StateMachine/Roll_State/blend_position", direction);
