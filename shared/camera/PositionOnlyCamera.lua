require("shared/camera/SharedCamera")
local l_0_0 = mvector3.add
local l_0_1 = mvector3.set
local l_0_2 = mvector3.rotate_with
if not PositionOnlyCamera then
	PositionOnlyCamera = class(SharedCamera)
end
PositionOnlyCamera.init = function(l_1_0, l_1_1)
	SharedCamera.init(l_1_0, l_1_1)
end

PositionOnlyCamera.parse_parameters = function(l_2_0, l_2_1)
	SharedCamera.parse_parameters(l_2_0, l_2_1)
	local l_2_2 = Vector3(0, 0, 0)
	if l_2_1.position then
		l_2_2 = TableSerializer._load_vector(l_2_1.position)
	end
	l_2_0:set_local_rotation(Rotation())
	l_2_0:set_local_position(l_2_2)
end

PositionOnlyCamera.update = function(l_3_0, l_3_1, l_3_2, l_3_3, l_3_4)
	-- upvalues: l_0_1 , l_0_2 , l_0_0
	l_0_1(l_3_0._position, l_3_0._local_position)
	l_0_2(l_3_0._position, l_3_4)
	l_0_0(l_3_0._position, l_3_3)
end


