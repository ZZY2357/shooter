extends Control

func _on_Play_pressed():
    get_tree().change_scene("res://src/Pages/Main.tscn")

func _on_Help_pressed():
    get_tree().change_scene("res://src/Pages/Help.tscn")
