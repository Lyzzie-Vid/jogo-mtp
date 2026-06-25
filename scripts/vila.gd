extends Node2D
@onready var inicio: AnimationPlayer = $inicio

@onready var heroi: CharacterBody2D = $Protagonista
@onready var pensamento: RichTextLabel = $CanvasLayer/Pensamento
@onready var lanterna_solta : Sprite2D = $lanterna

func _ready() -> void:
	pensamento.hide()
	inicio.play("inicio")
	await inicio.animation_finished
	await rodar_cutscene()

func rodar_cutscene() -> void:
	# 1) Parado
	heroi.tocar("parado")
	await espera(0.8)

	# 2) Pegar a lanterna
	heroi.tocar("pegar_lanterna")
	await heroi.esperar_fim_animacao()
	lanterna_solta.hide()
	

	# 3) Andar pra frente
	heroi.tocar("andando_devagar")
	var destino_x := heroi.position.x + 30.0
	var t := create_tween()
	t.tween_property(heroi, "position:x", destino_x, 1.0)
	await t.finished

	# 4) Comer a maçã
	heroi.tocar("comer_maca")
	await heroi.esperar_fim_animacao()
	
	# Pensamento surgindo aos poucos
	mostrar_pensamento(
		"Terminei meu trabalho por hoje, já está na hora de ir pra casa "
		+ "e ver se meu irmão retornou. Faz dias que não o vejo."
	)
	# 5) Andar pra frente
	heroi.tocar("andando_devagar")
	var destino_x2 := heroi.position.x + 180.0
	var t2 := create_tween()
	t2.tween_property(heroi, "position:x", destino_x2, 6.0)
	await t2.finished

	# 6) Volta ao parado e LIBERA o jogador
	heroi.tocar("parado")
	heroi.liberar_controle()

func espera(s: float) -> void:
	await get_tree().create_timer(s).timeout

func mostrar_pensamento(texto: String) -> void:
	pensamento.text = texto
	pensamento.visible_ratio = 0.0
	pensamento.show()
	create_tween().tween_property(pensamento, "visible_ratio", 1.0, 2.5)
