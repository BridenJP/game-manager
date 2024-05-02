extends Area2D
class_name Collectible

signal collected(points: int)

func get_value() -> int:
	return 1

func _on_body_entered(body) -> void:
	emit_signal("collected", get_value())
	$AnimationPlayer.play("pickup")
