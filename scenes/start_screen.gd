extends Node2D

signal start_button_pressed

func _on_start_button_pressed() -> void:
	emit_signal("start_button_pressed")
