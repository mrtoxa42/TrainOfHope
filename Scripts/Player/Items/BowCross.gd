extends KinematicBody2D

var velocity = Vector2.ZERO
var speed = 200

func _ready():
	GameManager.bowcross = self 
	



func _process(delta):
#	velocity = GameManager.joystick.get_velo()
#	if Input.is_action_pressed("D"):
#		position = $Right.position
#	elif Input.is_action_pressed("A"):
#		position = $Left.position
#	else:
#		velocity.x = 0
#	if Input.is_action_pressed("W"):
#		velocity.y = -1
#	elif Input.is_action_pressed("S"):
#		velocity.y = 1
#	else:
#		velocity.y = 0
		
#	move_and_slide(velocity * speed)


#func _process(delta):
#	$PowerBar.value = GameManager.player.bowpower
#	global_position = get_global_mouse_position()
#
#	if GameManager.player.bowpower < 40:
##		$PowerBar.get_stylebox("StyleBoxFlat/fg").set_bg_color(Color.red)
#		$PowerBar.get("custom_styles/fg").set_bg_color(Color.yellow)
#	elif GameManager.player.bowpower < 75:
#		$PowerBar.get("custom_styles/fg").set_bg_color(Color.green)
#	elif GameManager.player.bowpower < 101:
#		$PowerBar.get("custom_styles/fg").set_bg_color(Color.red)
#

func pos_def():
	
	global_position = GameManager.player.global_position
func hide_bar():
	$PowerBar.hide()
func show_bar():
	$PowerBar.show()
