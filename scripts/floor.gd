class_name Floor
extends RefCounted

const ROOM_SIZE := Vector2i(16, 16)
const FLOOR_SIZE := Vector2i(48, 48)

var cells : Array[Array] 
var rooms : Array[Array]

func _init() -> void:
	init_cells()
	print(self)

func _to_string() -> String:
	var string : String = ""
	for x in FLOOR_SIZE.x:
		for y in FLOOR_SIZE.y:
			string += str(get_cell(x, y)) + " "
		string += "\n"
	return string


func init_cells() -> void:
	for i in FLOOR_SIZE.y:
		cells.append([])
		for j in FLOOR_SIZE.x:
			cells[i].append(Cell.new(j, i))


func get_cell(pos_x : int, pos_y : int) -> Cell:
	return cells[pos_y][pos_x]

@abstract class Thing:
	
	var position : Vector2i
	
	@abstract func after_player_turn(flor : Floor) -> void
	@abstract func turn(flor : Floor) -> void


class Cell:
	
	var position : Vector2i
	var layers : Array[Thing] = [null, null, null, null]
	
	
	func _init(pos_x : int, pos_y : int) -> void:
		self.position = Vector2i(pos_x, pos_y)
	
	
	func _to_string() -> String:
		var val = layers[-1]
		if val:
			return str(val)
		return "-"
	
	
	func get_at_layer(layer : int) -> Thing:
		return layers[layer]
	
	
	
	
