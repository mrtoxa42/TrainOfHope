extends KinematicBody2D

var veloctiy = Vector2(0,0)
var bowpos = Vector2(0,0)
var entry = true
var speed = 5000
var powerbow = 0
func _ready():
#	var tween = create_tween()
#	tween.tween_property(self,"position",Vector2(GameManager.bowcross.global_position),1)
	if GameManager.bowcross != null:
		bowpos = GameManager.bowcross.global_position
		veloctiy = Vector2(bowpos - global_position).normalized()
		look_at(bowpos)


func _process(delta):
	if entry == true:
		veloctiy = Vector2(bowpos - global_position).normalized()
		powerbow = GameManager.player.bowpower
		look_at(bowpos)
		move_and_slide(veloctiy * GameManager.player.bowpower * delta * speed)
	else:
		move_and_slide(veloctiy * powerbow * delta * speed)





func _on_PosTimer_timeout():
	entry = false


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Area2D_area_entered(area):
	if area.is_in_group("Enemy"):
		queue_free()
