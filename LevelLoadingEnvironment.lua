require("LoadingEnvironmentBase.lua")
require("menu/loading_screen/LevelLoadingScreen")
if not LevelLoadingEnvironment then
	LevelLoadingEnvironment = {}
end
LevelLoadingEnvironment.fonts = function()
	return LevelLoadingScreen.fonts
end

LevelLoadingEnvironment.textures = function()
	return LevelLoadingScreen.textures
end

init = function()
	if Scene:has_animation("animation") then
		Scene:play("animation", 1)
	end
	Sound:set_volume("menu", arg.volume)
	local l_3_0 = {}
	l_3_0.head = Scene:get_object("rph")
	l_3_0.low_pivot = Scene:get_object("pivot_low")
	l_3_0.high_pivot = Scene:get_object("Point_high")
	local l_3_1 = Scene:create_camera()
	l_3_1:set_width_multiplier(arg.camera_width_multiplier)
	LoadingViewport:set_camera(l_3_1)
	local l_3_2 = Scene:newgui()
	loading_screen = LevelLoadingScreen:new(l_3_0, l_3_1, l_3_2, level_load_progress, arg.rotation_controllers, arg.safe_rect, arg.workspace_size, arg.screen_size)
end

update = function(l_4_0, l_4_1)
	if NewLoadingEnvironment:flag("fade_down") and not loading_screen:is_fading_down() then
		loading_screen:fade_down()
	end
	loading_screen:update(l_4_1)
	NewLoadingEnvironment:set_flag("fade_down_done", loading_screen:fade_down_done())
end


