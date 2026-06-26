extends TileMapLayer
@onready var escada: TileMapLayer = $"../escada"
@onready var chão_falso: TileMapLayer = $"."
@onready var decoração: TileMapLayer = $"../escala 2/decoração"




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	escada.collision_enabled = true
	
	
	GameState.visao_espiritual_mudou.connect(_on_visao_mudou)
	_aplicar_estado(GameState.visao_espiritual_ativa)  # estado inicial
func _on_visao_mudou(ativa: bool) -> void:
	_aplicar_estado(ativa)
	escada.collision_enabled = !ativa
	escada.visible = !ativa
	
func _aplicar_estado(ativa: bool) -> void:
	chão_falso.visible = ativa
	chão_falso.collision_enabled = ativa
	decoração.visible = ativa

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
