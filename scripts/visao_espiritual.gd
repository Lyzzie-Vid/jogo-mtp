extends CanvasModulate

@export var cor_normal: Color
@export var cor_visao: Color = Color(0.4, 0.6, 1.0, 1.0)

func _ready() -> void:
	color = cor_normal

func _process(_delta: float) -> void:

	if GameState.visao_espiritual_ativa:
		color = cor_visao
	else:
		color = cor_normal
