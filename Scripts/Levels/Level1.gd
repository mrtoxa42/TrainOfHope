extends Node2D

var enemycounter = 30
var wave = 1


func _ready():
	GameManager.selflevel = self
	GameManager.nowlevel = 1
	GameManager.levelin = true

func _process(delta):
	$LevelCanvas/WaveLabel.text = "KALAN DÜŞMAN: " + str(enemycounter)
	if wave == 1:
		pass

func wave1():
	wave = 1
	$WaveCanvas/Wave1/Label.text = "WAVE 1"
	enemycounter = 30
func wave2():
	$WaveCanvas/Wave1/Label.text = "WAVE 2/3"
	$AnimationPlayer.play("WaveAni")


func break_wave():
	GameManager.gamestarted = false
func discount_enemy():
	if enemycounter >= 1:
		enemycounter -=1
	else:
		wave2()




func game_started():
	GameManager.gamestarted = true
	wave1()
	
