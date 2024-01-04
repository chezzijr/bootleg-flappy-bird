extends Node

class_name PipeSpawner

signal bird_crashed
signal point_scored

@export var pipe_speed = -150
@onready var spawn_timer = $SpawnTimer

var pipes_scene = preload("res://Scenes/pipes.tscn")
var previous_y = null

func _ready():
	spawn_timer.start()
	
func start_spawning_pipes():
	spawn_timer.timeout.connect(spawn_pipe)

func spawn_pipe():
	var pipes = pipes_scene.instantiate() as Pipes
	add_child(pipes)
	
	var viewport_rect = get_viewport().get_camera_2d().get_viewport_rect()
	var half_height = viewport_rect.size.y / 2
	# spawn at the end of screen
	pipes.position.x = viewport_rect.end.x
	# random height
	pipes.position.y = randf_range(viewport_rect.size.y * 0.15 - half_height, viewport_rect.size.y * 0.65 - half_height)
	# ensure current and previous pipe' y positions are not too far away
	# for example, previous pipe spawned at bottom and current pipe spawned at top
	# this will make it impossible to pass
	if previous_y != null:
		pipes.position.y = clamp(pipes.position.y, previous_y - half_height, previous_y + half_height)
	previous_y = pipes.position.y
	
	pipes.bird_crashed.connect(on_bird_entered)
	pipes.point_scored.connect(on_point_scored)
	pipes.set_speed(pipe_speed)
	
func on_bird_entered():
	bird_crashed.emit()
	stop()
	
func stop():
	spawn_timer.stop()
	for pipe in get_children().filter(func (child): return child is Pipes):
		(pipe as Pipes).speed = 0

func on_point_scored():
	point_scored.emit()
