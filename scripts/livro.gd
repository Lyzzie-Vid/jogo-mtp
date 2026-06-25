extends Area2D
@onready var label: Label = $LabelInteracao
@onready var animacao: AnimationPlayer = $"../animacao"
@onready var talkbar_do_mapa: Sprite2D = $"../CanvasLayer2/talkbar_do_mapa"


var player_dentro: bool = false
var coletado: bool = false
func _ready() -> void:
	if not body_entered.is_connected(_on_body_entered):
		body_entered.connect(_on_body_entered)
	if not body_exited.is_connected(_on_body_exited):
		body_exited.connect(_on_body_exited)
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and not coletado:
		player_dentro = true
		label.text = "Aperte ENTER para interagir"
		label.visible = true
func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_dentro = false
		label.visible = false
func _unhandled_input(event: InputEvent) -> void:
	if player_dentro and not coletado and event.is_action_pressed("interagir"):
		coletar_livro()
func coletar_livro() -> void:
	coletado = true
	GameState.mapa_desbloqueado = true
	
	label.text = "Você achou um mapa!"
	
	# Aguarda 2 segundos e some
	await get_tree().create_timer(2.0).timeout
	talkbar_do_mapa.visible = true
	await get_tree().create_timer(4.0).timeout
	talkbar_do_mapa.visible = false
	queue_free()
