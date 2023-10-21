extends Area2D




func _on_AnimationPlayer_animation_finished(anim_name:String):
	pass

func _on_Coin_area_entered(area:Area2D):
	if area.is_in_group("Player"):
		GameManager.gamedata.coin +=10
		GameManager.player.plus_coin()
		queue_free()
