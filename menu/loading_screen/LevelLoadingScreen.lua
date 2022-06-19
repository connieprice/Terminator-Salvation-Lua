require("menu/loading_screen/LoadingScreen")
require("menu/loading_screen/PhysicsModifier")
require("menu/loading_screen/LoadingCameraNoise")
LevelLoadingScreen = LevelLoadingScreen or class(LoadingScreen)
LevelLoadingScreen.fonts = {
	"faith_font_22"
}
LevelLoadingScreen.textures = {
	"gui_disc_icon",
	"security_camera_noise_1",
	"security_camera_noise_2",
	"security_camera_noise_3",
	"security_camera_noise_4",
	"security_camera_edgebleed"
}
function LevelLoadingScreen.init(A0_0, A1_1, A2_2, A3_3, A4_4, A5_5, A6_6, A7_7, A8_8)
	A0_0._height_modifier = PhysicsModifier:new(loading_screen_tweak_data.INITIAL_HEIGHT)
	A0_0._yaw_modifier = PhysicsModifier:new(loading_screen_tweak_data.INITIAL_YAW)
	A0_0._rotation_controllers = {}
	A0_0:_setup_rotation_controllers(A5_5)
	A0_0._time_since_input = 9999
	A0_0._yaw_idle_time = 0
	A0_0._height_idle_time = 0
	A0_0._time = 0
	LoadingScreen.init(A0_0, A1_1, A2_2, A3_3, A4_4, A6_6, A7_7, A8_8)
	A0_0._camera_noise = LoadingCameraNoise:new(A0_0._panel, loading_screen_tweak_data.CAMERA_NOISE_ALPHA)
end
function LevelLoadingScreen.start(A0_9)
	A0_9._sound = Sound:make_bank("ui_menu_sound", "loading_screen_loop")
	A0_9._sound_instance = A0_9._sound:play()
	A0_9._sound_instance:set_control_ramp("gain_abs", 0, 1, 1)
	LoadingScreen.start(A0_9)
end
function LevelLoadingScreen.update(A0_10, A1_11)
	LoadingScreen.update(A0_10, A1_11)
	A0_10._time = A0_10._time + A1_11
	A0_10._camera_noise:update(A1_11)
	A0_10:update_camera(A1_11)
end
function LevelLoadingScreen.fade_down(A0_12)
	LoadingScreen.fade_down(A0_12)
	A0_12._sound_instance:set_control_ramp("gain_abs", 1, 0, 1)
