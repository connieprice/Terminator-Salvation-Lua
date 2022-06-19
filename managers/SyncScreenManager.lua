local L0_0
L0_0 = SyncScreenManager
if not L0_0 then
	L0_0 = class
	L0_0 = L0_0()
end
SyncScreenManager = L0_0
L0_0 = {
	"faith_font_22"
}
function SyncScreenManager.preload()
	local L0_1, L1_2, L2_3, L3_4, L4_5
	if L0_1 then
		return
	end
	if not L0_1 then
		L0_1(L1_2, L2_3)
		L3_4 = "loading_screen_loop"
		L0_1(L1_2)
		for L3_4, L4_5 in L0_1(L1_2) do
			Gui:resident():preload_font(L4_5)
		end
		for L3_4, L4_5 in L0_1(L1_2) do
			Gui:resident():preload_texture(L4_5)
		end
		L0_1.sync_screens_preloaded = true
	end
end
function SyncScreenManager.init(A0_6)
	A0_6._closing_sync_screen = false
	managers.environment:preload_environment("loading_screen")
	A0_6._args = nil
end
function SyncScreenManager.update(A0_7, A1_8)
	if SyncScreenManager._loading_screen_disabled() then
		return
	end
	if A0_7._closing_sync_screen and A0_7:_is_fade_down_done() then
		Global.shows_sync_screen = false
		A0_7._closing_sync_screen = false
		A0_7:_stop()
	end
end
function SyncScreenManager.setup_sync_screen(A0_9)
	local L1_10
	A0_9._lua_file = "data/lib/LevelLoadingEnvironment.lua"
	L1_10 = _UPVALUE0_
	A0_9._fonts = L1_10
	L1_10 = _UPVALUE1_
	A0_9._textures = L1_10
	L1_10 = LevelLoadingEnvironmentScene
	A0_9._scene = L1_10
	A0_9._scene_name = "LevelLoadingEnvironmentScene"
	A0_9._environment = "loading_screen"
	A0_9._use_controllers = true
end
function SyncScreenManager.setup_minimal_sync_screen(A0_11)
	local L1_12
	A0_11._lua_file = "data/lib/MenuLoadingEnvironment.lua"
	L1_12 = _UPVALUE0_
	A0_11._fonts = L1_12
	L1_12 = _UPVALUE1_
	A0_11._textures = L1_12
	L1_12 = MenuLoadingEnvironmentScene
	A0_11._scene = L1_12
	A0_11._scene_name = "MenuLoadingEnvironmentScene"
	A0_11._environment = nil
	A0_11._use_controllers = false
end
function SyncScreenManager.setup_startup_sync_screen(A0_13)
	local L1_14
	A0_13._lua_file = "data/lib/MenuLoadingEnvironment.lua"
	L1_14 = _UPVALUE0_
	A0_13._fonts = L1_14
	L1_14 = _UPVALUE1_
	A0_13._textures = L1_14
	L1_14 = MenuLoadingEnvironmentScene
	A0_13._scene = L1_14
	A0_13._scene_name = "MenuLoadingEnvironmentScene"
	A0_13._environment = nil
	A0_13._use_controllers = false
end
function SyncScreenManager.start_sync_screen(A0_15)
	local L1_16, L2_17, L3_18, L4_19, L5_20
	L1_16.shows_sync_screen = true
	A0_15._closing_sync_screen = false
	L1_16(L2_17, L3_18)
	if L1_16 then
		A0_15._disabled_showing_sync_screen_response = true
		return
	end
	if L1_16 then
		L1_16(L2_17)
	end
	for L4_19, L5_20 in L1_16(L2_17) do
		A0_15._scene:newgui():preload_font(L5_20)
	end
	for L4_19, L5_20 in L1_16(L2_17) do
		A0_15._scene:newgui():preload_texture(L5_20)
	end
	if L1_16 then
		L4_19 = 0
		L5_20 = 0
		A0_15._script_vp = L1_16
		L4_19 = L3_18
		L5_20 = L3_18(L4_19)
		L1_16(L2_17, L3_18, L4_19, L5_20, L3_18(L4_19))
		L1_16(L2_17)
		L1_16(L2_17, L3_18)
		L1_16(L2_17, L3_18)
		L1_16(L2_17)
		L4_19 = loading_screen_tweak_data
		L4_19 = L4_19.DOF_NEAR_MIN
		L5_20 = loading_screen_tweak_data
		L5_20 = L5_20.DOF_NEAR_MAX
		L1_16(L2_17, L3_18, L4_19, L5_20, loading_screen_tweak_data.DOF_FAR_MIN, loading_screen_tweak_data.DOF_FAR_MAX)
		L1_16(L2_17)
	end
	A0_15._width = 1280
	A0_15._height = L1_16
	if L3_18 then
		L5_20 = A0_15
		L4_19 = A0_15._get_rotation_controller_info
		L4_19 = L4_19(L5_20, "look")
		L5_20 = A0_15._get_rotation_controller_info
		L5_20 = L5_20(A0_15, "move")
		;({
			L4_19,
			[3] = L5_20(A0_15, "move")
		})[2] = L5_20
		L2_17.rotation_controllers = L3_18
	end
	L4_19 = L3_18
	L5_20 = "menu"
	L2_17.volume = L3_18
	L4_19 = cat_print
	L5_20 = "debug"
	L4_19(L5_20, "Running sync screen with resolution " .. L3_18.x .. "x" .. L3_18.y)
	L4_19 = {}
	L5_20 = L1_16.x
	L4_19.x = L5_20
	L5_20 = L1_16.y
	L4_19.y = L5_20
	L5_20 = L1_16.w
	L4_19.w = L5_20
	L5_20 = L1_16.h
	L4_19.h = L5_20
	L2_17.safe_rect = L4_19
	L4_19 = {}
	L5_20 = A0_15._width
	L4_19.width = L5_20
	L5_20 = A0_15._height
	L4_19.height = L5_20
	L2_17.workspace_size = L4_19
	L4_19 = {}
	L5_20 = L3_18.x
	L4_19.width = L5_20
	L5_20 = L3_18.y
	L4_19.height = L5_20
	L2_17.screen_size = L4_19
	L5_20 = A0_15
	L4_19 = A0_15._camera_width_multiplier
	L4_19 = L4_19(L5_20)
	L2_17.camera_width_multiplier = L4_19
	L5_20 = A0_15
	L4_19 = A0_15._start
	L4_19(L5_20, A0_15._lua_file, A0_15._scene_name, L2_17)
