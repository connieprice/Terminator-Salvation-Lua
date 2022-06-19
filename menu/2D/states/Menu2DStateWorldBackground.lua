require("menu/2D/states/Menu2DState")
require("shared/FiniteStateMachine")
require("menu/2D/Menu2DCamera")
require("menu/2D/states/Menu2DStateStartup")
require("menu/2D/states/Menu2DStateMainMenuPages")
require("menu/2D/states/Menu2DStateCredits")
require("menu/2D/states/Menu2DStateEndSyncToFrontend")
Menu2DStateWorldBackground = Menu2DStateWorldBackground or class(Menu2DState)
Menu2DStateWorldBackground.PRELOAD_TEXTURES = {
	"security_camera_edgebleed",
	"gui_menu_distortion_01",
	"gui_menu_distortion_02",
	"gui_menu_distortion_03",
	"gui_menu_distortion_04",
	"gui_menu_normal_distortion",
	"gui_saving_icon",
	"gui_saving_hilight"
}
Menu2DStateWorldBackground.transitions = {
	{
		state_transitions = Menu2DStateStartup.transitions,
		state = Menu2DStateStartup
	},
	{
		state_transitions = Menu2DStateMainMenuPages.transitions,
		state = Menu2DStateMainMenuPages
	},
	{
		state_transition = "end_sync_to_frontend",
		state = Menu2DStateEndSyncToFrontend
	},
	{state_transition = "credits", state = Menu2DStateCredits}
}
function Menu2DStateWorldBackground.init(A0_0)
	local L1_1, L2_2, L3_3
	L1_1 = Menu2DState
	L1_1 = L1_1.init
	L2_2 = A0_0
	L3_3 = Menu2DStateWorldBackground
	L1_1(L2_2, L3_3)
	L1_1 = A0_0._state_data
	L1_1 = L1_1.menu
	L1_1 = L1_1.state_flags
	L1_1.frontend = true
	L2_2 = A0_0
	L1_1 = A0_0._preload_title
	L1_1(L2_2)
	L2_2 = A0_0
	L1_1 = A0_0._load
	L1_1(L2_2)
	L1_1 = Menu2DCamera
	L2_2 = L1_1
	L1_1 = L1_1.new
	L1_1 = L1_1(L2_2)
	A0_0._camera = L1_1
	L1_1 = {}
	L2_2 = A0_0._state_data
	L2_2 = L2_2.menu
	L1_1.menu = L2_2
	L2_2 = A0_0.transitions
	L1_1.state_transitions = L2_2
	L2_2 = A0_0._state_data
	L2_2 = L2_2.menu
	L2_2 = L2_2.state_transition_data
	L2_2 = L2_2.requested_state
	L3_3 = Menu2DStateTransitionLookup
	L3_3 = L3_3.new
	L3_3 = L3_3(L3_3, A0_0.transitions)
	L3_3 = L3_3.state
	L3_3 = L3_3(L3_3, L2_2)
	A0_0._sub_state_machine = FiniteStateMachine:new(L1_1, "_state_data", L3_3)
	A0_0:_setup_resources()
	A0_0._state_data.menu.components.page_flipper:page_change_callbacks().add(A0_0, function(...)
		local L2_5, L3_6
		L2_5 = _UPVALUE0_
		L3_6 = L2_5
		L2_5 = L2_5._on_page_change
		L2_5(L3_6, ...)
	end)
	A0_0._state_data.menu.components.page_flipper:changing_resolution_callbacks().add(A0_0, function(...)
		_UPVALUE0_:_shutdown_resources()
	end)
	A0_0._state_data.menu.components.page_flipper:resolution_changed_callbacks().add(A0_0, function(...)
		_UPVALUE0_:_setup_resources()
	end)
	managers.volume:activate_set("menu")
end
function Menu2DStateWorldBackground.exit(A0_9)
	A0_9._state_data.menu.state_flags.frontend = false
	A0_9._sub_state_machine:destroy()
	managers.volume:deactivate_set("menu")
	A0_9:_shutdown_resources()
	Sound:remove_listener(A0_9._listener)
	A0_9._state_data.menu.components.page_flipper:page_change_callbacks().remove(A0_9)
end
function Menu2DStateWorldBackground._setup_resources(A0_10)
	A0_10._camera_noise = Menu2DCameraNoise:new(A0_10._state_data.menu.components.root_panel)
	A0_10._camera_noise:start(true, "menu")
	A0_10._state_data.menu.components.distortion:start()
end
function Menu2DStateWorldBackground._shutdown_resources(A0_11)
	A0_11._camera_noise:stop()
end
function Menu2DStateWorldBackground._preload_title(A0_12)
	local L1_13, L2_14, L3_15, L4_16, L5_17, L6_18, L7_19
	L1_13 = 0
	L2_14 = ""
	L7_19 = L4_16(L5_17)
	for L6_18, L7_19 in L3_15(L4_16, L5_17, L6_18, L7_19, L4_16(L5_17)) do
		L2_14 = "gui_resumegame_level_" .. tostring(L6_18)
		if managers.world_info:info_from_id(L6_18) and Database:has("texture", L2_14) then
			A0_12._state_data.menu.components.gui:preload_texture(L2_14)
		end
	end
	for L6_18, L7_19 in L3_15(L4_16) do
		A0_12._state_data.menu.components.gui:preload_texture(L7_19)
	end
end
function Menu2DStateWorldBackground._load(A0_20)
	managers.game_transition:set_checkpoint_index(1)
	A0_20._world_loader = WorldLoader:new("menu")
end
function Menu2DStateWorldBackground._on_page_change(A0_21, A1_22, A2_23, A3_24)
	local L4_25
	if not A1_22 or not A2_23 then
		return
	end
	L4_25 = nil
	if A3_24 then
		L4_25 = A0_21._camera:play(A2_23, A1_22, A3_24)
	else
		L4_25 = A0_21._camera:play(A1_22, A2_23, A3_24)
	end
	if L4_25 then
		if A3_24 then
			A0_21._state_data.menu.components.sound:play("menu_camera_move_out")
		else
			A0_21._state_data.menu.components.sound:play("menu_camera_move_in")
		end
	end
end
function Menu2DStateWorldBackground.update(A0_26, A1_27)
	A0_26._sub_state_machine:update(A1_27)
end
