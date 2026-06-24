extends StaticBody2D

@onready var colisao: CollisionShape2D = $CollisionShape2D

func _process(_delta: float) -> void:

	var player = get_tree().get_first_node_in_group("Player")

	if player == null:
		return

	var agachado = (
		player.status == player.EstadoProtagonista.agachado
		or
		player.status == player.EstadoProtagonista.andando_agachado
	)

	if GameState.visao_espiritual_ativa and agachado:
		colisao.disabled = true
	else:
		colisao.disabled = false
