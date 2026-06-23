extends TileMapLayer

@onready var luz: PointLight2D = $PointLight2D
@onready var tampa_fogo: ColorRect = $ColorRect
@onready var bloqueio: CollisionShape2D = $"../BloqueioLareira/CollisionShape2D"

func _process(_delta: float) -> void:

	if GameState.visao_espiritual_ativa:

		# Fogo apagado
		luz.visible = false
		tampa_fogo.visible = true

		# Pode atravessar
		bloqueio.disabled = true

	else:

		# Fogo aceso
		luz.visible = true
		tampa_fogo.visible = false

		# Não pode atravessar
		bloqueio.disabled = false
