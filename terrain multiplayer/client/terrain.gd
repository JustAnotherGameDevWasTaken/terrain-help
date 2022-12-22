extends VoxelTerrain

var terrain = VoxelTerrain.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

@rpc(reliable)
func test(pos, data):
	var buffer = StreamPeerBuffer.new()
	buffer.data_array = data
	var voxels = VoxelBuffer.new()
	voxels.create(16,16,16)
	VoxelBlockSerializer.new().deserialize(buffer, voxels, buffer.get_size(), true)
	self.try_set_block_data(pos, voxels)

@rpc(reliable)
func local_gen_voxels(size, origin, lod):
	var buffer = VoxelBuffer.new()
	var channel = buffer.CHANNEL_TYPE
	buffer.create(size.x, size.y, size.z)
	self.generate_block_async(buffer, origin, lod)
