extends CanvasLayer

# Load components
@onready var animation_player: AnimationPlayer = $AnimationPlayer

# Local variables
var load_scene: String = ""
var current_scene: Node = null
var load_map_path: String = ""
var current_map_name: Constants.GameScenes = Constants.GameScenes.MAIN_MENU


func _ready() -> void:
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)
	load_map_path = current_scene.scene_file_path
	visible = false

	# Connect the animation finished signal to the function
	animation_player.animation_finished.connect(_on_animation_finished)
	SignalBus.map_loaded.connect(handle_map_loaded)


func goto_scene(map_name: Constants.GameScenes) -> void:
	# This function will usually be called from a signal callback,
	# or some other function in the current scene.
	# Deleting the current scene at this point is
	# a bad idea, because it may still be executing code.
	# This will result in a crash or unexpected behavior.

	# The solution is to defer the load to a later time, when
	# we can be sure that no code from the current scene is running:
	if Constants.MAPS.has(map_name) == false:
		push_error("Map not found: ", map_name)
		return

	print("Going to scene: ", map_name)
	var map_uid = Constants.MAPS[map_name]

	current_map_name = map_name
	load_map_path = map_uid

	print("Fading IN started!")
	animation_player.play("fade_in")



func _deferred_goto_scene(path: String) -> void:
	# It is now safe to remove the current scene.
	current_scene.free()

	# Load the new scene.
	var s = ResourceLoader.load(path)

	# Instance the new scene.
	current_scene = s.instantiate()

	# Add it to the active scene, as child of root.
	get_tree().root.add_child(current_scene)

	# Optionally, to make it compatible with the SceneTree.change_scene_to_file() API.
	get_tree().current_scene = current_scene
	SignalBus.map_loaded.emit(current_map_name)



func _on_animation_finished(anim_name: String) -> void:
	if anim_name == "fade_in":
		call_deferred("_deferred_goto_scene", load_map_path)


func handle_map_loaded(_map_path: Constants.GameScenes) -> void:
	animation_player.play("fade_out")
	print("Fading OUT started!")
