@abstract class_name Thing
extends RefCounted

	
var layer : int
var position : Vector2i
	
func _init(pos : Vector2i) -> void:
	set_layer()
	self.position = Vector2i(pos.x, pos.y)
	
@abstract func _to_string() -> String
@abstract func set_layer() -> void
@abstract func after_player_turn(flor : Floor) -> void
@abstract func turn(flor : Floor) -> void
