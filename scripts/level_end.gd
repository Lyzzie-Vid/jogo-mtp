extends Area2D

@onready var porta = $AnimatedSprite2D

@export var next_level = ""

var player_na_porta = false
var abrindo = false

func _process(_delta):
	
	if player_na_porta and Input.is_action_just_pressed("ação") and !abrindo:

		abrindo = true

		porta.play("porta abrindo")

		await get_tree().create_timer(1.0).timeout

		get_tree().change_scene_to_file("res://cenas/" + next_level + ".tscn")

func _on_body_entered(body):
	player_na_porta = true


func _on_body_exited(body):
	player_na_porta = false

	
	
	
