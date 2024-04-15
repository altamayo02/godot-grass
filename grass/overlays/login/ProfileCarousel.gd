extends Container

enum ScrollDirection {
	UP = 1
	DOWN = -1
}

signal scrolling(is_scrolling_up)
var focused = false
var selected: VBoxContainer = null


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _input(_event):
	if focused:
		if Input.is_mouse_button_pressed(BUTTON_WHEEL_UP):
			emit_signal("scrolling", ScrollDirection.UP)
		elif Input.is_mouse_button_pressed(BUTTON_WHEEL_DOWN):
			emit_signal("scrolling", ScrollDirection.DOWN)


func _on_ProfileRoulette_mouse_entered():
	focused = true


func _on_ProfileRoulette_mouse_exited():
	focused = false


func _on_Profile_gui_input(_event: InputEvent, profile: VBoxContainer):
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		$Selected.visible = true
		if selected:
			if selected != profile:
				pass
			else: return
		$Selected.set_position(profile.get_position() - Vector2(5, 5))
		$Selected.set_size(profile.get_size() + Vector2(10, 10))
		selected = profile


func _on_ProfileCarousel_scrolling(_is_scrolling_up):
	if selected:
		$Selected.set_position(selected.get_position() - Vector2(5, 5))
		$Selected.set_size(selected.get_size() + Vector2(10, 10))
