extends Node2D

var enemycounter = 3
var wave = 1

#var bowcross = preload("res://Scenes/Player/Items/BowCross.tscn")
var deathdealer = preload("res://Scenes/NPC's/DeathDealer.tscn")

func _ready():
	
	GameManager.selflevel = self
	GameManager.nowlevel = 1
	GameManager.levelin = true
	

func _process(delta):
	GameManager.enemycounter = enemycounter
	$LevelCanvas/WaveLabel.text = "KALAN DÜŞMAN: " + str(enemycounter)
	if wave == 1:
		pass

func wave1():
	
	wave = 1
	$WaveCanvas/Wave1/Label.text = "WAVE 1"
	enemycounter = 300
func wave2():
	enemycounter = 3
	$WaveCanvas/Wave1/Label.text = "WAVE 2/3"
	$AnimationPlayer.play("WaveAni")



func break_wave():
	$LevelCanvas.hide()
	$AnimationPlayer.play("BreakWaveAni")
	$WaveCanvas/Wave1/Label.text = "DEATH" + "\n" +  "DEALER"
	GameManager.wavebreak = true
	var DeathDealer = deathdealer.instance()
	$CanvasLayer.add_child(DeathDealer) 

	GameManager.player.break_wave()


func discount_enemy():
	if enemycounter >= 1:
		enemycounter -=1
	else:
		if GameManager.train.station == true:
			break_wave()




func game_started():
#	var BowCross = bowcross.instance()
#	get_tree().get_root().add_child(BowCross)
	GameManager.gamestarted = true
	wave1()
	
func wave_started():
	GameManager.player.wave_start()
	$LevelCanvas.show()
	if wave == 1:
		wave = 2
	elif wave == 2:
		wave = 3




func _on_AnimationPlayer_animation_finished(anim_name:String):
	pass


func _on_AnimationPlayer_animation_started(anim_name):
	if anim_name == "BreakWaveAni":
		pass
