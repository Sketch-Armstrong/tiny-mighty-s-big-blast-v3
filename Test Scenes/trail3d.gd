@tool
extends MeshInstance3D

var _points : PackedVector3Array # stores 3D point positions

@export var _trailEnabled : bool = true ##enable drawing of the trail

@export var _startWidth : float = 1.0 ##starting width of trail
@export var _endWidth : float = 0.0 ##ending width of trail

@export var _trailLength : int = 32 ## number of points in the trail

@export var _startColor : Color = Color(1.0, 1.0, 1.0, 1.0) ##starting color
@export var _endColor : Color = Color(1.0, 1.0, 1.0, 1.0) ##ending color

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rebuild()

func setOrigin(newOrigin:Vector3):
	for i in range(_trailLength):
		_points[i] = newOrigin

func updatePoints(newLoc:Vector3):
	for i in range(_trailLength-1, 0, -1):
		_points[i] = _points[i-1]
	_points[0] = newLoc



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	#If trails are enabled
	if !_trailEnabled:
		return

	if _points.size() != _trailLength:
		rebuild()

	mesh.clear_surfaces()

	mesh.surface_begin(Mesh.PRIMITIVE_TRIANGLE_STRIP)
	for i in range(_trailLength):
		var t : float = float(i)/(_points.size()-1.0)
		var currColor : Color = _startColor.lerp(_endColor, 1-t)

		mesh.surface_set_color(currColor)

		var width : float = lerp(_startWidth, _endWidth, float(i)/_trailLength)

		var spoint : Vector3 = ((_points[min(i+1, _trailLength-1)]-\
								 _points[max(i-1, 0)]).\
								 normalized()).cross(Vector3(0,1,0))*width/2.0

		mesh.surface_set_color(lerp(_startColor, _endColor, float(i)/_trailLength))
		mesh.surface_set_uv(Vector2(t, 0))
		mesh.surface_add_vertex(to_local(_points[i]+spoint))
		mesh.surface_set_uv(Vector2(t, 1))
		mesh.surface_add_vertex(to_local(_points[i]-spoint))
	mesh.surface_end()

func rebuild() -> void:
	_points.resize(_trailLength)
	_points.fill(get_global_transform().origin)
	mesh = ImmediateMesh.new()
