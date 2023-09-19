extends Position2D

var zombie1 = preload("res://Scenes/Enemy/Zombie1.tscn")



func _on_SpawnTimer_timeout():
	var Zombie1 = zombie1.instance()
	get_tree().get_root().add_child(Zombie1)
	Zombie1.global_position = global_position
