extends Camera2D

var target: Node2D

func get_target():
	var nodes = get_tree().get_nodes_in_group("Player")
	if nodes.size() == 0:
		push_error("esqueceu do player")
		return
	target = nodes[0]
		
		
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_target()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position = target.position
