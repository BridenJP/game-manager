extends Node2D

var score = 0
var Collectible = preload("res://collectible.tscn")

func _ready():
	for i in range(12):
		var collectible = Collectible.instantiate()
		collectible.position = Vector2(300 + 50 * i, 260)
		collectible.connect("collected", _on_collectible_collected)
		add_child(collectible)

func _on_collectible_collected(value):
	score += value
	$Score.text = str(score)
