extends Level

func make_items() -> void:
	for i in range(16):
		make_collectible(CollectibleSilver, 250 + 40 * i, 300 + 40 * cos(i * PI / 8))

	for i in range(16):
		make_collectible(CollectibleGold, 280 + 40 * i, 580 + 40 * cos(i * PI / 8))

func get_time_limit() -> int:
	return 12
