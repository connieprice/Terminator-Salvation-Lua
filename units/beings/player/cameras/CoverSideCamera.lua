require("shared/camera/SharedCamera")
require("shared/Interpolator")
if not CoverSideCamera then
	CoverSideCamera = class(SharedCamera)
end
CoverSideCamera.init = function(l_1_0, l_1_1)
	SharedCamera.init(l_1_0, l_1_1)
	l_1_0.interpolation_speed = 1
end

CoverSideCamera.activate = function(l_2_0)
	if not l_2_0._target_offset then
		l_2_0._target_offset = Interpolator:new(0, l_2_0.interpolation_speed)
	end
	l_2_0._player_data = l_2_0._root_unit:player_data()
	l_2_0._peek_offset = 0
	l_2_0:switch_to_right()
end

CoverSideCamera.update = function(l_3_0, l_3_1, l_3_2, l_3_3)
	SharedCamera.update(l_3_0, l_3_1, l_3_2, l_3_3)
	local l_3_4 = l_3_0._player_data
	if (((((l_3_4.in_cover and not l_3_4.facing_right_in_cover) or (not l_3_4.entering_cover or not l_3_4.entering_cover_facing_left) and (not l_3_4.moving_to_cover or not l_3_4.moving_to_cover_facing_left) and (not l_3_4.diving_to_cover or not l_3_4.diving_to_cover_facing_left) and (not l_3_4.sliding_to_cover or not l_3_4.sliding_to_cover_facing_left) and l_3_4.entering_cover_from_slide)))) then
		local l_3_5 = l_3_4.entering_cover_from_slide_facing_left
	end
	l_3_5 = l_3_5
	do
		local l_3_6, l_3_7, l_3_8 = nil
	end
	if l_3_4.peeking_left or l_3_4.peeking_right then
		l_3_0._peek_offset = 50
	else
		l_3_0._peek_offset = 0
	end
	if l_3_5 then
		l_3_0:switch_to_left()
	else
		l_3_0:switch_to_right()
	end
	local l_3_9 = l_3_4.peekin
	l_3_0._target_offset:update(l_3_3)
	l_3_0._target_offset:set_speed(2)
	local l_3_10 = Vector3(l_3_0._target_offset:value(), 0, 0)
	l_3_0._unit:set_local_position(l_3_10)
end

CoverSideCamera.switch_to_right = function(l_4_0)
	l_4_0._target_offset:set_target(l_4_0.right_offset + l_4_0._peek_offset)
end

CoverSideCamera.switch_to_left = function(l_5_0)
	l_5_0._target_offset:set_target(-l_5_0.left_offset - l_5_0._peek_offset)
end


