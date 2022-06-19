require("shared/camera/SharedCamera")
require("shared/Interpolator")
if not CoverHeightCamera then
	CoverHeightCamera = class(SharedCamera)
end
CoverHeightCamera.init = function(l_1_0, l_1_1)
	SharedCamera.init(l_1_0, l_1_1)
	l_1_0.interpolation_speed = 4
	l_1_0._target_fov = Interpolator:new(67, 4)
end

CoverHeightCamera.activate = function(l_2_0)
	if not l_2_0._target_offset then
		l_2_0._target_offset = Interpolator:new(0, l_2_0.interpolation_speed)
	end
	l_2_0._player_data = l_2_0._root_unit:player_data()
	l_2_0:switch_to_normal()
end

CoverHeightCamera.update = function(l_3_0, l_3_1, l_3_2, l_3_3)
	SharedCamera.update(l_3_0, l_3_1, l_3_2, l_3_3)
	local l_3_4 = l_3_0._player_data
	if not l_3_4.in_cover then
		local l_3_5, l_3_6, l_3_7, l_3_8, l_3_9, l_3_10, l_3_11 = l_3_4.entering_cover
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	if l_3_5 then
		l_3_0:switch_to_low_cover()
	else
		l_3_0:switch_to_normal()
	end
	l_3_0._target_fov:update(l_3_3)
	l_3_0.fov = l_3_0._target_fov:value()
	l_3_0._target_offset:update(l_3_3)
	l_3_0._target_offset:set_speed(4)
	local l_3_12 = nil
	l_3_0._unit:set_local_position(Vector3(0, 0, l_3_0._target_offset:value()))
end

CoverHeightCamera.switch_to_low_cover = function(l_4_0)
	l_4_0._target_offset:set_target(l_4_0.offset)
	l_4_0._target_fov:set_target(60)
end

CoverHeightCamera.switch_to_normal = function(l_5_0)
	l_5_0._target_offset:set_target(l_5_0.normal_offset)
	l_5_0._target_fov:set_target(67)
end


