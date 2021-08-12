extends MarginContainer

func _ready():
    $VBoxContainer/Score_Display/Score.text = \
        PlayerVariable.score as String

func _on_Exit_pressed():
    get_tree().quit()

func _on_Replay_pressed():
    PlayerVariable.score = 0
    get_tree().change_scene("res://src/Pages/Main.tscn")
