require("LoadingEnvironmentBase.lua")
require("menu/loading_screen/LevelLoadingScreen")
LevelLoadingEnvironment = LevelLoadingEnvironment or {}
function LevelLoadingEnvironment.fonts()
	local L1_0
	L1_0 = LevelLoadingScreen
	L1_0 = L1_0.fonts
	return L1_0
end
function LevelLoadingEnvironment.textures()
	local L1_1
	L1_1 = LevelLoadingScreen
	L1_1 = L1_1.textures
	return L1_1
end
function init()
	local L0_2, L1_3, L2_4
	L0_2 = Scene
	L1_3 = L0_2
	L0_2 = L0_2.has_animation
	L2_4 = "animation"
	L0_2 = L0_2(L1_3, L2_4)
	if L0_2 then
		L0_2 = Scene
		L1_3 = L0_2
		L0_2 = L0_2.play
		L2_4 = "animation"
		L0_2(L1_3, L2_4, 1)
	end
	L0_2 = Sound
	L1_3 = L0_2
	L0_2 = L0_2.set_volume
	L2_4 = "menu"
	L0_2(L1_3, L2_4, arg.volume)
	L0_2 = {}
	L1_3 = Scene
	L2_4 = L1_3
	L1_3 = L1_3.get_object
	L1_3 = L1_3(L2_4, "rph")
	L0_2.head = L1_3
	L1_3 = Scene
	L2_4 = L1_3
	L1_3 = L1_3.get_object
	L1_3 = L1_3(L2_4, "pivot_low")
	L0_2.low_pivot = L1_3
	L1_3 = Scene
	L2_4 = L1_3
	L1_3 = L1_3.get_object
	L1_3 = L1_3(L2_4, "Point_high")
	L0_2.high_pivot = L1_3
	L1_3 = Scene
	L2_4 = L1_3
	L1_3 = L1_3.create_camera
	L1_3 = L1_3(L2_4)
	L2_4 = L1_3.set_width_multiplier
	L2_4(L1_3, arg.camera_width_multiplier)
	L2_4 = LoadingViewport
	L2_4 = L2_4.set_camera
	L2_4(L2_4, L1_3)
	L2_4 = Scene
	L2_4 = L2_4.newgui
	L2_4 = L2_4(L2_4)
	loading_screen = LevelLoadingScreen:new(L0_2, L1_3, L2_4, level_load_progress, arg.rotation_controllers, arg.safe_rect, arg.workspace_size, arg.screen_size)
end
function update(A0_5, A1_6)
	if NewLoadingEnvironment:flag("fade_down") and not loading_screen:is_fading_down() then
		loading_screen:fade_down()
	end
	loading_screen:update(A1_6)
	NewLoadingEnvironment:set_flag("fade_down_done", loading_screen:fade_down_done())
end
