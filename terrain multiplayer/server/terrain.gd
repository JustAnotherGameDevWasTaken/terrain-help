extends VoxelTerrain

var buffer = StreamPeerBuffer.new()
var pos
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_data_block_entered(info):
	if info.are_voxels_edited():
		VoxelBlockSerializer.new().serialize(buffer, info.get_voxels(), true)
		var data = buffer.data_array
		await get_tree().create_timer(1).timeout
		rpc_id(info.get_network_peer_id(), "test", info.get_position(), data)
	else:
		rpc_id(info.get_network_peer_id(), "local_gen_voxels", info.get_voxels().get_size(), info.get_position(), info.get_lod_index())
		#pass
	
@rpc(call_remote)
func test(pos, data):
	pass

@rpc(call_remote)
func local_gen_voxels(size, origin, lod):
	pass
