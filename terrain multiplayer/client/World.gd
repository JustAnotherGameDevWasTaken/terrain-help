extends Node3D

var peer = ENetMultiplayerPeer.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	peer.create_client("localhost", 25565)
	multiplayer.multiplayer_peer = peer


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rpc_id(1, "player_sync", get_node("CharacterBody3D").get_transform())
	

@rpc(call_remote)
func player_sync(position):
	pass
