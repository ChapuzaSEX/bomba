extends CharacterBody2D


const SPEED = 150.0
const Correr = 2.0
const JUMP_VELOCITY = -250.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var sprite = $AnimatedSprite2D # Cambia "AnimatedSprite2D" al nombre correcto de tu nodo
func animaciones(velocidad):
	if velocidad == 150:
		sprite.play("Caminar")
	elif velocidad == 300:
		sprite.play("Run")

func _physics_process(delta):
		
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	#begieb
	#casa
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	if Input.is_action_pressed("ui_select"):
		sprite.play("disparo")
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		var velociad_corerr = SPEED
		if Input.is_action_pressed("ui_up"):  # Revisa si la acción de correr (Shift) está activ
			velociad_corerr = velociad_corerr * Correr
		velocity.x = direction * velociad_corerr
		animaciones(velociad_corerr)
		
		if direction < 0:
			sprite.flip_h = true  # Voltear horizontalmente cuando se mueve a la izquierda
		else:
			sprite.flip_h = false  # No voltear cuando se mueve a la derecha
	
	else:
		sprite.play("Idle")
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
		

	move_and_slide()
