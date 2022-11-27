extends ColorRect
class_name Cell
signal mouse_click(index)

const COLOURS = [0, Color.blue, Color.red, Color.green, Color.yellow, Color.white ]

var my_index:int setget set_my_index, get_my_index 
func set_my_index(value:int): 
	my_index = value 
func get_my_index(): 
	return my_index

var my_location:Vector2 setget set_location, get_location 
func set_location(value:Vector2): 
	my_location = value
func get_location():
	return my_location
	
var my_color:int setget set_colour, get_colour  
func set_colour(value:int): 
	my_color = value
	self.color = COLOURS[value]
		
func get_colour():
	return my_color

func erase_me(): 
	self.set_visible(false)

func is_loc_adjacent_to_me(loc:Vector2)->bool: 
	if abs(loc.x - self.my_location.x) > 1: return false
	if abs(loc.y - self.my_location.y) > 1: return false
	return true

func _on_Cell_gui_input(event):
	if event is InputEventMouseButton: 
		if event.doubleclick: 
			emit_signal("mouse_click", self.my_index)
