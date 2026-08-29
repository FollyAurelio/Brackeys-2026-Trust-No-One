extends RefCounted

class Wall extends Thing:
	
	enum WallType {
		BRICK,
		ROCK,
		P_ROCK,
		TORCH,
		TOMBSTONE,
		CASKET,
	}
	var type : WallType
	
	func _to_string() -> String:
		return "#"
	
	
	func set_layer() -> void:
		layer = Floor.Cell.Layer.STATIC
	
	
	func after_player_turn(flor : Floor) -> void:
		var player = flor.get_player()
		if player.position == position:
			player.move_back(flor)
	
	
	func turn(_flor : Floor) -> void:
		pass


class Sludge extends Thing:
	
	func _to_string() -> String:
		return "M"
	
	
	func set_layer() -> void:
		layer = Floor.Cell.Layer.STATIC
	
	func after_player_turn(flor : Floor) -> void:
		var player = flor.get_player()
		if player.position == position:
			player.take_damage(1)
			remove(flor)
	

	func turn(_flor : Floor) -> void:
		pass
	
