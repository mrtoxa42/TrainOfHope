extends KinematicBody2D

var speed = 50
var velocity = Vector2(1,0)
var playerarea = false
var move = false
var hp = 100


func _ready():
	GameManager.train = self


func _process(delta):
	if move == true:
		move_and_slide(velocity * speed)


func _on_Detected_area_entered(area):
	if area.is_in_group("Player"):
		playerarea = true
		
		if move == false:
			$StartStop.start()

func _on_Detected_area_exited(area):
	if area.is_in_group("Player"):
		playerarea = false
		$Sprite2/AnimationPlayer.play("Area")
		if move == true:
			$StartStop.start()

func _on_StartStop_timeout():
	if playerarea == true:
		move = true
		$AnimationPlayer.play("Move")
	else:
		move = false
		$AnimationPlayer.stop()
func take_damage():
	hp -= 1
	if hp >= 1:
		pass
	else:
		queue_free()
func camera_on():
	$Camera2D.current = true
