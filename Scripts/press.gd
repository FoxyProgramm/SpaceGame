extends StaticBody2D

var have_item: bool = false

var item = null
var mode: int = 0
var energy = 0.0
var need_energy = 0.3
var max_energy = 3.0

# Я не уверен как сделать это лучше, но выглядит как хуйня
func _init_mode():
	match mode:
		0:
			$"handler/1".modulate = Color(0.5, 0.5, 0.5, 1)
			$"handler/0".modulate = Color(1, 1, 1, 1)
		1:
			$"handler/0".modulate = Color(0.5, 0.5, 0.5, 1)
			$"handler/1".modulate = Color(1, 1, 1, 1)

func add_energy(value):
	energy += value
	$energy.value = energy

func _ready():
	_init_mode()
var result_count = 2
func _press():
	if need_energy > energy:
		await get_tree().create_timer(1).timeout
		_press()
		return
	add_energy(-need_energy)
	$image.rotation = 0
	await get_tree().create_tween().tween_property($image, "rotation", 12 * PI, 1).finished
	result_count = 2
	if mode == 1:
		result_count = 4
	Items._create_item(item, result_count, global_position + Vector2(0, 8))
	have_item = false

func _show_handler(): # Идеальный метод
	$handler.visible = !$handler.visible

# Идеальный метод №2
func _ch_mode(mod):
	mode = mod
	_init_mode()
