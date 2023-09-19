extends KinematicBody2D


var velocity = Vector2.ZERO
var speed = 200

func _ready():
	GameManager.player = self
	GameManager.trainboundary = $TrainBoundary.global_position
func _process(delta):
#	velocity = get_node("GUI/Joystick").get_velo()
	move_and_slide(velocity * speed)
	GameManager.trainboundary = $TrainBoundary.global_position
	
	
func _input(event):
	if Input.is_action_pressed("ui_right"):
		velocity.x = 1
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -1
	else:
		velocity.x = 0
	if Input.is_action_pressed("ui_up"):
		velocity.y = -1
	elif Input.is_action_pressed("ui_down"):
		velocity.y = 1
	else:
		velocity.y = 0
		
		
	if Input.is_action_pressed("ui_select"):
		Attack()
		
func Attack():
#	$AnimationPlayer.play("Attack")

	if GameManager.currentenemy != null:
		print("Player attack")
		GameManager.currentenemy.take_damage()
