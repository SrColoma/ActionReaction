# Action-Reaction
In an interaction, [Action] is the node that will call or initiate the interaction,
therefore, it must be a child of a [CollisionObject] such as an Area or a [RayCast] or a [RigidBody].
This serves for both 3D and 2D and [Reaction] is the node that receives an action.

### Action Node
This node will trigger the [enter_act] signal when an interaction begins,
[inside_act] while it is within an interaction, and [exit_act] when it leaves the interaction.
Conversely, the node named [reaction] will have its own signals
[enter_react], [inside_react], and [exit_react], respectively.

### Reaction Node
This node will trigger the [enter_react] signal when an interaction begins,
[inside_react] while it is within an interaction, and [exit_react] when it leaves the interaction.
