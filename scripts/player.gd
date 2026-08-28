class_name Player
extends Thing

var prev_position : Vector2i
var health = 5
	
func _init(pos : Vector2i) -> void:
	super(pos)
	prev_position = position
	#load all information from autoload here
	
	
func _to_string() -> String:
	return "P"
	

func set_layer() -> void:
		layer = Floor.Cell.Layer.PLAYERS

func after_player_turn(_flor : Floor) -> void:
	pass
func turn(_flor : Floor) -> void:
	pass

func move(flor : Floor, direction : Vector2i) -> void:
	prev_position = position
	position = position + direction
	flor.get_cell(prev_position).set_at_layer(null, layer)
	flor.get_cell(position).set_at_layer(self, layer)


func move_back(flor : Floor) -> void:
	flor.get_cell(position).set_at_layer(null, layer)
	flor.get_cell(prev_position).set_at_layer(self, layer)
	position = prev_position


func take_damage(damage : int) -> void:
	health = move_toward(health, 0, damage)
	
