extends KinematicBody2D

var speed = 50
var velocity = Vector2(1,0)
var playerarea = false
var move = false


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
		if move == true:
			$StartStop.start()
		

func _on_StartStop_timeout():
	if playerarea == true:
		move = true
	else:
		move = false
