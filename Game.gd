extends Node2D
onready var _grid = $Grid

func _ready():
	_grid.create_new_grid()
