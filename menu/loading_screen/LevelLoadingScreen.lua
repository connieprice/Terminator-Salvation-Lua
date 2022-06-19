require("menu/loading_screen/LoadingScreen")
require("menu/loading_screen/PhysicsModifier")
require("menu/loading_screen/LoadingCameraNoise")
if not LevelLoadingScreen then
	LevelLoadingScreen = class(LoadingScreen)
end
local l_0_0 = LevelLoadingScreen
local l_0_1 = {}
 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

 -- DECOMPILER ERROR: Overwrote pending register.

l_0_0.textures, l_0_1 = l_0_1, {"faith_font_22", "security_camera_noise_1", "security_camera_noise_2", "security_camera_noise_3", "security_camera_noise_4", "security_camera_edgebleed"}
 -- DECOMPILER ERROR: Overwrote pending register.

l_0_1 = function(l_1_0, l_1_1, l_1_2, l_1_3, l_1_4, l_1_5, l_1_6, l_1_7, l_1_8)
	l_1_0._height_modifier = PhysicsModifier:new(loading_screen_tweak_data.INITIAL_HEIGHT)
	l_1_0._yaw_modifier = PhysicsModifier:new(loading_screen_tweak_data.INITIAL_YAW)
	l_1_0._rotation_controllers = {}
	l_1_0:_setup_rotation_controllers(l_1_5)
	l_1_0._time_since_input = 9999
	l_1_0._yaw_idle_time = 0
	l_1_0._height_idle_time = 0
	l_1_0._time = 0
	LoadingScreen.init(l_1_0, l_1_1, l_1_2, l_1_3, l_1_4, l_1_6, l_1_7, l_1_8)
	l_1_0._camera_noise = LoadingCameraNoise:new(l_1_0._panel, loading_screen_tweak_data.CAMERA_NOISE_ALPHA)
end

l_0_0.init = l_0_1
 -- DECOMPILER ERROR: Overwrote pending register.

l_0_1 = function(l_2_0)
	l_2_0._sound = Sound:make_bank("ui_menu_sound", "loading_screen_loop")
	l_2_0._sound_instance = l_2_0._sound:play()
	l_2_0._sound_instance:set_control_ramp("gain_abs", 0, 1, 1)
	LoadingScreen.start(l_2_0)
end

l_0_0.start = l_0_1
 -- DECOMPILER ERROR: Overwrote pending register.

l_0_1 = function(l_3_0, l_3_1)
	LoadingScreen.update(l_3_0, l_3_1)
	l_3_0._time = l_3_0._time + l_3_1
	l_3_0._camera_noise:update(l_3_1)
	l_3_0:update_camera(l_3_1)
end

l_0_0.update = l_0_1
 -- DECOMPILER ERROR: Overwrote pending register.

l_0_1 = function(l_4_0)
	LoadingScreen.fade_down(l_4_0)
	l_4_0._sound_instance:set_control_ramp("gain_abs", 1, 0, 1)
end

l_0_0.fade_down = l_0_1
 -- DECOMPILER ERROR: Overwrote pending register.

