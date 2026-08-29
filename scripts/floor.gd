class_name Floor
extends RefCounted

const ROOM_SIZE := Vector2i(16, 16)
const FLOOR_SIZE := Vector2i(48, 48)
const ROOMS_GRID : Vector2i = FLOOR_SIZE / ROOM_SIZE

var cells : Array[Array] 
var rooms : Array[Array]
var player : Player


func _init(player : Player) -> void:
	init_rooms()
	init_cells()
	self.player = player

func _to_string() -> String:
	var string : String = ""
	for y in FLOOR_SIZE.y:
		for x in FLOOR_SIZE.x:
			string += str(get_cell(Vector2i(x, y))) + " "
		string += "\n"
	return string


func init_cells() -> void:
	for i in FLOOR_SIZE.y:
		cells.append([])
		cells[i].resize(FLOOR_SIZE.x)
	for i in FLOOR_SIZE.y:
		for j in FLOOR_SIZE.x:
			cells[i][j] = (
					get_room(Vector2i(j / ROOM_SIZE.x ,i / ROOM_SIZE.y ))
					.get_cell(Vector2i(j % ROOM_SIZE.x,i % ROOM_SIZE.y))
			)


func init_rooms() -> void:
	for i in ROOMS_GRID.y:
		rooms.append([])
		for j in ROOMS_GRID.x:
			rooms[i].append(Room.new(Vector2i(j, i)))
		
	
	
func get_cell(pos : Vector2i) -> Cell:
	return cells[pos.y][pos.x]

func get_room_cell(pos : Vector2i) -> Room:
	return get_room(pos / ROOM_SIZE)


func get_room(pos : Vector2i) -> Room:
	return rooms[pos.y][pos.x]

func get_player() -> Player:
	return player


class Cell:
	
	enum Layer {
		STATIC,
		ITEMS,
		PROJECTILES,
		ENEMIES,
		PLAYERS
	}
	var position : Vector2i
	var layers : Array[Thing] = [null, null, null, null, null]
	
	
	func _init(pos : Vector2i) -> void:
		self.position = pos
	

	func _to_string() -> String:
		for i in range(Layer.PLAYERS, -1, -1):
			if layers[i]:
				return str(layers[i])
		return "-"
	
	
	func get_at_layer(layer : Layer) -> Thing:
		return layers[layer]
	
	func set_at_layer(thing : Thing, layer : Layer) -> void:
		layers[layer] = thing
		
class Room:
	
	var position : Vector2i
	var cells : Array[Array]
	
	func _to_string() -> String:
		var string : String = ""
		for y in ROOM_SIZE.y:
			for x in ROOM_SIZE.x:
				string += str(get_cell(Vector2i(x, y))) + " "
			string += "\n"
		return string
	
	func _init(pos : Vector2i) -> void:
		self.position = pos
		for i in ROOM_SIZE.y:
			cells.append([])
			for j in ROOM_SIZE.x:
				cells[i].append(Cell.new(Vector2i(j, i)))
				
	
	func get_cell(pos : Vector2i) -> Cell:
		return cells[pos.y][pos.x]


	
