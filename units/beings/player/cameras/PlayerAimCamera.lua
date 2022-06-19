require("shared/camera/SharedCamera")
require("shared/Angle")
require("shared/Interpolator")
if not PlayerAimCamera then
	PlayerAimCamera = class(SharedCamera)
end
PlayerAimCamera.init = function(l_1_0, l_1_1)
	SharedCamera.init(l_1_0, l_1_1)
end

PlayerAimCamera.update = function(l_2_0, l_2_1, l_2_2, l_2_3)
	if not l_2_0._camera_data.eye_target_position then
		return 
	end
	do
		local l_2_4 = l_2_0._unit:parent():get_object(l_2_0.link_object_name)
	end
	 -- WARNING: undefined locals caused missing assignments!
end

PlayerAimCamera._rotation_to_eye_target = function(l_3_0)
	local l_3_1 = l_3_0._unit:position()
	local l_3_2 = l_3_0._camera_data.eye_target_position
	local l_3_3 = l_3_0._camera_data.camera_position
	local l_3_4 = l_3_2 - l_3_1
	local l_3_5 = l_3_3 - l_3_1
	local l_3_6 = l_3_0._unit:rotation():x():dot(l_3_5)
	local l_3_7 = l_3_6 / l_3_4:length()
	return Rotation(l_3_4, math.UP) * Rotation(math.UP, 90 - math.acos(l_3_7))
end


