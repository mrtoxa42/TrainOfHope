extends KinematicBody2D

var croos
var velocity = Vector2.ZERO
var croospos = Vector2.ZERO
var speed = 2000
func _ready():
	croospos = croos.global_position
func _process(delta):
	look_at(croospos)
	velocity = Vector2(croospos - global_position).normalized()
	move_and_slide(velocity * speed)
func _on_TurretBullet1_area_entered(area):
	if area.is_in_group("Enemy"):
		queue_free()


func _on_DetectedTimer_timeout():
	pass 


func _on_DeathTimer_timeout():
	queue_free()
