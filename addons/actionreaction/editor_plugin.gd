@tool
extends EditorPlugin


func _enter_tree():
	add_custom_type(
		"Action",
		"Node",
		preload("src/Action.gd"),
		preload("icons/ActionIcon.svg")
	)
	add_custom_type(
		"Reaction",
		"Node",
		preload("src/Reaction.gd"),
		preload("icons/ReactionIcon.svg")
	)


func _exit_tree():
	remove_custom_type("Action")
	remove_custom_type("Reaction")
