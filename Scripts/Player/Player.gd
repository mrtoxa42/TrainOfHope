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
	velocity = get_node("MobilControl/JoystickManuel").get_velo()

	
	
	$GUI/CurrentCointLabel.text = "COIN: " + str(GameManager.gamedata.coin)
	if attacked == false:
		move_and_slide(velocity * speed)
	GameManager.trainboundary = $TrainBoundary.global_position
	if attacked == false:
		if velocity == Vector2.ZERO:
			$AnimationPlayer.play("Idle")
		elif velocity.x >= -0.5:
			$AnimationPlayer.play("RunR")
		elif velocity.x <= 0.5:
			$AnimationPlayer.play("RunL")
		else:
			$AnimationPlayer.play("RunR")

		
		if item == "bow":
			pass
		if bowclick == true:
			$Skeleton2D/Hip/Chest/Forearml/HandR.position +=get_node("MobilControl/JoystickManuel").get_velo()
			
			

		

func _input(event):
	if bowclick == true and event is InputEventScreenTouch:
		pass
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
	if Input.is_action_just_pressed("ui_select"):
		Attack()
		bowclick = true
	if Input.is_action_just_released("ui_select"):
		bowclick = false
	if item == "bow" and bowclick == true:
		$Skeleton2D/Hip/Chest/Forearml/HandR.look_at(velocity) 
#	if Input.is_action_just_pressed("LeftClik"):
#		if item == "sword":
#			Attack()
		
func Attack():
	if item == "sword":
		attacked = true
		$AnimationPlayer.play("AttackSword")
	elif item == "bow":
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
	if anim_name == "AttackBow":
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





func _on_AttackButton_pressed():
	if item == "sword":
		Attack()
	elif item == "bow":
		bowclick = true
		


func _on_AttackButton_released():
	if item == "sword":
		pass
	elif item == "bow":
		Attack()
		bowclick = false
