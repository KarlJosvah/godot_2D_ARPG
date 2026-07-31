extends CharacterBody2D;

@onready var animation_tree: AnimationTree = $AnimationTree;

const SPEED : float = 100.0; 
var input_vector : Vector2 = Vector2.ZERO;

func _physics_process(_delta: float) -> void:
	self.velocity = Vector2.ZERO;
	
	self.input_vector = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down");
	
	if self.input_vector != Vector2.ZERO:
		self.animation_tree.set("parameters/StateMachine/Move_State/Stand_State/blend_position", self.input_vector);
		self.animation_tree.set("parameters/StateMachine/Move_State/Run_State/blend_position", self.input_vector);
	
	self.velocity = input_vector * self.SPEED;
	
	self.move_and_slide();
