class_name Status
extends RefCounted

enum StatusType {
	NONE,
	POISON,
	WEAK,
	STUN,
}

var type : StatusType
var duration : int

func _init(type : StatusType, duration : int) -> void:
	self.type = type
	self.duration = duration


func tick(player : Player) -> void:
	duration -= 1
	
		
	
