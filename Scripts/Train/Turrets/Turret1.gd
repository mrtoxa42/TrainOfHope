extends Area2D

var currentenemy 
var bullet1 = preload("res://Scenes/Train/Turrets/TurretBullet1.tscn")

var Shoot = false
func _process(delta):
	if currentenemy != null:
		$Head.look_at(currentenemy.global_position)
		$CroosHair.global_position = currentenemy.global_position
		if Shoot == true:
			shoot()
			
		


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Detected":
		if currentenemy == null:
			$AnimationPlayer.play("Detected")
		

func _on_Turret1_area_entered(area):
	if area.is_in_group("Enemy"):
		if currentenemy == null:
				currentenemy = area
			

		
		
		


func _on_Turret1_area_exited(area):
	if area.is_in_group("Enemy"):
		if area == currentenemy:
			currentenemy = null
			$AnimationPlayer.play("Detected")
func shoot():
	Shoot = false
	var Bullet1 = bullet1.instance()
	Bullet1.croos = $CroosHair
	get_tree().get_root().add_child(Bullet1)
	Bullet1.global_position = $Head/ShootPosition.global_position


	
	

func _on_ShootTimer_timeout():
	if currentenemy !=null:
		shoot()
	else:
		Shoot = true
		$AnimationPlayer.play("Detected")
