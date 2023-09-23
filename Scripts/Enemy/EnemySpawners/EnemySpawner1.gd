extends Position2D

var zombie1 = preload("res://Scenes/Enemy/Zombie1.tscn")


var rng = RandomNumberGenerator.new()
var r
func _on_SpawnTimer_timeout():
	rng.randomize()
	r = rng.randi_range(0,3)

	if r == 2:
		var Zombie1 = zombie1.instance()
		get_tree().get_root().add_child(Zombie1)
		Zombie1.global_position = global_position
