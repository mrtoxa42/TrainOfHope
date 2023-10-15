extends KinematicBody2D


var velocity = Vector2.ZERO
var speed = 200
var attacked = false
var hp = 10
var damaged = false
func _ready():
	GameManager.player = self
	GameManager.trainboundary = $TrainBoundary.global_position
func _process(delta):
#	velocity = get_node("GUI/Joystick").get_velo()
	if attacked == false:
		move_and_slide(velocity * speed)
	GameManager.trainboundary = $TrainBoundary.global_position
	if attacked == false:
		if velocity == Vector2.ZERO:
			$AnimationPlayer.play("Idle")
		elif velocity.x ==1:
			$AnimationPlayer.play("RunR")
		elif velocity.x == -1:
			$AnimationPlayer.play("RunL")
		else:
			$AnimationPlayer.play("RunR")
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
	
	if Input.is_action_pressed("D"):
		velocity.x = 1
	elif Input.is_action_pressed("A"):
		velocity.x = -1
	else:
		velocity.x = 0
	if Input.is_action_pressed("W"):
		velocity.y = -1
	elif Input.is_action_pressed("S"):
		velocity.y = 1
	else:
		velocity.y = 0
		
		
	if Input.is_action_pressed("ui_select"):
		Attack()
		
func Attack():
		attacked = true
		$AnimationPlayer.play("Attack")

#	if GameManager.currentenemy != null:
#		GameManager.currentenemy.take_damage()

func take_damage():
	$AnimationPlayer2.play("TakeDamage")
	damaged = true
	hp -= 1
	if hp >= 1:
		pass
	else:
		Death()

func Death():
	GameManager.train.camera_on()
	queue_free()


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Attack":
		attacked = false



func _on_AnimationPlayer2_animation_finished(anim_name):
	if anim_name == "TakeDamage":
		damaged = false