l_0_1 = function(l_5_0, l_5_1)
	local l_5_2 = l_5_0:_rotation_input()
	l_5_2 = Vector3(math.clamp(l_5_2.x, -1, 1), math.clamp(l_5_2.y, -1, 1), 0)
	local l_5_3, l_5_4 = nil, nil
	if math.abs(l_5_2.x) < loading_screen_tweak_data.INPUT_IDLE_THRESHOLD and math.abs(l_5_2.y) < loading_screen_tweak_data.INPUT_IDLE_THRESHOLD then
		l_5_0._time_since_input = l_5_0._time_since_input + l_5_1
	else
		l_5_0._time_since_input = 0
	end
	if loading_screen_tweak_data.INPUT_IDLE_TIMEOUT < l_5_0._time_since_input then
		l_5_3 = l_5_0:_idle_movement(l_5_1)
	else
		l_5_3 = l_5_2.x * loading_screen_tweak_data.YAW_ACCELERATION
		 -- DECOMPILER ERROR: Overwrote pending register.

	end
	l_5_0._yaw_modifier:set_acceleration(l_5_3)
	l_5_0._yaw_modifier:set_velocity_limit(loading_screen_tweak_data.YAW_MAX_VELOCITY)
	l_5_0._yaw_modifier:set_damper(loading_screen_tweak_data.YAW_DAMPING_CONSTANT, loading_screen_tweak_data.YAW_SPRING_DAMPING_CONSTANT)
	l_5_0._yaw_modifier:set_spring(loading_screen_tweak_data.YAW_SPRING_LENGTH, 0, loading_screen_tweak_data.YAW_SPRING_CONSTANT)
	l_5_0._height_modifier:set_acceleration(l_5_4)
	l_5_0._height_modifier:set_velocity_limit(loading_screen_tweak_data.HEIGHT_MAX_VELOCITY)
	l_5_0._height_modifier:set_damper(loading_screen_tweak_data.HEIGHT_DAMPING_CONSTANT, loading_screen_tweak_data.HEIGHT_SPRING_DAMPING_CONSTANT)
	l_5_0._height_modifier:set_spring(loading_screen_tweak_data.HEIGHT_SPRING_LENGTH, 0, loading_screen_tweak_data.HEIGHT_SPRING_CONSTANT)
	l_5_0._height_modifier:update(l_5_1)
	l_5_0._yaw_modifier:update(l_5_1)
	local l_5_5 = loading_screen_tweak_data.ROLL_FACTOR * l_5_0._height_modifier:value() * l_5_0._yaw_modifier:value()
	local l_5_6 = loading_screen_tweak_data.PITCH_DRAG_FACTOR * l_5_0._height_modifier._velocity
	local l_5_7 = l_5_0:_calculate_camera_movement(l_5_1)
	local l_5_8, l_5_9 = l_5_0:_calculate_positions(l_5_7.height)
	local l_5_10 = Rotation(l_5_6, l_5_7.yaw, l_5_5)
	local l_5_11 = Vector3(0, 0, loading_screen_tweak_data.CAMERA_DISTANCE)
	local l_5_12 = l_5_8 + l_5_11:rotate_with(l_5_10)
	l_5_0._camera:set_position(l_5_12)
	l_5_0._rotation = Rotation:look_at(l_5_12, l_5_9, Vector3(0, 1, 0))
	l_5_0._camera:new_set_rotation(l_5_0._rotation)
	l_5_0._camera:set_fov(loading_screen_tweak_data.CAMERA_FOV)
end

l_0_0.update_camera = l_0_1
 -- DECOMPILER ERROR: Overwrote pending register.

l_0_1 = function(l_6_0, l_6_1)
	local l_6_2 = {}
	l_6_2.height = l_6_0._height_modifier:value()
	l_6_2.yaw = l_6_0._yaw_modifier:value()
	return l_6_2
end

l_0_0._calculate_camera_movement = l_0_1
 -- DECOMPILER ERROR: Overwrote pending register.

l_0_1 = function(l_7_0, l_7_1)
	l_7_0._yaw_idle_time = l_7_0._yaw_idle_time + l_7_1
	l_7_0._height_idle_time = l_7_0._height_idle_time + l_7_1
	if 0.5 * loading_screen_tweak_data.IDLE_HEIGHT_LOOP_TIME < l_7_0._yaw_idle_time then
		local l_7_2, l_7_3 = -loading_screen_tweak_data.IDLE_YAW_ACCELERATION, loading_screen_tweak_data.IDLE_HEIGHT_ACCELERATION
	if loading_screen_tweak_data.IDLE_HEIGHT_LOOP_TIME < l_7_0._yaw_idle_time then
		end
		l_7_0._yaw_idle_time = 0
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	if 0.5 * loading_screen_tweak_data.IDLE_YAW_LOOP_TIME < l_7_0._height_idle_time then
		local l_7_4 = nil
	if loading_screen_tweak_data.IDLE_YAW_LOOP_TIME < l_7_0._height_idle_time then
		end
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	return l_7_4, -l_7_3
end

