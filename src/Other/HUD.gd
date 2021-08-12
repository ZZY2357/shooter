extends CanvasLayer

func _on_Player_change_hp_progress(value):
    $ProgressBar.value = value
