require("menu/loading_screen/LevelLoadingScreen")
require("menu/loading_screen/MenuLoadingScreen")
LoadingScreenTest = LoadingScreenTest or class()
function LoadingScreenTest.init(A0_0, A1_1)
	local L2_2, L3_3, L4_4, L5_5, L6_6, L7_7, L8_8, L9_9, L10_10, L11_11
	L2_2 = World
	L2_2 = L2_2.find_units_quick
	L6_6 = L5_5
	L7_7 = "all"
	L11_11 = L5_5(L6_6, L7_7)
	L2_2 = L2_2(L3_3, L4_4, L5_5, L6_6, L7_7, L8_8, L9_9, L10_10, L11_11, L5_5(L6_6, L7_7))
	for L6_6, L7_7 in L3_3(L4_4) do
		L9_9 = L7_7
		L8_8 = L7_7.set_slot
		L10_10 = 0
		L8_8(L9_9, L10_10)
	end
	L6_6 = Vector3
	L7_7 = 0
	L8_8 = 0
	L9_9 = 0
	L6_6 = L6_6(L7_7, L8_8, L9_9)
	L7_7 = Rotation
	L8_8 = 0
	L9_9 = 0
	L10_10 = 0
	L11_11 = L7_7(L8_8, L9_9, L10_10)
	L6_6 = "pivot_low"
	L6_6 = L3_3
	L7_7 = "Point_high"
	L6_6 = {}
	L6_6.head = L3_3
	L6_6.low_pivot = L4_4
	L6_6.high_pivot = L5_5
	L7_7 = World
	L8_8 = L7_7
	L7_7 = L7_7.create_camera
	L7_7 = L7_7(L8_8)
	L8_8 = Application
	L9_9 = L8_8
	L8_8 = L8_8.create_scene_viewport
	L10_10 = 0
	L11_11 = 0
	L8_8 = L8_8(L9_9, L10_10, L11_11, 1, 1)
	A0_0._viewport = L8_8
	L8_8 = A0_0._viewport
	L9_9 = L8_8
	L8_8 = L8_8.set_camera
	L10_10 = L7_7
	L8_8(L9_9, L10_10)
	L8_8 = A0_0._viewport
	L9_9 = L8_8
	L8_8 = L8_8.set_active
	L10_10 = true
	L8_8(L9_9, L10_10)
	L8_8 = {
		L9_9,
		[4] = L10_10(L11_11, "move")
	}
	L9_9 = managers
	L9_9 = L9_9.menu
	L10_10 = L9_9
	L9_9 = L9_9._get_rotation_controller_info
	L11_11 = "look"
	L9_9 = L9_9(L10_10, L11_11)
	L10_10 = managers
	L10_10 = L10_10.menu
	L11_11 = L10_10
	L10_10 = L10_10._get_rotation_controller_info
	L11_11 = L10_10(L11_11, "move")
	;({
		L9_9,
		[4] = L10_10(L11_11, "move")
	})[2] = L10_10
	;({
		L9_9,
		[4] = L10_10(L11_11, "move")
	})[3] = L11_11
	L9_9 = tweak_data
	L10_10 = L9_9
	L9_9 = L9_9.safe_rect
	L9_9 = L9_9(L10_10)
	L10_10 = A0_0._viewport
	L11_11 = L10_10
	L10_10 = L10_10.set_environment
	L10_10(L11_11, "loading_screen")
	L10_10 = A0_0._viewport
	L11_11 = L10_10
	L10_10 = L10_10.set_dof
	L10_10(L11_11, loading_screen_tweak_data.DOF_AMOUNT, loading_screen_tweak_data.DOF_NEAR_MIN, loading_screen_tweak_data.DOF_NEAR_MAX, loading_screen_tweak_data.DOF_FAR_MIN, loading_screen_tweak_data.DOF_FAR_MAX)
	L10_10 = Overlay
	L11_11 = L10_10
	L10_10 = L10_10.newgui
	L10_10 = L10_10(L11_11)
	L11_11 = L10_10.create_screen_workspace
	L11_11 = L11_11(L10_10)
	A0_0._loading_screen = LevelLoadingScreen:new(L6_6, L7_7, L11_11, function()
		local L0_12, L1_13
		L0_12 = 0
		return L0_12
	end, L8_8, L9_9)
end
function LoadingScreenTest.destroy(A0_14)
	A0_14._loading_screen:destroy()
end
function LoadingScreenTest.stop(A0_15)
	A0_15._loading_screen:fade_down()
end
function LoadingScreenTest.fade_down_done(A0_16)
	return A0_16._loading_screen:fade_down_done()
end
function LoadingScreenTest.update(A0_17, A1_18)
	managers.viewport:set_active_vp(A0_17._viewport)
	A0_17._loading_screen:update(A1_18)
end
