require("LoadingEnvironmentBase.lua")
require("menu/loading_screen/MenuLoadingScreen")
MenuLoadingEnvironment = MenuLoadingEnvironment or {}
function MenuLoadingEnvironment.fonts()
	local L1_0
	L1_0 = MenuLoadingScreen
	L1_0 = L1_0.fonts
	return L1_0
end
function MenuLoadingEnvironment.textures()
	local L1_1
	L1_1 = MenuLoadingScreen
	L1_1 = L1_1.textures
	return L1_1
end
function init()
	local L0_2, L1_3
	L0_2 = Scene
	L1_3 = L0_2
	L0_2 = L0_2.create_camera
	L0_2 = L0_2(L1_3)
	L1_3 = L0_2.set_width_multiplier
	L1_3(L0_2, arg.camera_width_multiplier)
	L1_3 = LoadingViewport
	L1_3 = L1_3.set_camera
	L1_3(L1_3, L0_2)
	L1_3 = Scene
	L1_3 = L1_3.newgui
	L1_3 = L1_3(L1_3)
	loading_screen = MenuLoadingScreen:new(resources, L0_2, L1_3, level_load_progress, arg.safe_rect, arg.workspace_size, arg.screen_size)
end
function update(A0_4, A1_5)
	if NewLoadingEnvironment:flag("fade_down") and not loading_screen:is_fading_down() then
		print("****************** FADING DOWN LOADING SCREEN *************************")
		loading_screen:fade_down()
	end
	loading_screen:update(A1_5)
	NewLoadingEnvironment:set_flag("fade_down_done", loading_screen:fade_down_done())
end
