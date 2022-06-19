require("menu/2D/states/Menu2DState")
require("menu/menu_animations/Menu2DFadeInAnimation")
require("menu/menu_animations/Menu2DFadeOutAnimation")
Menu2DStateIngamePaused = Menu2DStateIngamePaused or class(Menu2DState)
function Menu2DStateIngamePaused.init(A0_0, A1_1)
	Menu2DState.init(A0_0, A1_1)
	managers.volume:deactivate_set("game_over")
	A0_0._state_data.menu.components.effects:fade_in_pause()
	A0_0._listener_camera = World:create_camera()
	A0_0._listener = Sound:add_listener(A0_0._listener_camera)
	A0_0._music_player = managers.music:new_player()
	A0_0._music_player:play_nice("menu")
	A0_0._full_screen_panel = managers.menu:ingame_gui():full_screen_panel()
	A0_0._background = A0_0._full_screen_panel:rect({
		x = 0,
		y = 0,
		color = Color.black:with_alpha(0.6)
	})
end
function Menu2DStateIngamePaused.update(A0_2, A1_3)
	if A0_2._background_animation and A0_2._background_animation:update(A1_3) == true then
		A0_2._background_animation = nil
	end
end
function Menu2DStateIngamePaused.exit(A0_4)
	Sound:remove_listener(A0_4._listener)
	World:delete_camera(A0_4._listener_camera)
	A0_4._full_screen_panel:remove(A0_4._background)
	A0_4._music_player:stop_now()
end
