extends CanvasLayer
func _ready() -> void:
	visible = false
func _unhandled_input(event: InputEvent) -> void:
	if GameState.mapa_desbloqueado and event.is_action_pressed("abrir_mapa"):
		visible = not visible
		get_tree().paused = visible  # Opcional: pausa o jogo
