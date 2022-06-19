require("menu/2D/states/Menu2DState")
require("menu/menu_animations/Menu2DFadeInAnimation")
require("menu/menu_animations/Menu2DFadeOutAnimation")
if not Menu2DStateIngamePaused then
	Menu2DStateIngamePaused = class(Menu2DState)
end
Menu2DStateIngamePaused.init = function(l_1_0, l_1_1)
	Menu2DState.init(l_1_0, l_1_1)
	managers.volume:deactivate_set("game_over")
	l_1_0._state_data.menu.components.effects:fade_in_pause()
	l_1_0._listener_camera = World:create_camera()
	l_1_0._listener = Sound:add_listener(l_1_0._listener_camera)
	l_1_0._music_player = managers.music:new_player()
	l_1_0._music_player:play_nice("menu")
	l_1_0._full_screen_panel = managers.menu:ingame_gui():full_screen_panel()
	local l_1_2, l_1_3 = l_1_0._full_screen_panel:rect, l_1_0._full_screen_panel
	local l_1_4 = {}
	l_1_4.x = 0
	l_1_4.y = 0
	l_1_4.color = Color.black:with_alpha(0.6)
	l_1_2 = l_1_2(l_1_3, l_1_4)
	l_1_0._background = l_1_2
end

Menu2DStateIngamePaused.update = function(l_2_0, l_2_1)
	if l_2_0._background_animation and l_2_0._background_animation:update(l_2_1) == true then
		l_2_0._background_animation = nil
	end
end

Menu2DStateIngamePaused.exit = function(l_3_0)
	Sound:remove_listener(l_3_0._listener)
	World:delete_camera(l_3_0._listener_camera)
	l_3_0._full_screen_panel:remove(l_3_0._background)
	l_3_0._music_player:stop_now()
end


