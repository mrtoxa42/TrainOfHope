extends Node2D





func _process(delta):
	$Turret1/Turret1Label.text = "CURRENT TURRENT: " + str(GameManager.traindata.turret)
	$PlayerCoin/CurrentCoin.text = "COIN: " + str(GameManager.gamedata.coin)
	$ExtraVagons/VagonLabel.text = "CURRENT VAGON: " + str(GameManager.traindata.vagon)


func _on_Turret1Buy_pressed():
	if GameManager.gamedata.coin >= 10 and GameManager.traindata.turret < GameManager.traindata.vagon:
		GameManager.traindata.turret +=1
		GameManager.gamedata.coin -=10
		




func _on_GamePlay_pressed():
	get_tree().change_scene("res://Scenes/Levels/Level1.tscn")


func _on_ExtraVagonBuyButton_pressed():
	if GameManager.gamedata.coin >= 10 and GameManager.traindata.vagon < 8:
		GameManager.traindata.vagon +=1
		GameManager.gamedata.coin -=10
