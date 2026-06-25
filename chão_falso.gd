extends TileMapLayer
@onready var escada: TileMapLayer = $"../escada"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	GameState.visao_espiritual_mudou.connect(_on_visao_mudou)
	_aplicar_estado(GameState.visao_espiritual_ativa)  # estado inicial
		
func _on_visao_mudou(ativa: bool) -> void:
	_aplicar_estado(ativa)
	escada.collision_enabled = !escada.collision_enabled
func _aplicar_estado(ativa: bool) -> void:
	visible = ativa
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
