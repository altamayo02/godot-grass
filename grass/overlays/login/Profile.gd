extends Control


# Declare member variables here. Examples:
var init_rect
var roulette_length
var index


# Called when the node enters the scene tree for the first time.
func _ready():
	init_rect = rect_size
#	var username = ""
#	for _i in range(8):
#		username += "123456789abcdef"[randi() % 15]
#	$Username.text = username


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_LogIn_resized(num_profiles: int):
	var new_profile_size = init_rect / Vector2(
		# In a screen 1600 pixels wide and 900 pixels high,
		# the container is 250 pixels wide and 302 pixels high (Initial rect)
		1600, 900
	) * get_viewport_rect().size
#	print(new_profile_size)
	$AspectRatioContainer.rect_min_size = Vector2(new_profile_size.x, new_profile_size.x)
	roulette_length = num_profiles * new_profile_size.y
#	var roulette_length = num_profiles * (
#		new_profile_size.x + (new_profile_size.x / init_rect.x * init_rect.y)
#	)
	rect_position.y = index * new_profile_size.y
	$Username.text = "(%s)" % index


func _on_ProfileCarousel_scroll(scroll_dir: int):
	#index * rect_size.y + get_viewport_rect().get_center().y - roulette_length / init_rect * rect_size.y / 2
	var half_roulette = roulette_length / 2
	rect_position.y += scroll_dir * 50
	
	if rect_position.y > get_viewport_rect().get_center().y + half_roulette:
		rect_position.y -= roulette_length
	elif rect_position.y + rect_size.y < get_viewport_rect().get_center().y - half_roulette:
		rect_position.y += roulette_length
	print(index, " ", rect_position.y)

	# TODO - Carousel effect
#	$AspectRatioContainer.rect_min_size.y = init_rect.y * (
#		0.25 + 0.75 * sin((rect_position.y + init_rect.y / 2) / get_viewport().size.y * PI)
#	)
