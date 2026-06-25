extends CanvasLayer
@onready var protagonista: CharacterBody2D = $"../protagonista"

@onready var talkbar: Sprite2D = $Talkbar
@onready var talkbar_do_mapa: Sprite2D = $"../CanvasLayer2/talkbar_do_mapa"

@onready var mensagem: Label = $"../MensagemVisao"

const 	DISTANCIA = 20.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	talkbar.position.x = protagonista.position.x -145
	mensagem.position = talkbar.position
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
