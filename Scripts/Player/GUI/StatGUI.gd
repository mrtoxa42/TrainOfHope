extends CanvasLayer


func _process(delta):
	if GameManager.player != null:
		$PlayerHpBar.value = GameManager.player.hp
	if GameManager.train != null:
		$TrainHpBar.value  = GameManager.train.hp
