@icon("icons/ReactionIcon.svg")
class_name Reaction
extends Node

## In an interaction, [Reaction] is the node that receives an action
## This node can be added to any CollisionObject
##
## This node will trigger the [enter_react] signal when an interaction begins,
## [inside_react] while it is within an interaction, and [exit_react] when it leaves the interaction.


## Signal triggered when an interaction begins
signal enter_react(body)


## Signal triggered while within an interaction
signal inside_react(body)


## Signal triggered when leaving the interaction
signal exit_react(body)
