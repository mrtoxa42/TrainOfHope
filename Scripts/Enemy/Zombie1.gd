extends KinematicBody2D


var velocity = Vector2.ZERO
var speed = 200
var trainarea = false
var playerarea = false
var hp = 3  
func _process(delta):
	if GameManager.player != null and trainarea == false:
		velocity  = Vector2(GameManager.train.global_position - global_position).normalized()
		
		move_and_slide(velocity * speed)



func _on_DetectedArea_area_entered(area):
	if  area.is_in_group("Train"):
		trainarea = true
	if area.name == "PlayerArea":
		if GameManager.currentenemy == null:
			GameManager.currentenemy = self	
	

func _on_DetectedArea_area_exited(area):
	if area.is_in_group("Train"):
		trainarea = false
		Attack()
	if area.name == "PlayerArea":
		if GameManager.currentenemy == self:
			GameManager.currentenemy = null
		
func Attack():
	$AnimationPlayer.play("Attack")
func take_damage():
	print("take damage çalıştı zombi")
	if hp > 0:
		hp -=1
	else:
		if GameManager.currentenemy == self:
			GameManager.currentenemy = null
		queue_free()
