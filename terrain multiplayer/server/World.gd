extends Node3D

var peer = ENetMultiplayerPeer.new()
var id = 0

var clock = Timer.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	self.add_child(clock)
	clock.one_shot = false
	clock.start(720)
	peer.create_server(25565)
	multiplayer.multiplayer_peer = peer
	multiplayer.multiplayer_peer.peer_connected.connect(
		func(id): 
			var new_viewer = VoxelViewer.new()
			new_viewer.name = str(id)
			new_viewer.set_network_peer_id(id)
			new_viewer.requires_data_block_notifications = true
			new_viewer.global_translate(Vector3(0,200,0))
			get_node("Marker3D").add_child(new_viewer)
	)
	
	multiplayer.multiplayer_peer.peer_disconnected.connect(
		func(id):
			get_node("Marker3D/"+str(id)).queue_free()
	)

@rpc(any_peer, unreliable)
func player_sync(position):
	get_node("Marker3D").get_node(str(multiplayer.get_remote_sender_id())).transform = position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(get_node("Marker3D").get_children())
	#print(multiplayer.get_peers())
	print(clock.time_left)
	get_node("DirectionalLight3D").rotation.x = deg_to_rad(clock.time_left/4 * -1)
