extends Node2D




func _ready():
	pass 



func _on_StartButton_pressed():
	get_tree().change_scene("res://Scenes/Game/MainGame.tscn")


func _on_Settings_pressed():
	get_tree().change_scene("res://Scenes/Menü/Settings.tscn")
