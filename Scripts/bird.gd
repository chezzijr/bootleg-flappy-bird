extends CharacterBody2D

class_name Bird

signal game_started

@export var gravity = 981
@export var jump_force = -300
@export var rotation_speed = 2
@export var max_falling_speed = 400
#@export var lower_bound = -INF

@onready var animation_player = $AnimationPlayer
@onready var flap_sound = $FlapSound

var is_started = false
var is_ended = false

func _ready():
	velocity = Vector2.ZERO
	animation_player.play("idle")

func _physics_process(delta):
	if Input.is_action_just_pressed("jump") && !is_ended:
		if !is_started:
			game_started.emit()
			animation_player.play("flapping")
			is_started = true
		# jump
		velocity.y = jump_force
		# face 30deg upward
		rotation = deg_to_rad(-30)
		flap_sound.play()
	
	if !is_started:
		return
	
	velocity.y = min(max_falling_speed, velocity.y + delta * gravity)
	
	move_and_collide(velocity * delta)
	# make sure bird does not go above camera
	global_position.y = clamp(
		global_position.y,
		get_viewport().get_camera_2d().global_position.y - get_viewport_rect().size.y / 2,
		INF)
	
	# Rotate downwards when falling
	if velocity.y > 0 and rad_to_deg(rotation) < 90:
		rotation += rotation_speed * deg_to_rad(1)
		
func kill():
	is_ended = true

func stop():
	animation_player.stop()
	gravity = 0
	velocity = Vector2.ZERO
