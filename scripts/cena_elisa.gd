extends Node2D

@onready var talkbar: Sprite2D = $CanvasLayer/Talkbar
@onready var animacao: AnimationPlayer = $animacao

@onready var mensagem: Label = $MensagemVisao  

func _ready() -> void:
	animacao.play("fade_in")
	
	await get_tree().create_timer(3.5).timeout
	animacao.play_backwards("fade_in")
	if not GameState.visao_espiritual_desbloqueada:

		GameState.visao_espiritual_desbloqueada = true

		#mensagem.visible = true
		#mensagem.text = "Você adquiriu Visão Espiritual\n Aperte E para usar"
		
		#talkbar.visible = true
		
		#await get_tree().create_timer(5.0).timeout
		#animacao.play_backwards("fade_in")
		#talkbar.visible = false
		#mensagem.visible = false
