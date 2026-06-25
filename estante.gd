extends StaticBody2D

@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var sprite: Sprite2D = $Sprite2D
@onready var chão_falso: TileMapLayer = $"../../../chão falso"

func _ready() -> void:
	GameState.visao_espiritual_mudou.connect(_on_visao_mudou)
	_aplicar_estado(GameState.visao_espiritual_ativa)  # estado inicial

func _on_visao_mudou(ativa: bool) -> void:
	_aplicar_estado(ativa)
	chão_falso.collision_enabled = !chão_falso.collision_enabled 
func _aplicar_estado(ativa: bool) -> void:
	visible = ativa
	collision_shape.set_deferred("disabled", not ativa)
	
