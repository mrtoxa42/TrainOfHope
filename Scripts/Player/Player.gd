extends KinematicBody2D


var velocity = Vector2.ZERO
var speed = 200
var attacked = false
var hp = 10
var damaged = false
var item = "bow"
var bowpower = 0
var bowclick = false
var arrow = preload("res://Scenes/Player/Items/Arrow.tscn")

func _ready():
	change_item()
	GameManager.player = self
	GameManager.trainboundary = $TrainBoundary.global_position
func _process(delta):
	velocity = get_node("GUI/Joystick").get_velo()

	
	
	$GUI/CurrentCointLabel.text = "COIN: " + str(GameManager.gamedata.coin)
	print(GameManager.gamedata.coin)
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

		
		if item == "bow":
			pass
		if bowclick == true:
			$Skeleton2D/Hip/Chest/Forearml/HandR.look_at(get_global_mouse_position())
			$Skeleton2D/Hip/Chest/Forearmr/HandL.look_at(get_global_mouse_position())

		

func _input(event):
	if bowclick == true and event is InputEventScreenTouch:
		$Skeleton2D/Hip/Chest/Forearml/HandR.look_at(event.position)
		$Skeleton2D/Hip/Chest/Forearmr/HandL.look_at(get_global_mouse_position())
#	if Input.is_action_pressed("ui_right"):
#		velocity.x = 1
#	elif Input.is_action_pressed("ui_left"):
#		velocity.x = -1
#	else:
#		velocity.x = 0
#	if Input.is_action_pressed("ui_up"):
#		velocity.y = -1
#	elif Input.is_action_pressed("ui_down"):
#		velocity.y = 1
#	else:
#		velocity.y = 0
#
#	if Input.is_action_pressed("D"):
#		velocity.x = 1
#	elif Input.is_action_pressed("A"):
#		velocity.x = -1
#	else:
#		velocity.x = 0
#	if Input.is_action_pressed("W"):
#		velocity.y = -1
#	elif Input.is_action_pressed("S"):
#		velocity.y = 1
#	else:
#		velocity.y = 0
#
	if Input.is_action_just_pressed("Q"):
		change_item()
#
	if Input.is_action_pressed("ui_select"):
		Attack()
#
#	if Input.is_action_just_pressed("LeftClik"):
#		if item == "sword":
#			Attack()
		
func Attack():
	if item == "sword":
		attacked = true
		$AnimationPlayer.play("AttackSword")
	elif item == "bow":
		$AnimationPlayer.play("AttackBow")
		var Arrow = arrow.instance()
		get_tree().get_root().add_child(Arrow)
		Arrow.global_position = $Skeleton2D/Hip/Chest/Forearml/HandR/Bow.global_position

func change_item():
	if item == "sword":
		$Skeleton2D/Hip/Chest/Forearml/HandR/Sword.hide()
		$Skeleton2D/Hip/Chest/Forearml/HandR/Bow.show()
		item = "bow"
	elif item == "bow":
		$Skeleton2D/Hip/Chest/Forearml/HandR/Sword.show()
		$Skeleton2D/Hip/Chest/Forearml/HandR/Bow.hide()
		item = "sword"

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
	if anim_name == "AttackSword":
		attacked = false



func _on_AnimationPlayer2_animation_finished(anim_name):
	if anim_name == "TakeDamage":
		damaged = false


func plus_coin():
	$GUI/AnimationPlayer.play("PlusCoin")

func break_wave():
	$StatGUI.hide()
	$GUI.hide()
func wave_start():
	$StatGUI.show()
	$GUI.show()



#
#
#func _on_BowScreenTouch_released():
#	if bowclick == true:
#		bowclick = false
#		$Skeleton2D/Hip/Chest/Forearml/HandR/Bow/Arrow.hide()
#		Attack()
#func _on_BowScreenTouch_pressed():
#	if bowclick == false and item == "bow":
#		bowpower = 10
#		bowclick = true
#		$Skeleton2D/Hip/Chest/Forearml/HandR/Bow/Arrow.show()
#		$Bow/BowTimer.start() 
#		$AnimationPlayer.play("AttackBow")
#
#func _on_BowTimer_timeout():
#	if bowclick == true:
#		if bowpower < 100:
#			bowpower += 5
#		if GameManager.bowcross != null:
#			GameManager.bowcross.show_bar()
#		$Bow/BowTimer.start()
#	else:
#		if GameManager.bowcross != null:
#			GameManager.bowcross.hide_bar()
