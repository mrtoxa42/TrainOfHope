extends Area2D

var pull = false


func _on_AnimationPlayer_animation_finished(anim_name:String):
	if anim_name == "PullAni":
		if pull == false:
			GameManager.gamedata.coin +=10
			GameManager.player.plus_coin()
			queue_free()

func _on_Coin_area_entered(area:Area2D):
	if area.is_in_group("Player"):
		$AnimationPlayer.play("PullAni")
		pull = true
	
