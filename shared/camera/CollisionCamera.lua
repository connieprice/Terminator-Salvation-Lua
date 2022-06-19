require("shared/camera/SharedCamera")
if not CollisionCamera then
	CollisionCamera = class(SharedCamera)
end
CollisionCamera.init = function(l_1_0, l_1_1)
	SharedCamera.init(l_1_0, l_1_1)
	l_1_0._smooth_pop_controller = SmoothPopController()
	local l_1_2 = 2
	l_1_0._smooth_pop_controller:set_parameter("min_r", l_1_2)
	local l_1_3 = 0.2
	l_1_0._smooth_pop_controller:set_parameter("indent", l_1_3)
	l_1_0._player_down = false
end

CollisionCamera.update = function(l_2_0, l_2_1, l_2_2, l_2_3)
	SharedCamera.update(l_2_0, l_2_1, l_2_2, l_2_3)
	if not l_2_0._smooth_pop_controller then
		return 
	end
	l_2_0:_evil_player_is_down_hack(l_2_1)
	local l_2_4 = l_2_0._parent_unit:position()
	local l_2_5 = (l_2_0._root_unit:get_object("Head"))
	local l_2_6 = nil
	if not l_2_5 then
		l_2_6 = l_2_0._root_unit:orientation_object():position()
	else
		l_2_6 = l_2_0._root_unit:get_object("Head"):position()
	end
	local l_2_7 = 40
	local l_2_8 = l_2_6 + Vector3(0, 0, l_2_7)
	if l_2_0._player_down then
		l_2_4 = l_2_4:with_z(math.max(l_2_4.z, l_2_6.z))
	end
	local l_2_9 = l_2_0._smooth_pop_controller:wanted_position(l_2_6, l_2_4)
	local l_2_10 = l_2_6 - l_2_4:length()
	local l_2_11 = l_2_9 - l_2_4:length()
	local l_2_12 = l_2_11 / l_2_10
	cat_print("close:" .. l_2_12)
	local l_2_13 = l_2_8 - l_2_9
	local l_2_14 = l_2_13 * l_2_12
	if not l_2_0._player_down then
		local l_2_15, l_2_16 = l_2_9 + l_2_14
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	l_2_0:set_camera_position(l_2_15)
end

CollisionCamera._evil_player_is_down_hack = function(l_3_0, l_3_1)
	l_3_0._player_down = l_3_0._root_unit:player_data().is_down
	if l_3_0._player_down then
		local l_3_2 = 100
		l_3_0._smooth_pop_controller:set_parameter("min_r", l_3_2)
	else
		local l_3_3 = 2
		l_3_0._smooth_pop_controller:set_parameter("min_r", l_3_3)
	end
	local l_3_4 = 0.2
	l_3_0._smooth_pop_controller:set_parameter("indent", l_3_4)
end

CollisionCamera._debug_draw = function(l_4_0, l_4_1, l_4_2, l_4_3, l_4_4)
	local l_4_5 = Draw:brush()
	local l_4_6 = 10
	local l_4_7 = Color(0, 0, 1)
	l_4_5:set_color(l_4_7)
	l_4_5:sphere(l_4_2, l_4_6)
	local l_4_8 = Color(0, 1, 1)
	l_4_5:set_color(l_4_8)
	l_4_5:sphere(l_4_3, l_4_6)
	local l_4_9 = Color(1, 1, 1)
	l_4_5:set_color(l_4_9)
	l_4_5:line(l_4_1, l_4_4)
end