l_0_0._idle_movement = l_0_1
 -- DECOMPILER ERROR: Overwrote pending register.

l_0_1 = function(l_8_0, l_8_1)
	local l_8_2 = (l_8_1 + loading_screen_tweak_data.HEIGHT_SPRING_LENGTH) / (2 * loading_screen_tweak_data.HEIGHT_SPRING_LENGTH)
	local l_8_3 = l_8_0._resources.high_pivot:position() + Vector3(0, loading_screen_tweak_data.HIGH_CAMERA_OFFSET, 0)
	local l_8_4 = l_8_0._resources.low_pivot:position() + Vector3(0, loading_screen_tweak_data.LOW_CAMERA_OFFSET, 0)
	local l_8_5 = l_8_0._resources.high_pivot:position() + Vector3(0, loading_screen_tweak_data.HIGH_PIVOT_OFFSET, 0)
	local l_8_6 = l_8_0._resources.low_pivot:position() + Vector3(0, loading_screen_tweak_data.LOW_PIVOT_OFFSET, 0)
	return l_8_4 + l_8_2 * (l_8_3 - l_8_4), l_8_6 + l_8_2 * (l_8_5 - l_8_6)
end

l_0_0._calculate_positions = l_0_1
 -- DECOMPILER ERROR: Overwrote pending register.

l_0_1 = function(l_9_0, l_9_1)
	local l_9_5, l_9_6, l_9_7, l_9_8, l_9_9, l_9_10, l_9_11, l_9_12 = nil
	for i_0,i_1 in ipairs(l_9_1) do
		l_9_0:_setup_rotation_controller_by_controller_index(i_1.index, i_1.input_names, i_1.options)
	end
end

l_0_0._setup_rotation_controllers = l_0_1
 -- DECOMPILER ERROR: Overwrote pending register.

l_0_1 = function(l_10_0, l_10_1, l_10_2, l_10_3)
	if not l_10_1 then
		return 
	end
	local l_10_4 = Input:controller(l_10_1)
	if l_10_4 then
		local l_10_5 = {}
		l_10_5.controller = l_10_4
		l_10_5.controller_input_names = l_10_2
		l_10_5.options = l_10_3
		table.insert(l_10_0._rotation_controllers, l_10_5)
	end
end

l_0_0._setup_rotation_controller_by_controller_index = l_0_1
 -- DECOMPILER ERROR: Overwrote pending register.

l_0_1 = function(l_11_0)
	local l_11_4, l_11_5, l_11_6, l_11_7, l_11_8, l_11_9, l_11_13, l_11_14, l_11_15, l_11_16, l_11_19, l_11_23, l_11_24 = nil
	for i_0,i_1 in ipairs(l_11_0._rotation_controllers) do
		for l_11_20,l_11_21 in pairs(i_1.controller_input_names) do
			 -- DECOMPILER ERROR: Confused about usage of registers!

			local l_11_25 = l_11_11.controller:axis(l_11_16)
			if l_11_11.options.invert_y then
				local l_11_28 = Vector3
				local l_11_29 = l_11_25.x
				l_11_28 = l_11_28(l_11_29, -l_11_25.y, l_11_25.z)
				l_11_25 = l_11_28
			end
			local l_11_27 = l_11_25:length
			l_11_27 = l_11_27(l_11_25)
			local l_11_26 = nil
			if l_11_27 > 0.01 then
				return l_11_25
			end
		end
	end
	do
		local l_11_18 = 0
		return Vector3(0, 0, l_11_18)
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

l_0_0._rotation_input = l_0_1

