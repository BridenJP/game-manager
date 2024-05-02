extends Node2D
class_name Level

signal score_changed
signal level_cleared

var score: int = 0
var n_collectibles: int = 0
var CollectibleBronze: PackedScene = preload("res://items/collectible_bronze.tscn")
var CollectibleSilver: PackedScene = preload("res://items/collectible_silver.tscn")
var CollectibleGold: PackedScene = preload("res://items/collectible_gold.tscn")

func _ready() -> void:
	make_items()
	
func make_items() -> void:
	pass
	
func get_time_limit() -> int:
	return 10

func make_collectible(item_class: PackedScene, x: float, y: float) -> Collectible:
	var collectible: Collectible = item_class.instantiate()
	collectible.position = Vector2(x, y)
	collectible.connect("collected", _on_collectible_collected)
	collectible.connect("tree_exited", _on_collectible_destroyed)
	add_child(collectible)
	n_collectibles += 1
	return collectible

func _on_collectible_collected(points) -> void:
	emit_signal("score_changed", points)
	
func _on_collectible_destroyed() -> void:
	n_collectibles -= 1
	if n_collectibles <= 0:
		emit_signal("level_cleared")
		
