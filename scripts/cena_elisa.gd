extends Node2D

@onready var mensagem: Label = $MensagemVisao  

func _ready() -> void:

	if not GameState.visao_espiritual_desbloqueada:

		GameState.visao_espiritual_desbloqueada = true

		mensagem.visible = true
		mensagem.text = "Você adquiriu Visão Espiritual\n Aperte E para usar"

		await get_tree().create_timer(5.0).timeout

		mensagem.visible = false
