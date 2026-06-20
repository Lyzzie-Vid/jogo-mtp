extends Area2D

@onready var label = $Label
@onready var sprite = $Sprite2D
@onready var collision = $CollisionShape2D
@onready var mapa_ui = $CanvasLayer/TextureRect

var player_perto = false
var foi_coletado = false

func _ready():
	label.visible = false
	mapa_ui.visible = false

func _process(delta):

	if player_perto and !foi_coletado and Input.is_action_just_pressed("interact"):
		coletar()

	if foi_coletado and Input.is_action_just_pressed("abrir_mapa"):
		mapa_ui.visible = !mapa_ui.visible

func coletar():
	foi_coletado = true

	label.visible = true
	label.text = "Você achou um mapa!\nPressione M para ver."

	sprite.visible = false
	collision.disabled = true

func _on_body_entered(body):
	if body.is_in_group("player") and !foi_coletado:
		player_perto = true
		label.visible = true
		label.text = "Pressione E para pegar"

func _on_body_exited(body):
	if body.is_in_group("player") and !foi_coletado:
		player_perto = false
		label.visible = false
