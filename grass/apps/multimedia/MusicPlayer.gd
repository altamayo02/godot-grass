extends Control

class Stream:
	var path
	var title
	var stream
	
	func _init(p_path:String):
		path = p_path
		var regex = RegEx.new()
		regex.compile("([^\\/]+(?=\\.))")
		title = regex.search(path)
		if title:
			title = title.strings[0]
		stream = ResourceLoader.load(path)

var streams: Array
var prevHeld = false
var play_i = 4
var first_play = true


func _ready():
	var parent_dir = "res://storage/users/Kandelee/music/"
	var dir = Directory.new()
	if dir.open(parent_dir) == OK:
		dir.list_dir_begin(true, true)
		var folder = dir.get_next()
		# TODO - Make recursive, not hardcoded
		while folder != "":
			if dir.current_is_dir():
				var artist_folder = Directory.new()
				if artist_folder.open(parent_dir + folder) == OK:
					artist_folder.list_dir_begin(true, true)
					var stream_path = artist_folder.get_next()
					while stream_path != "":
						if !stream_path.ends_with(".import"):
							var stream = Stream.new(parent_dir + "%s/%s" % [folder, stream_path])
							streams.append(stream)
						stream_path = artist_folder.get_next()
			folder = dir.get_next()
	
		$Title.text = streams[0].title
		$AudioStreamPlayer.stream = streams[0].stream


func _on_Previous_pressed():
	handle_stream_control(-1)


func _on_Next_pressed():
	handle_stream_control(1)


func _on_Play_toggled(_pressed):
	handle_stream_control(0)


func _on_AudioStreamPlayer_finished():
	$Controls/Next.emit_signal("pressed")
	$Controls/Play.pressed = true


func handle_stream_control(new_i:int):
	if new_i == 0:
		if !first_play:
			$AudioStreamPlayer.stream_paused = !$Controls/Play.pressed
		else:
			$AudioStreamPlayer.play()
			$AudioStreamPlayer.stream_paused = false
			first_play = false
		if $Controls/Play.pressed: $Controls/Play.text = "||"
		else: $Controls/Play.text = ">"
	else:
		$Controls/Play.pressed = false
		$AudioStreamPlayer.stop()
		first_play = true
		
		play_i += new_i
		if play_i < 0:
			play_i += len(streams)
		elif play_i >= len(streams):
			play_i = 0
		$AudioStreamPlayer.stream = streams[play_i].stream
		$Title.text = streams[play_i].title

func _input(_event):
	if Input.is_action_pressed("speed_up"):
		$AudioStreamPlayer.pitch_scale += 0.2
	elif Input.is_action_just_released("speed_down"):
		$AudioStreamPlayer.pitch_scale -= 0.2
