extends KinematicBody2D



var speed = 50
var velocity = Vector2(1,0)
var playerarea = false
var move = false
var hp = 100



var turrets = {}
var countcurrentturret = 3
var turret1 = preload("res://Scenes/Train/Turrets/Turret1.tscn")

func _ready():
	GameManager.train = self
	countcurrentturret = GameManager.traindata.turret
	CurrentVagon()
	CurrentTurret()

func _process(delta):
	if move == true and GameManager.gamestarted == true:
		move_and_slide(velocity * speed)

func CurrentVagon():
	if GameManager.traindata.vagon == 3:
		$ExtrasVagon/ExtraVagon1.hide()
		$ExtrasVagon/ExtraVagon2.hide()
		$ExtrasVagon/ExtraVagon3.hide()
		$ExtrasVagon/ExtraVagon4.hide()
		$ExtrasVagon/ExtraVagon5.hide()
		
		$ExtrasVagon/ExtraVagon1/Area2D/Shape1.disabled = true
		$ExtrasVagon/ExtraVagon1/Area2D/Shape2.disabled = true
		$ExtrasVagon/ExtraVagon1/Area2D/Shape3.disabled = true
		$ExtrasVagon/ExtraVagon1/Area2D/Shape4.disabled = true
		$ExtrasVagon/ExtraVagon1/Area2D/Shape5.disabled = true
		
	elif GameManager.traindata.vagon == 4:
		$ExtrasVagon/ExtraVagon1.show()
		$ExtrasVagon/ExtraVagon2.hide()
		$ExtrasVagon/ExtraVagon3.hide()
		$ExtrasVagon/ExtraVagon4.hide()
		$ExtrasVagon/ExtraVagon5.hide()
		
		$ExtrasVagon/ExtraVagon1/Area2D/Shape1.disabled = false
		$ExtrasVagon/ExtraVagon1/Area2D/Shape2.disabled = true
		$ExtrasVagon/ExtraVagon1/Area2D/Shape3.disabled = true
		$ExtrasVagon/ExtraVagon1/Area2D/Shape4.disabled = true
		$ExtrasVagon/ExtraVagon1/Area2D/Shape5.disabled = true
	elif GameManager.traindata.vagon == 5:
		$ExtrasVagon/ExtraVagon1.show()
		$ExtrasVagon/ExtraVagon2.show()
		$ExtrasVagon/ExtraVagon3.hide()
		$ExtrasVagon/ExtraVagon4.hide()
		$ExtrasVagon/ExtraVagon5.hide()
		
		$ExtrasVagon/ExtraVagon1/Area2D/Shape1.disabled = false
		$ExtrasVagon/ExtraVagon1/Area2D/Shape2.disabled = false
		$ExtrasVagon/ExtraVagon1/Area2D/Shape3.disabled = true
		$ExtrasVagon/ExtraVagon1/Area2D/Shape4.disabled = true
		$ExtrasVagon/ExtraVagon1/Area2D/Shape5.disabled = true
	elif GameManager.traindata.vagon == 6:
		$ExtrasVagon/ExtraVagon1.show()
		$ExtrasVagon/ExtraVagon2.show()
		$ExtrasVagon/ExtraVagon3.show()
		$ExtrasVagon/ExtraVagon4.hide()
		$ExtrasVagon/ExtraVagon5.hide()
		
		$ExtrasVagon/ExtraVagon1/Area2D/Shape1.disabled = false
		$ExtrasVagon/ExtraVagon1/Area2D/Shape2.disabled = false
		$ExtrasVagon/ExtraVagon1/Area2D/Shape3.disabled = false
		$ExtrasVagon/ExtraVagon1/Area2D/Shape4.disabled = true
		$ExtrasVagon/ExtraVagon1/Area2D/Shape5.disabled = true
	elif GameManager.traindata.vagon == 7:
		$ExtrasVagon/ExtraVagon1.show()
		$ExtrasVagon/ExtraVagon2.show()
		$ExtrasVagon/ExtraVagon3.show()
		$ExtrasVagon/ExtraVagon4.show()
		$ExtrasVagon/ExtraVagon5.hide()
		
		$ExtrasVagon/ExtraVagon1/Area2D/Shape1.disabled = false
		$ExtrasVagon/ExtraVagon1/Area2D/Shape2.disabled = false
		$ExtrasVagon/ExtraVagon1/Area2D/Shape3.disabled = false
		$ExtrasVagon/ExtraVagon1/Area2D/Shape4.disabled = false
		$ExtrasVagon/ExtraVagon1/Area2D/Shape5.disabled = true
	elif GameManager.traindata.vagon == 8:
		$ExtrasVagon/ExtraVagon1.show()
		$ExtrasVagon/ExtraVagon2.show()
		$ExtrasVagon/ExtraVagon3.show()
		$ExtrasVagon/ExtraVagon4.show()
		$ExtrasVagon/ExtraVagon5.show()

		$ExtrasVagon/ExtraVagon1/Area2D/Shape1.disabled = false
		$ExtrasVagon/ExtraVagon1/Area2D/Shape2.disabled = false
		$ExtrasVagon/ExtraVagon1/Area2D/Shape3.disabled = false
		$ExtrasVagon/ExtraVagon1/Area2D/Shape4.disabled = false
		$ExtrasVagon/ExtraVagon1/Area2D/Shape5.disabled = false
func CurrentTurret():
	if countcurrentturret > 0:
		var Turret1 = turret1.instance()
		add_child(Turret1)
		var a = get_node("Turrets/TurretSpawnPosition" + str(countcurrentturret))
		Turret1.global_position = a.global_position
		countcurrentturret -=1
		if countcurrentturret > 0:
			CurrentTurret()
		
func _on_Detected_area_entered(area):
	if area.is_in_group("Player"):
		playerarea = true
		
		if move == false:
			$StartStop.start()

func _on_Detected_area_exited(area):
	if area.is_in_group("Player"):
		playerarea = false
		$MoveAreaSprite/AnimationPlayer.play("Area")
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