end
function SyncScreenManager._safe_rect(A0_21)
	local L1_22, L2_23, L3_24
	L1_22 = {}
	L2_23 = A0_21._width
	L3_24 = tweak_data
	L3_24 = L3_24.SAFE_RECT
	L3_24 = L3_24.x
	L2_23 = L2_23 * L3_24
	L1_22.w = L2_23
	L2_23 = A0_21._height
	L3_24 = tweak_data
	L3_24 = L3_24.SAFE_RECT
	L3_24 = L3_24.y
	L2_23 = L2_23 * L3_24
	L1_22.h = L2_23
	L2_23 = A0_21._width
	L3_24 = L1_22.w
	L2_23 = L2_23 - L3_24
	L2_23 = 0.5 * L2_23
	L1_22.x = L2_23
	L2_23 = A0_21._height
	L3_24 = L1_22.h
	L2_23 = L2_23 - L3_24
	L2_23 = 0.5 * L2_23
	L1_22.y = L2_23
	return L1_22
end
function SyncScreenManager._camera_width_multiplier(A0_25)
	if core_setup.aspect_ratio then
		return width_mul()
	end
	return A0_25:_aspect_ratio() / 1.3333334
end
function SyncScreenManager._aspect_ratio(A0_26)
	local L1_27
	if SystemInfo:platform() == "WIN32" then
		L1_27 = core_setup_get_aspect()
	elseif SystemInfo:platform() == "X360" or SystemInfo:platform() == "PS3" and SystemInfo:widescreen() then
		L1_27 = 1.7777778
	else
		L1_27 = 1.3333334
	end
	return L1_27
end
function SyncScreenManager._get_rotation_controller_info(A0_28, A1_29)
	local L2_30, L3_31, L4_32, L5_33
	L2_30 = managers
	L2_30 = L2_30.menu_input
	L3_31 = L2_30
	L2_30 = L2_30.bound_user
	L2_30 = L2_30(L3_31)
	L3_31 = L2_30
	L2_30 = L2_30.controller_wrapper
	L2_30 = L2_30(L3_31)
	L4_32 = L2_30
	L3_31 = L2_30.get_connection_settings
	L5_33 = A1_29
	L3_31 = L3_31(L4_32, L5_33)
	L5_33 = L3_31
	L4_32 = L3_31.get_controller_id
	L4_32 = L4_32(L5_33)
	if not L4_32 then
		L5_33 = L2_30
		L4_32 = L2_30.get_default_controller_id
		L4_32 = L4_32(L5_33)
	end
	L5_33 = L2_30.get_controller_map
	L5_33 = L5_33(L2_30)
	L5_33 = L5_33[L4_32]
	if not L5_33 then
		return
	end
	if L5_33:type() == "win32_mouse" then
	else
	end
	return {
		index = Input:controller_index(L5_33),
		input_names = L3_31:get_input_name_list(),
		options = {invert_y = false}
	}
end
function SyncScreenManager.hide_sync_screen(A0_34, A1_35)
	cat_print("debug", "****************** HIDE SYNC SCREEN *************************")
	if SyncScreenManager._loading_screen_disabled() then
		Global.shows_sync_screen = false
		A0_34._closing_sync_screen = false
		A0_34._disabled_showing_sync_screen_response = false
		return
	end
	if Global.shows_startup_sync_screen then
		Global.shows_startup_sync_screen = false
	end
	if A1_35 then
		Global.shows_sync_screen = false
		A0_34._closing_sync_screen = false
		A0_34:_stop()
		return
	end
	A0_34._closing_sync_screen = true
	A0_34:_fade_down()
end
function SyncScreenManager.is_showing_sync_screen(A0_36)
	if SyncScreenManager._loading_screen_disabled() then
		return A0_36._disabled_showing_sync_screen_response
	end
	return Global.shows_sync_screen
end
function SyncScreenManager._start(A0_37, A1_38, A2_39, A3_40)
	cat_print("debug", "NewLoadingEnvironment:start()")
	NewLoadingEnvironment:start(A1_38, A2_39, A3_40)
	NewLoadingEnvironment:set_flag("fade_down", false)
	NewLoadingEnvironment:set_flag("fade_down_done", false)
end
function SyncScreenManager._stop(A0_41)
	cat_print("debug", "NewLoadingEnvironment:stop()")
	NewLoadingEnvironment:stop()
end
function SyncScreenManager._running(A0_42)
	return NewLoadingEnvironment:running()
end
function SyncScreenManager._fade_down(A0_43)
	NewLoadingEnvironment:set_flag("fade_down", true)
end
function SyncScreenManager._is_fade_down_done(A0_44)
	return NewLoadingEnvironment:flag("fade_down_done")
end
SyncScreenManager.LOADING_SCREEN_DISABLED = false
function SyncScreenManager._loading_screen_disabled()
	return not SystemInfo:threaded_renderer() or SyncScreenManager.LOADING_SCREEN_DISABLED
end
