extends Node2D

func _physics_process(delta):
    var mouse_position = get_global_mouse_position()
    look_at(mouse_position)
