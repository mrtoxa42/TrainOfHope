extends KinematicBody2D


var velocity = Vector2.ZERO
var speed = 200
var trainarea = false
var playerarea = false
var hp = 3  
func _process(delta):
	if GameManager.player != null and trainarea == false and playerarea == false:
		velocity  = Vector2(GameManager.train.global_position - global_position).normalized()
		if global_position.x < GameManager.train.global_position.x:
			$AnimationPlayer.play("RunR") 
		else:
			$AnimationPlayer.play("RunL")
		
		move_and_slide(velocity * speed)

	elif playerarea == true:
		if GameManager.player != null:
			velocity = Vector2(GameManager.player.global_position - global_position).normalized()


func _on_DetectedArea_area_entered(area):
	if  area.is_in_group("Train"):
		trainarea = true
		Attack()
	if area.name == "PlayerArea":
		if GameManager.currentenemy == null:
			GameManager.currentenemy = self	
		playerarea = true
	

func _on_DetectedArea_area_exited(area):
	if area.is_in_group("Train"):
		trainarea = false
	if area.name == "PlayerArea":
		if GameManager.currentenemy == self:
			GameManager.currentenemy = null
		playerarea = false
func Attack():
	$AnimationPlayer.play("Attack")
	print("a")
	if trainarea == true:
		return
	else:
		$AnimationPlayer.play("RunR")
func take_damage():
	if hp > 0:
		hp -=1
	else:
		if GameManager.currentenemy == self:
			GameManager.currentenemy = null
		queue_free()
