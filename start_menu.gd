extends CanvasLayer
@onready var resume_btn: TextureButton = $ColorRect/resume_btn


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#func _unhandled_input(event: InputEvent) -> void:
	#if event.is
