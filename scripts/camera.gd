extends Camera2D

var target: Node2D
@onready var efeito : Sprite2D = $efeito

func get_target():
	var nodes = get_tree().get_nodes_in_group("Player")
	if nodes.size() == 0:
		push_error("esqueceu do player carai, vai jogar com o q")
		return
	target = nodes[0]
		
		
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_target()

# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	position = target.position
	
	if GameState.visao_espiritual_ativa:
		efeito.visible = false
		
	else:
		efeito.visible = false
		
