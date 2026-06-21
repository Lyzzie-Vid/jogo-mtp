extends CharacterBody2D
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D



enum EstadoProtagonista{
	parado,
	andando,
	pulando,
	caindo,
	agachado,
	andando_agachado
	
}

var SPEED = 300.0
const JUMP_VELOCITY = -400.0
var status: EstadoProtagonista

func _ready() -> void:
	fica_parado()


func fica_parado():
	status = EstadoProtagonista.parado
	anim.play("parado")
func fica_andando():
	status = EstadoProtagonista.andando
	anim.play("andando")
func fica_pulando():
	status = EstadoProtagonista.pulando		
	anim.play("pulando")
func fica_caindo():
	status = EstadoProtagonista.caindo	
	anim.play("caindo")
func fica_agachado():
	status = EstadoProtagonista.agachado	
	anim.play("agachado")
	collision_shape.shape.radius = 9
	collision_shape.shape.height = 29
func fica_andando_agachado():
	status = EstadoProtagonista.andando_agachado	
	anim.play("andando_agachado")	
	collision_shape.shape.radius = 9
	collision_shape.shape.height = 29
	SPEED = 100.00
func fica_em_pe():
	collision_shape.shape.radius = 9
	collision_shape.shape.height = 47
	SPEED = 300.00

func estado_parado():
	move()
	if velocity.x  != 0:
		fica_andando()
		return
	if Input.is_action_just_pressed("pulo"):	
		fica_pulando()
		return
	if velocity.y > 0 and not is_on_floor():	
		fica_caindo()
		return
	if Input.is_action_pressed("agachar"):
		fica_agachado()		
func estado_andando():
	move()	
	if velocity.x == 0:
		fica_parado()
		return
	if Input.is_action_just_pressed("pulo"):	
		fica_pulando()
		return
	if velocity.y > 0 and not is_on_floor():	
		fica_caindo()
		return	
func estado_pulando():
	move()
	if velocity.y == 0:
		fica_parado()
	if velocity.y > 0 and not is_on_floor():	
		fica_caindo()
		return	
func estado_caindo():
	move()
	if velocity.y == 0:
		fica_parado()
		return
func estado_agachado():
	move()
	if Input.is_action_just_released("agachar"):
		fica_em_pe()
		fica_parado()
		return
	if velocity.x != 0:
		fica_andando_agachado()
		return
func estado_andando_agachado():
	SPEED = 100.00
	move()
	if Input.is_action_just_released("agachar"):
		if velocity.x == 0:
			fica_em_pe()
			fica_parado()
			return
		if velocity.x != 0:
			fica_em_pe()
			fica_andando()
			return
	if velocity.x == 0:
			fica_agachado()
			return	
func move():
	var direction := Input.get_axis("esquerda", "direita")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if direction > 0: 
		anim.flip_h = false
		
	elif direction < 0:
		anim.flip_h = true	
	

func _physics_process(delta: float) -> void:
	
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	match status:
		EstadoProtagonista.parado:
			estado_parado()
		EstadoProtagonista.andando:
			estado_andando()
		EstadoProtagonista.pulando:
			estado_pulando()
		EstadoProtagonista.caindo:
			estado_caindo()
		EstadoProtagonista.agachado:
			estado_agachado()	
		EstadoProtagonista.andando_agachado:
			estado_andando_agachado()		

	move_and_slide()








	# Handle jump.
	if Input.is_action_just_pressed("pulo") and is_on_floor():
		velocity.y = JUMP_VELOCITY
