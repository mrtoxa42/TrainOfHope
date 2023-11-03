extends KinematicBody2D


var velocity = Vector2.ZERO
var speed = 50
var trainarea = false
var playerarea = false
#var detectedtrain = false
var hp = 3
var death = false
var damaged = false

var coin = preload("res://Scenes/Extras/Coin.tscn")
func _process(delta):

	if GameManager.wavebreak == true:
		queue_free()


	if GameManager.train != null and GameManager.train != null and trainarea == false and playerarea == false and  death == false and damaged == false:
		velocity  = Vector2(GameManager.train.global_position - global_position).normalized()
		if global_position.x < GameManager.train.global_position.x:
			$AnimationPlayer.play("RunR") 
		else:
			$AnimationPlayer.play("RunL")
		
		move_and_slide(velocity * speed)
	
	elif playerarea == true:
		if GameManager.player != null:
			velocity = Vector2(GameManager.player.global_position - global_position).normalized()
	$HpBar.value = hp

func _on_DetectedArea_area_entered(area):
	if  area.is_in_group("Train"):
		yield(get_tree().create_timer(1),"timeout")
		trainarea = true
		Attack()
	if area.name == "PlayerArea":
		if GameManager.currentenemy == null:
			GameManager.currentenemy = self

		playerarea = true
		Attack()
	
	if area.is_in_group("Bullet"):
		take_damage()
		
	if area.is_in_group("Sword"):
		if GameManager.player.attacked == true:
			take_damage()
	if area.is_in_group("Arrow"):
		take_damage()
func _on_DetectedArea_area_exited(area):
	if area.is_in_group("Train"):
		trainarea = false
	if area.name == "PlayerArea":
		if GameManager.currentenemy == self:
			GameManager.currentenemy = null
		
		playerarea = false
func Attack():
	if trainarea == true and death == false:
		if global_position.x <= GameManager.train.global_position.x:
			$AnimationPlayer.play("AttackR")
		else:
			$AnimationPlayer.play("AttackL")
		if trainarea == true or playerarea == true:
			return
	elif playerarea == true and death == false:
		if global_position.x <= GameManager.player.global_position.x:
			$AnimationPlayer.play("AttackR")
		else:
			$AnimationPlayer.play("AttackL")
	

func take_damage():
	$HpBar.show()
	damaged = true
	hp -=1
	$AnimationPlayer.play("TakeDamage")
	if hp >= 1:
		pass
	else:
		Death()

		

func Death():
	if GameManager.currentenemy == self:
		GameManager.currentenemy = null
	death = true
	$AnimationPlayer.play("Death")
	GameManager.selflevel.discount_enemy()
	$CollisionShape2D.queue_free()
	$DetectedArea.queue_free()
	$HpBar.hide()

	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var r = rng.randi_range(0,3)
	if r == 1:
		var Coin = coin.instance()
		get_tree().get_root().add_child(Coin)
		Coin.global_position = global_position

func _on_BigDetectedArea_area_entered(area):
	if area.is_in_group("Train"):
#		detectedtrain = true
		pass


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Death":
		queue_free()
	if anim_name == "TakeDamage":
		damaged = false
		if trainarea == true or playerarea == true:
			Attack()
	if anim_name == "AttackR" or anim_name == "AttackL":
		if trainarea == true or playerarea == true:
			Attack()
		if trainarea == true:
			GameManager.train.take_damage()
		elif playerarea == true:
			GameManager.player.take_damage()

func destroyed_head_bone():
	$Skeleton2D/Spine/Body/Head.queue_free()

