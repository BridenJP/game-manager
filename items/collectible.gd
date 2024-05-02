extends Area2D

signal collected(value)

func _on_body_entered(body):
	emit_signal("collected", 5)
	$AnimationPlayer.play("pickup")
