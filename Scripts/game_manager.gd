extends Node

@onready var bird = $"../Bird" as Bird
@onready var pipe_spawner = $"../PipeSpawner" as PipeSpawner
@onready var ground = $"../Ground" as Ground
@onready var flash = $"../Flash" as Flash
@onready var ui = $"../UI" as UI
@onready var point_scored_sound = $"../PointScoredSound"
@onready var hit_obstacle_sound = $"../HitObstacleSound"

var score = 0

func _ready():
	bird.visible = false
	
	bird.game_started.connect(on_game_started)
	pipe_spawner.bird_crashed.connect(on_game_ended)
	ground.bird_crashed.connect(on_game_ended)
	pipe_spawner.point_scored.connect(on_game_scored)

func on_game_started():
	bird.visible = true
	ui.start()
	ui.set_score(0)
	pipe_spawner.start_spawning_pipes()

func on_game_ended():
	if flash != null:
		flash.play()
		hit_obstacle_sound.play()
	bird.kill()
	ground.stop()
	pipe_spawner.stop()
	# show gameover
	ui.end()

func on_game_scored():
	point_scored_sound.play()
	score += 1
	ui.set_score(score)
