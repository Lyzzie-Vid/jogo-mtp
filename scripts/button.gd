extends Button

@export var cena_destino: String = "res://cenas/masmorra.tscn"
@onready var label_nome: Label = $Label   # ajuste o caminho do seu Label

func _ready() -> void:
	label_nome.visible = false
	pressed.connect(_on_pressed)
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

func _on_mouse_entered() -> void:
	label_nome.visible = true

func _on_mouse_exited() -> void:
	label_nome.visible = false

func _on_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file(cena_destino)
