extends Node2D
@onready var inicio: AnimationPlayer = $inicio

@onready var heroi: CharacterBody2D = $Protagonista
@onready var pensamento: RichTextLabel = $CanvasLayer/Pensamento
@onready var lanterna_solta : Sprite2D = $lanterna
@onready var som_maca: AudioStreamPlayer2D = $som_maca
@onready var som_tema_vila: AudioStreamPlayer2D = $som_tema_vila

func _ready() -> void:
	som_tema_vila.play()
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
	await espera(1.15)
	som_maca.play()
	await heroi.esperar_fim_animacao()
	
	# Pensamento surgindo aos poucos
	mostrar_pensamento(
		"Terminei meu trabalho por hoje, já está na hora de ir pra casa "
		+ "e ver se meu irmão retornou. Faz dias que não o vejo."
	)
	# 5) Andar pra frente
	heroi.tocar("andando_devagar")
	var destino_x2 := heroi.position.x + 270.0
	var t2 := create_tween()
	t2.tween_property(heroi, "position:x", destino_x2, 9.0)
	await t2.finished
	
	# 6) emenda na cutscene do lobo
	await continuar_cutscene_lobo()

# --- Referências da cena ---
@onready var monstro_flash: AnimatedSprite2D = $MonstroFlash
@onready var lobo: AnimatedSprite2D = $Lobo

# --- Config do lobo ---
@export var velocidade_lobo: float = 280.0
var _lobo_perseguindo: bool = false

# --- Controle interno das mensagens ---
var _tween_pensamento: Tween = null
var _timer_pensamento: SceneTreeTimer = null


# ============================================================
#                     CUTSCENE DO LOBO 
# ============================================================
func continuar_cutscene_lobo() -> void:
	# 1) vulto pisca à frente do personagem
	await _flash_monstro()

	# 2) para de andar + susto (fica na tela até a próxima fala)
	heroi.tocar("parado")
	mostrar_pensamento("O que foi aquilo??")
	await get_tree().create_timer(3.0).timeout

	# 3) volta a andar por 1s
	heroi.tocar("andando_devagar")
	var destino_x3 := heroi.position.x + 50.0
	var t3 := create_tween()
	t3.tween_property(heroi, "position:x", destino_x3, 1.0)
	await t3.finished
	

	# 4) visão espiritual liga sozinha (forçada, ignora 'desbloqueada')
	heroi.tocar("parado")
	GameState.visao_espiritual_ativa = true
	await get_tree().create_timer(1).timeout
	mostrar_pensamento("Aperte W, A, S, D para correr",2.5)
	await get_tree().create_timer(2.0).timeout

	# 5) lobo aparece atrás, sentado
	lobo.visible = true
	#barulho de rosnado do lobo
	await get_tree().create_timer(1).timeout
	
	
	# 6) lobo se levanta
	#musica muda
	lobo.play("levantando")
	await lobo.animation_finished
	heroi.liberar_controle()


	# 7) lobo corre atrás + devolve o controle ao jogador
	_lobo_perseguindo = true
	
	await get_tree().create_timer(3.0).timeout
	mostrar_pensamento("Preciso chegar em casa!",2.5)

# Vulto que pisca rapidamente à frente
func _flash_monstro() -> void:
	for i in 2:
		monstro_flash.visible = true
		await get_tree().create_timer(0.08).timeout
		monstro_flash.visible = false
		await get_tree().create_timer(0.09).timeout


# ============================================================
# PERSEGUIÇÃO DO LOBO (roda todo frame depois de ativado)
# ============================================================
func _process(_delta: float) -> void:
	if not _lobo_perseguindo:
		return

	var heroi_andando : bool = heroi.sprite.animation == "andando"

	if heroi_andando:
		# herói se movendo → lobo corre atrás
		if lobo.animation != "correndo":
			lobo.play("correndo")
		var dir := (heroi.global_position - lobo.global_position).normalized()
		lobo.global_position += dir * velocidade_lobo * _delta
		lobo.flip_h = dir.x < 0
	else:
		# herói parado → lobo ataca (a animação avança um pouco)
		if lobo.animation != "parado":
			lobo.play("parado")


# ============================================================
# MENSAGENS (efeito máquina de escrever + sumiço opcional)
# ============================================================
func mostrar_pensamento(texto: String, duracao: float = 0.0) -> void:
	# cancela digitação e auto-esconder da mensagem anterior
	if _tween_pensamento:
		_tween_pensamento.kill()
	_timer_pensamento = null

	pensamento.text = texto
	pensamento.visible_ratio = 0.0
	pensamento.show()

	_tween_pensamento = create_tween()
	_tween_pensamento.tween_property(pensamento, "visible_ratio", 1.5, 2.0)

	# duração > 0 → esconde sozinho depois desse tempo
	if duracao > 0.0:
		var t := get_tree().create_timer(duracao)
		_timer_pensamento = t
		await t.timeout
		if _timer_pensamento == t:   # só some se ninguém trocou a mensagem
			esconder_pensamento()

func esconder_pensamento() -> void:
	if _tween_pensamento:
		_tween_pensamento.kill()
	_timer_pensamento = null
	pensamento.hide()

func espera(s: float) -> void:
	await get_tree().create_timer(s).timeout
