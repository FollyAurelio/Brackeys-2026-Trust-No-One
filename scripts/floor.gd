class_name Floor
extends RefCounted

const ROOM_SIZE := Vector2i(16, 16)
const FLOOR_SIZE := Vector2i(48, 48)
const ROOMS_GRID : Vector2i = FLOOR_SIZE / ROOM_SIZE

var cells : Array[Array] 
var rooms : Array[Array]

func _init() -> void:
	init_rooms()
	init_cells()
	var player = Player.new(Vector2i(16,0))
	#var wall = Wall.new(Vector2i(0,0))
	#get_cell(Vector2i(15,0)).set_at_layer(player ,Cell.Layer.PLAYERS)
	#get_cell(Vector2i(0,0)).set_at_layer(wall ,wall.layer)
	player.move(self, Vector2i(1, 0))
	#wall.after_player_turn(self)
	print(self)
	print(self.get_room(Vector2i(1,0)))


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

func get_room(pos : Vector2i) -> Room:
	return rooms[pos.y][pos.x]

@abstract class Thing:
	
	var layer : int
	var position : Vector2i
	
	func _init(pos : Vector2i) -> void:
		set_layer()
		self.position = Vector2i(pos.x, pos.y)
	
	@abstract func _to_string() -> String
	@abstract func set_layer() -> void
	@abstract func after_player_turn(flor : Floor) -> void
	@abstract func turn(flor : Floor) -> void


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

class Player extends Thing:
	
	var prev_position : Vector2i
	
	func _init(pos : Vector2i) -> void:
		super(pos)
		prev_position = position
		#load all information from autoload here
	
	
	func _to_string() -> String:
		return "P"
	
	
	func set_layer() -> void:
		layer = Cell.Layer.PLAYERS
	
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
		layer = Cell.Layer.STATIC
	
	
	func after_player_turn(flor : Floor) -> void:
		var entity : Thing = (
				flor.get_cell(position).
				get_at_layer(Cell.Layer.PLAYERS)
		)
		if entity:
			entity.move_back(flor)
	
	
	func turn(_flor : Floor) -> void:
		pass
	
