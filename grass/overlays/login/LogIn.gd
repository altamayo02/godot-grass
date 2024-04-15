extends Control

#var FilesService = preload("res://os/services/FilesService.gd")

func _ready():
	var err = connect("resized", self, "_on_LogIn_resized")
	if !err:
		var Profile = preload("res://overlays/login/Profile.tscn")
		var num_profiles = 6
		for i in range(num_profiles):
			var profile = Profile.instance()
			profile.index = i
#			profile.roulette_length = num_profiles * profile.get_size().y
			# Binds are passed by value
			# No binds are passed so array can be omitted,
			# but left in for exemplification
			err = connect("resized", profile, "_on_LogIn_resized", [num_profiles])
			err = profile.connect("gui_input", $ProfileCarousel, "_on_Profile_gui_input", [profile])
			err = profile.connect("gui_input", self, "_on_Profile_gui_input", [profile])
			err = $ProfileCarousel.connect("scrolling", profile, "_on_ProfileCarousel_scroll")
			if !err:
				$ProfileCarousel.add_child(profile)
				profile.rect_position.x = ($ProfileCarousel.get_size().x - profile.get_size().x) / 2
	#			profile.set_position(Vector2(
	#				($ProfileCarousel.get_size().x - profile.get_size().x) / 2,
	#				i * profile.rect_size.y + get_viewport_rect().get_center().y - num_profiles * profile.rect_size.y / 2
	#			))
		$ProfileCarousel.move_child($ProfileCarousel/Selected, $ProfileCarousel.get_child_count() - 1)
		emit_signal("resized")
		$ProfileCarousel.emit_signal("scrolling", $ProfileCarousel.ScrollDirection.UP)
#		$ProfileCarousel.set_anchors_preset(Control.PRESET_CENTER)
	
	
	print(err)


func _on_LogIn_resized():
	$AspectRatioContainer/Panel/TextureRect.rect_scale = (
		$AspectRatioContainer/Panel.get_size() / 150.0 * 0.1
	)
	var sbf = StyleBoxFlat.new()
	sbf.bg_color = Color("7c621d")
	sbf.corner_detail = 16
	sbf.border_width_bottom = $AspectRatioContainer/Panel.get_size().x / 15
	sbf.border_width_left = $AspectRatioContainer/Panel.get_size().x / 15
	sbf.border_width_right = $AspectRatioContainer/Panel.get_size().x / 30
	sbf.border_width_top = $AspectRatioContainer/Panel.get_size().x / 30
	sbf.border_color = Color("9c843c")
	sbf.corner_radius_bottom_left = $AspectRatioContainer/Panel.get_rect().get_center().x
	sbf.corner_radius_bottom_right = $AspectRatioContainer/Panel.get_rect().get_center().x
	sbf.corner_radius_top_left = $AspectRatioContainer/Panel.get_rect().get_center().x
	sbf.corner_radius_top_right = $AspectRatioContainer/Panel.get_rect().get_center().x
	$AspectRatioContainer/Panel.add_stylebox_override("panel", sbf)
	
	if $ProfileCarousel.selected:
		var size = Vector2(
			$ProfileCarousel.selected.get_child(0).get_size().x,
			0
		)
		for child in $ProfileCarousel.selected.get_children():
			size.y += child.get_size().y
		$ProfileCarousel/Selected.set_size(size)


func _on_Profile_gui_input(_event, _profile):
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		$"Contraseña/LineEdit".editable = true


func _on_Panel_gui_input(_event):
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		var err = get_tree().change_scene("res://Desktop.tscn")
		print(err)
