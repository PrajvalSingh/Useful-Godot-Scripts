extends Node3D

var sway_threshold = 5
var sway_lerp = 5
var mouse_move

@export var sway_left:Vector3 = Vector3(0, 0, 0.1)
@export var sway_right:Vector3 = Vector3(0, 0, -0.1)

func _input(event):
	if event is InputEventMouseMotion:
		mouse_move = -event.relative.x

func _process(delta):
	if mouse_move != null:
		if mouse_move > sway_threshold:
			rotation = rotation.lerp(sway_left, sway_lerp * delta)
		elif mouse_move < -sway_threshold:
			rotation = rotation.lerp(sway_right, sway_lerp * delta)
		else:
			rotation = rotation.lerp(Vector3(0, 0, 0), sway_lerp * delta)
