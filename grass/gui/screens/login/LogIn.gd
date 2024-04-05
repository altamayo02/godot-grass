extends Control

#var FilesService = preload("res://os/services/FilesService.gd")

func _ready():
	var Profile = preload("res://gui/screens/login/Profile.tscn")
	for i in range(4):
		$Profiles.add_child(Profile.instance())
		$Profiles.get_child(i).set_position(Vector2(0, 250 * i))
#
#func _process(delta):
#	pass
