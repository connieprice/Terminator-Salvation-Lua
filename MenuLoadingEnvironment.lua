require("LoadingEnvironmentBase.lua")
require("menu/loading_screen/MenuLoadingScreen")
if not MenuLoadingEnvironment then
	MenuLoadingEnvironment = {}
end
MenuLoadingEnvironment.fonts = function()
	return MenuLoadingScreen.fonts
end

MenuLoadingEnvironment.textures = function()
	return MenuLoadingScreen.textures
end

init = function()
	local l_3_0 = Scene:create_camera()
	l_3_0:set_width_multiplier(arg.camera_width_multiplier)
	LoadingViewport:set_camera(l_3_0)
	local l_3_1 = Scene:newgui()
	loading_screen = MenuLoadingScreen:new(resources, l_3_0, l_3_1, level_load_progress, arg.safe_rect, arg.workspace_size, arg.screen_size)
end

update = function(l_4_0, l_4_1)
	if NewLoadingEnvironment:flag("fade_down") and not loading_screen:is_fading_down() then
		print("****************** FADING DOWN LOADING SCREEN *************************")
		loading_screen:fade_down()
	end
	loading_screen:update(l_4_1)
	NewLoadingEnvironment:set_flag("fade_down_done", loading_screen:fade_down_done())
end