end
function LevelLoadingScreen.update_camera(A0_13, A1_14)
	local L2_15, L3_16, L4_17, L5_18, L6_19, L7_20, L8_21, L9_22, L10_23, L11_24, L12_25
	L3_16 = A0_13
	L2_15 = A0_13._rotation_input
	L2_15 = L2_15(L3_16)
	L3_16 = Vector3
	L4_17 = math
	L4_17 = L4_17.clamp
	L5_18 = L2_15.x
	L6_19 = -1
	L7_20 = 1
	L4_17 = L4_17(L5_18, L6_19, L7_20)
	L5_18 = math
	L5_18 = L5_18.clamp
	L6_19 = L2_15.y
	L7_20 = -1
	L8_21 = 1
	L5_18 = L5_18(L6_19, L7_20, L8_21)
	L6_19 = 0
	L3_16 = L3_16(L4_17, L5_18, L6_19)
	L2_15 = L3_16
	L3_16, L4_17 = nil, nil
	L5_18 = math
	L5_18 = L5_18.abs
	L6_19 = L2_15.x
	L5_18 = L5_18(L6_19)
	L6_19 = loading_screen_tweak_data
	L6_19 = L6_19.INPUT_IDLE_THRESHOLD
	if L5_18 < L6_19 then
		L5_18 = math
		L5_18 = L5_18.abs
		L6_19 = L2_15.y
		L5_18 = L5_18(L6_19)
		L6_19 = loading_screen_tweak_data
		L6_19 = L6_19.INPUT_IDLE_THRESHOLD
		if L5_18 < L6_19 then
			L5_18 = A0_13._time_since_input
			L5_18 = L5_18 + A1_14
			A0_13._time_since_input = L5_18
		end
	else
		A0_13._time_since_input = 0
	end
	L5_18 = A0_13._time_since_input
	L6_19 = loading_screen_tweak_data
	L6_19 = L6_19.INPUT_IDLE_TIMEOUT
	if L5_18 > L6_19 then
		L6_19 = A0_13
		L5_18 = A0_13._idle_movement
		L7_20 = A1_14
		L6_19 = L5_18(L6_19, L7_20)
		L4_17 = L6_19
		L3_16 = L5_18
	else
		L5_18 = L2_15.x
		L6_19 = loading_screen_tweak_data
		L6_19 = L6_19.YAW_ACCELERATION
		L3_16 = L5_18 * L6_19
		L5_18 = L2_15.y
		L6_19 = loading_screen_tweak_data
		L6_19 = L6_19.HEIGHT_ACCELERATION
		L4_17 = L5_18 * L6_19
	end
	L5_18 = A0_13._yaw_modifier
	L6_19 = L5_18
	L5_18 = L5_18.set_acceleration
	L7_20 = L3_16
	L5_18(L6_19, L7_20)
	L5_18 = A0_13._yaw_modifier
	L6_19 = L5_18
	L5_18 = L5_18.set_velocity_limit
	L7_20 = loading_screen_tweak_data
	L7_20 = L7_20.YAW_MAX_VELOCITY
	L5_18(L6_19, L7_20)
	L5_18 = A0_13._yaw_modifier
	L6_19 = L5_18
	L5_18 = L5_18.set_damper
	L7_20 = loading_screen_tweak_data
	L7_20 = L7_20.YAW_DAMPING_CONSTANT
	L8_21 = loading_screen_tweak_data
	L8_21 = L8_21.YAW_SPRING_DAMPING_CONSTANT
	L5_18(L6_19, L7_20, L8_21)
	L5_18 = A0_13._yaw_modifier
	L6_19 = L5_18
	L5_18 = L5_18.set_spring
	L7_20 = loading_screen_tweak_data
	L7_20 = L7_20.YAW_SPRING_LENGTH
	L8_21 = 0
	L9_22 = loading_screen_tweak_data
	L9_22 = L9_22.YAW_SPRING_CONSTANT
	L5_18(L6_19, L7_20, L8_21, L9_22)
	L5_18 = A0_13._height_modifier
	L6_19 = L5_18
	L5_18 = L5_18.set_acceleration
	L7_20 = L4_17
	L5_18(L6_19, L7_20)
	L5_18 = A0_13._height_modifier
	L6_19 = L5_18
	L5_18 = L5_18.set_velocity_limit
	L7_20 = loading_screen_tweak_data
	L7_20 = L7_20.HEIGHT_MAX_VELOCITY
	L5_18(L6_19, L7_20)
	L5_18 = A0_13._height_modifier
	L6_19 = L5_18
	L5_18 = L5_18.set_damper
	L7_20 = loading_screen_tweak_data
	L7_20 = L7_20.HEIGHT_DAMPING_CONSTANT
	L8_21 = loading_screen_tweak_data
	L8_21 = L8_21.HEIGHT_SPRING_DAMPING_CONSTANT
	L5_18(L6_19, L7_20, L8_21)
	L5_18 = A0_13._height_modifier
	L6_19 = L5_18
	L5_18 = L5_18.set_spring
	L7_20 = loading_screen_tweak_data
	L7_20 = L7_20.HEIGHT_SPRING_LENGTH
	L8_21 = 0
	L9_22 = loading_screen_tweak_data
	L9_22 = L9_22.HEIGHT_SPRING_CONSTANT
	L5_18(L6_19, L7_20, L8_21, L9_22)
	L5_18 = A0_13._height_modifier
	L6_19 = L5_18
	L5_18 = L5_18.update
	L7_20 = A1_14
	L5_18(L6_19, L7_20)
	L5_18 = A0_13._yaw_modifier
	L6_19 = L5_18
	L5_18 = L5_18.update
	L7_20 = A1_14
	L5_18(L6_19, L7_20)
	L5_18 = loading_screen_tweak_data
	L5_18 = L5_18.ROLL_FACTOR
	L6_19 = A0_13._height_modifier
	L7_20 = L6_19
	L6_19 = L6_19.value
	L6_19 = L6_19(L7_20)
	L5_18 = L5_18 * L6_19
	L6_19 = A0_13._yaw_modifier
	L7_20 = L6_19
	L6_19 = L6_19.value
	L6_19 = L6_19(L7_20)
	L5_18 = L5_18 * L6_19
	L6_19 = loading_screen_tweak_data
	L6_19 = L6_19.PITCH_DRAG_FACTOR
	L7_20 = A0_13._height_modifier
	L7_20 = L7_20._velocity
	L6_19 = L6_19 * L7_20
	L8_21 = A0_13
	L7_20 = A0_13._calculate_camera_movement
	L9_22 = A1_14
	L7_20 = L7_20(L8_21, L9_22)
	L9_22 = A0_13
	L8_21 = A0_13._calculate_positions
	L10_23 = L7_20.height
	L9_22 = L8_21(L9_22, L10_23)
	L10_23 = Rotation
	L11_24 = L6_19
	L12_25 = L7_20.yaw
	L10_23 = L10_23(L11_24, L12_25, L5_18)
	L11_24 = Vector3
	L12_25 = 0
	L11_24 = L11_24(L12_25, 0, loading_screen_tweak_data.CAMERA_DISTANCE)
	L12_25 = L11_24.rotate_with
	L12_25 = L12_25(L11_24, L10_23)
	L12_25 = L8_21 + L12_25
	A0_13._camera:set_position(L12_25)
	A0_13._rotation = Rotation:look_at(L12_25, L9_22, Vector3(0, 1, 0))
	A0_13._camera:new_set_rotation(A0_13._rotation)
	A0_13._camera:set_fov(loading_screen_tweak_data.CAMERA_FOV)
