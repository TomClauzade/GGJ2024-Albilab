extends MeshInstance3D
var rngTimeToJump = RandomNumberGenerator.new()
var previousTimeJump = 0
var nextJumpTime:float = rngTimeToJump.randf_range(1, 20.0)
var jumpheight = 0.1
var jumpTime = 0.5

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var moment=0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	moment+=delta
	if moment >= nextJumpTime :
		_jumpPublic()
		moment = 0
		nextJumpTime = rngTimeToJump.randf_range(0, 10.0)
	
	pass

func _jumpPublic () :
	var previousPositionY = self.position.y
	self.position.y = self.position.y + jumpheight
	await get_tree().create_timer(jumpTime).timeout
	self.position.y = previousPositionY
	
	pass
	
