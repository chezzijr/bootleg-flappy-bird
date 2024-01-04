extends Node

class_name Flash

@onready var animation_player = $AnimationPlayer

func play():
	animation_player.play("flash")


func _on_animation_player_animation_finished(anim_name):
	queue_free()
