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
	
	
	func _to_string() -> String:
		return "#"
	
	
	func set_layer() -> void:
		layer = Floor.Cell.Layer.STATIC
	
	
	func after_player_turn(flor : Floor) -> void:
		var entity : Thing = (
				flor.get_cell(position).
				get_at_layer(Floor.Cell.Layer.PLAYERS)
		)
		if entity:
			entity.move_back(flor)
	
	
	func turn(_flor : Floor) -> void:
		pass


class Sludge extends Thing:
	
	func _to_string() -> String:
		return "M"
	
	
	func set_layer() -> void:
		layer = Floor.Cell.Layer.STATIC
	
	func after_player_turn(flor : Floor) -> void:
		var entity : Thing = (
				flor.get_cell(position).
				get_at_layer(Floor.Cell.Layer.PLAYERS)
		)
		if entity:
			entity.take_damage(1)
			flor.get_cell(position).set_at_layer(null, Floor.Cell.Layer.STATIC)
	

	func turn(_flor : Floor) -> void:
		pass
	
