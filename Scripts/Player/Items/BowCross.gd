extends Node2D



func _ready():
	GameManager.bowcross = self 
	






func _process(delta):
	$PowerBar.value = GameManager.player.bowpower
	global_position = get_global_mouse_position()




func hide_bar():
	$PowerBar.hide()
func show_bar():
	$PowerBar.show()
