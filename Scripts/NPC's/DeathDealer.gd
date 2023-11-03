extends Area2D



var currentelevel
var deathshop = preload("res://Scenes/Shop/DeathShop.tscn")


func _ready():
	GameManager.deathdealer = self



func _on_AnimationPlayer_animation_finished(anim_name:String):
	if anim_name == "EntryAni":
	
		var DeathShop = deathshop.instance()
		$Position2D.add_child(DeathShop)
	if anim_name == "ExitAni":
		$Position2D.queue_free()	
		GameManager.wavebreak = false
		GameManager.selflevel.wave_started()
		GameManager.train.station = false
		queue_free()


func quit_time():
	$AnimationPlayer.play("ExitAni")