end
function LevelLoadingScreen._calculate_camera_movement(A0_26, A1_27)
	local L2_28
	L2_28 = {}
	L2_28.height = A0_26._height_modifier:value()
	L2_28.yaw = A0_26._yaw_modifier:value()
	return L2_28
end
function LevelLoadingScreen._idle_movement(A0_29, A1_30)
	local L2_31, L3_32, L4_33, L5_34
	L2_31 = A0_29._yaw_idle_time
	L2_31 = L2_31 + A1_30
	A0_29._yaw_idle_time = L2_31
	L2_31 = A0_29._height_idle_time
	L2_31 = L2_31 + A1_30
	A0_29._height_idle_time = L2_31
	L2_31 = loading_screen_tweak_data
	L2_31 = L2_31.IDLE_YAW_ACCELERATION
	L3_32 = loading_screen_tweak_data
	L3_32 = L3_32.IDLE_HEIGHT_ACCELERATION
	L4_33 = A0_29._yaw_idle_time
	L5_34 = loading_screen_tweak_data
	L5_34 = L5_34.IDLE_HEIGHT_LOOP_TIME
	L5_34 = 0.5 * L5_34
	if L4_33 > L5_34 then
		L2_31 = -L2_31
		L4_33 = A0_29._yaw_idle_time
		L5_34 = loading_screen_tweak_data
		L5_34 = L5_34.IDLE_HEIGHT_LOOP_TIME
		if L4_33 > L5_34 then
			A0_29._yaw_idle_time = 0
		end
	end
	L4_33 = A0_29._height_idle_time
	L5_34 = loading_screen_tweak_data
	L5_34 = L5_34.IDLE_YAW_LOOP_TIME
	L5_34 = 0.5 * L5_34
	if L4_33 > L5_34 then
		L3_32 = -L3_32
		L4_33 = A0_29._height_idle_time
		L5_34 = loading_screen_tweak_data
		L5_34 = L5_34.IDLE_YAW_LOOP_TIME
		if L4_33 > L5_34 then
			A0_29._height_idle_time = 0
		end
	end
	L4_33 = L2_31
	L5_34 = L3_32
	return L4_33, L5_34
end
function LevelLoadingScreen._calculate_positions(A0_35, A1_36)
	local L2_37
	L2_37 = loading_screen_tweak_data
	L2_37 = L2_37.HEIGHT_SPRING_LENGTH
	L2_37 = A1_36 + L2_37
	L2_37 = L2_37 / (2 * loading_screen_tweak_data.HEIGHT_SPRING_LENGTH)
	return A0_35._resources.low_pivot:position() + Vector3(0, loading_screen_tweak_data.LOW_CAMERA_OFFSET, 0) + L2_37 * (A0_35._resources.high_pivot:position() + Vector3(0, loading_screen_tweak_data.HIGH_CAMERA_OFFSET, 0) - (A0_35._resources.low_pivot:position() + Vector3(0, loading_screen_tweak_data.LOW_CAMERA_OFFSET, 0))), A0_35._resources.low_pivot:position() + Vector3(0, loading_screen_tweak_data.LOW_PIVOT_OFFSET, 0) + L2_37 * (A0_35._resources.high_pivot:position() + Vector3(0, loading_screen_tweak_data.HIGH_PIVOT_OFFSET, 0) - (A0_35._resources.low_pivot:position() + Vector3(0, loading_screen_tweak_data.LOW_PIVOT_OFFSET, 0)))
end
function LevelLoadingScreen._setup_rotation_controllers(A0_38, A1_39)
	for 