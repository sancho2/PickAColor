extends Node2D
class_name Grid

const COLOURS = [0, Color.blue, Color.red, Color.green, Color.yellow, Color.white ]
onready var _cell:Cell = $Cell0
onready var _cells = []

func create_new_grid()->void: 
	var n:int = 0
	for y in range(0, 8):
		for x in range(0, 5): 
			print(x,y)
			var cell:Cell 
			if x + y == 0:
				cell = _cell
			else: 
				cell = _cell.duplicate()

			var pos:Vector2 = Vector2(x * 32, y * 32)
			cell.set_position(pos)

			var loc:Vector2 = Vector2(x,y)			
			cell.set_location(loc)
			cell.set_colour(randi() % 5 + 1)
			cell.set_my_index(n)
			self.add_child(cell)
			cell.connect("mouse_click", self, "_on_cell_mouse_click")
			#cell.set_visible(true)
			#self.get_node("Game").append_child()
			_cells.append(cell)
			n += 1
		
func _erase_w(index:int)->void: 
	if index % 5 == 0: return 
	self._cells[index - 1].erase_me() 

func _erase_nw(index:int)->void: 
	if index % 5 == 0: return  
	if index < 6: return 
	self._cells[index - 6].erase_me()

func _erase_n(index:int)->void: 
	if index < 5: return 
	self._cells[index - 5].erase_me()

func _erase_ne(index:int)->void: 
	if index + 1 % 5 == 0: return 
	if index < 5: return 
	self._cells[index - 4].erase_me()

func _erase_e(index:int)->void: 
	if index + 1 % 5 == 0: return 
	self._cells[index + 1].erase_me()

func _erase_se(index:int)->void: 
	if index + 1 % 5 == 0: return 
	if index > 34: return 
	self._cells[index + 6].erase_me()

func _erase_s(index:int)->void: 
	if index > 34: return 
	self._cells[index + 5].erase_me()
	
func _erase_sw(index:int)->void: 
	if index % 5 == 0: return 
	if index > 34: return 
	self._cells[index + 4].erase_me()

func erase_surrounding_cells(cell:Cell)->void: 
	var index:int = cell.my_index
	self._erase_w(index)
	self._erase_nw(index)
	self._erase_n(index)
	self._erase_ne(index)
	self._erase_e(index)
	self._erase_se(index)
	self._erase_s(index)
	self._erase_sw(index)

func erase_matched_color(color:int)->void: 
	for cell in _cells: 
		if cell.my_color == color: 
			cell.erase_me()

func _on_cell_mouse_click(index:int):
	var cell = self._cells[index]
	erase_surrounding_cells(cell)
	erase_matched_color(cell.my_color)
