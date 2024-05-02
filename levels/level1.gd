extends Level

func make_items() -> void:
	for i in range(16):
		make_collectible(CollectibleBronze, 250 + 40 * i, 300 + 40 * cos(i * PI / 8))
