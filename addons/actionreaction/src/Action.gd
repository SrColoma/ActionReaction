@icon("icons/ActionIcon.svg")
class_name Action
extends Node

## In an interaction, [Action] is the node that will call or initiate the interaction,
## therefore, it must be a child of a [CollisionObject] such as an Area or a [RayCast] or a [RigidBody].
## This serves for both 3D and 2D.
##
## This node will trigger the [enter_act] signal when an interaction begins,
## [inside_act] while it is within an interaction, and [exit_act] when it leaves the interaction.
## Conversely, the node named [reaction] will have its own signals
## [enter_react], [inside_react], and [exit_react], respectively.

## Signal that is executed when an interaction begins,
signal enter_act(body)

## Signal that is executed during the interaction
signal inside_act(body)

## Signal that is executed when the interaction ends
signal exit_act(body)

## Name of the node that will react to this action
@export var reaction : String = ""

## Reference to the last object that collided
var previous_reactor

## Reference to the object that is being collided with
var reactor

## Reference to the specific node that is receiving the action
var reaction_node : Reaction

## Flag to determine if it is inside the collision
@onready var is_inside = false

## Parent of this node, can be: Area, Raycast or Rigidbody
@onready var actioner = get_parent()


func _ready():
	# Connects the signals from the parent to this node
	if actioner.has_signal("body_entered"):
		actioner.body_entered.connect(on_body_just_entered)
	
	if actioner.has_signal("body_exited"):
		actioner.body_exited.connect(on_body_exited)
		
	if actioner.has_signal("area_entered"):
		get_parent().area_entered.connect(on_body_just_entered)
	
	if actioner.has_signal("area_exited"):
		get_parent().area_exited.connect(on_body_exited)


func _physics_process(_delta):
	# Checks if it is inside the collision
	if actioner.has_method("is_colliding"):
		if actioner.is_colliding():
			var collider = actioner.get_collider()
			if collider and is_found_reaction(collider):
				if collider != previous_reactor:
					if previous_reactor:
						on_body_exited(previous_reactor)
					on_body_just_entered(collider)
				on_body_inside(collider)
			else:
				if previous_reactor:
					on_body_exited(previous_reactor)
		else:
			if previous_reactor:
				on_body_exited(previous_reactor)


## Executed when the body enters into collision or the raycast starts colliding
func on_body_just_entered(body):
	if not is_found_reaction(body): return
	enter_act.emit(body)
	is_inside = true
	previous_reactor = body
	if reaction_node:
		reaction_node.enter_react.emit(actioner)


## Executed while inside the collision or during the raycast collision
func on_body_inside(body):
	if not is_found_reaction(body): return
	inside_act.emit(body)
	if reaction_node:
		reaction_node.inside_react.emit(actioner)


## Executed when the body exits the collision or when the raycast stops colliding with that object
func on_body_exited(body):
	if not is_found_reaction(body): return
	if body:
		exit_act.emit(body)
		is_inside = false
		previous_reactor = null
		if reaction_node:
			reaction_node.exit_react.emit(actioner)


## Looks for the reaction node of this action
func is_found_reaction(body) -> bool:
	if not body: return false
	if body.has_node(reaction):
		reactor = body
		reaction_node = body.get_node(reaction)
		return true
	return false
