extends Area2D

onready var big_circle = $BigCircle
onready var small_circle = $BigCircle/SmallCircle

onready var max_distance = $CollisionShape2D.shape.radius

var touched = false

var state = {}

func _ready():
	GameManager.joystick = self

func _unhandled_input(event):
	if event is InputEventScreenTouch:
		if event.pressed and  not touched: # Down.
			state[event.index] = event.position
			var distance = state[event.index].distance_to(big_circle.global_position)
			if distance<max_distance:
				touched = true
		else: # Up.
			small_circle.position = Vector2(0,0)
			
			touched = false
			state.erase(event.index)


			
			
func _process(delta):
	if touched:
		small_circle.global_position = get_global_mouse_position()
		small_circle.position = big_circle.position + (small_circle.position - big_circle.position).clamped(max_distance)
		GameManager.relasedjoystick = get_velo()
		
func get_velo():
	var joy_velo = Vector2(0,0)
	joy_velo.x = small_circle.position.x / max_distance
	joy_velo.y = small_circle.position.y / max_distance
	return joy_velo
