extends CanvasLayer


func _process(delta):
	$PlayerHpBar.value = GameManager.player.hp
	$TrainHpBar.value  = GameManager.train.hp
