@abstract class_name Item
extends Thing

var name : String

func set_layer() -> void:
	layer = Floor.Cell.Layer.ITEMS
	
func after_player_turn(flor : Floor) -> void:
	var player = flor.get_player()
	if player.position == position:
		player.add_inventory(self)

func turn(flor : Floor) -> void:
	pass
	
class Weapon extends Item:
	
	enum WeaponType {
		SWORD,
		BOW,
		STAFF,
		AXE,
		SPEAR,
		
	}
	
	var type : WeaponType
	var power : int
	var effect : int
	var max_durability : int
	var durability : int
	
	
	func _to_string() -> String:
		return "W"

class Trinket extends Item:
	
	enum TrinketType {
		ACHILES
	}
	
	var type : TrinketType
	
	func _to_string() -> String:
		return "T"
	
	func attack_trinkify(damage : int, effect : int, enemy : int) -> int:
		match(type):
			TrinketType.ACHILES:
				if enemy is int:
					return damage / 2
				return damage * 2
			_:
				return damage
	
	func defense_trinkify(damage : int, effect : int, enemy : int) -> void:
		match(type):
			pass
		
	func passive_trinkify(player : Player) -> void:
		pass
	
	func remove_trinkify(player : Player) -> void:
		pass
