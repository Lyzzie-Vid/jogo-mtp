extends Control
@onready var protagonista: AnimatedSprite2D = $TextureRect/protagonista

@onready var inicio: AnimationPlayer = $TextureRect/inicio
@onready var fogo: AnimatedSprite2D = $TextureRect/fogo






# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	inicio.play_backwards("fade_out")
	protagonista.play("parado_olhando")
	fogo.play("fogo")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_começar_pressed() -> void:
	inicio.play("fade_out")
	await inicio.animation_finished
	get_tree().change_scene_to_file("res://cenas/vila.tscn")
	
	
func _on_sair_pressed() -> void:
	get_tree().quit()
