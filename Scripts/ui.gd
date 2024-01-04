extends CanvasLayer

class_name UI

@onready var score = $MarginContainer/Score
@onready var game_start = $MarginContainer/GameStart
@onready var game_over = $MarginContainer/GameOver
#@onready var game_over_score = $MarginContainer/GameOver/Score


func _ready():
	score.visible = false
	game_start.visible = true
	game_over.visible = false

func start():
	score.visible = true
	game_start.visible = false
	game_over.visible = false
	
func end():
	score.visible = true
	game_start.visible = false
	#game_over_score.text = "Score %d" % num
	game_over.visible = true

func set_score(num: int):
	score.set_score(num)

func _on_button_pressed():
	get_tree().reload_current_scene()
