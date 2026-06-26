extends Node2D
@onready var chave: Area2D = $"terreno/escala 2/decoração/chave"
@onready var anim: AnimatedSprite2D = $"terreno/escala 2/decoração/chave/AnimatedSprite2D"
@onready var chave2: AnimatedSprite2D = $"terreno/escala 2/decoração/chave2/AnimatedSprite2D"

@onready var chão_falso: TileMapLayer = $"terreno/chão falso"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameState.visao_espiritual_desbloqueada = true
	GameState.visao_espiritual_ativa = false
	anim.play("chave")
	chave2.play("chave")
	chão_falso.visible = false
	chão_falso.collision_enabled = false

func _process(delta: float) -> void:
	pass



	
