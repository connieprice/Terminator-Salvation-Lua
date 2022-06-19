require("core/managers/cutscene/CoreCutsceneCast")
require("core/managers/cutscene/CoreCutsceneKeyCollection")
core:require_module("CoreScriptViewport")
CoreCutscenePlayer = CoreCutscenePlayer or class()
mixin(CoreCutscenePlayer, get_core_or_local("CutsceneKeyCollection"))
CoreCutscenePlayer.BLACK_BAR_GUI_LAYER = 29
CoreCutscenePlayer.BLACK_BAR_TOP_GUI_NAME = "__CutscenePlayer__black_bar_top"
CoreCutscenePlayer.BLACK_BAR_BOTTOM_GUI_NAME = "__CutscenePlayer__black_bar_bottom"
function CoreCutscenePlayer._all_keys_sorted_by_time(A0_0)
	local L1_1
	L1_1 = A0_0._owned_cutscene_keys
	return L1_1
end
function CoreCutscenePlayer.init(A0_2, A1_3, A2_4, A3_5)
	A0_2._cutscene = assert(A1_3, "No cutscene supplied.")
	A0_2._viewport = A2_4 or A0_2:_create_viewport()
	A0_2._cast = A3_5 or A0_2:_create_cast()
	A0_2._owned_cutscene_keys = {}
	A0_2._time = 0
	cat_print("cutscene", string.format("[CoreCutscenePlayer] Created CutscenePlayer for \"%s\".", A0_2:cutscene_name()))
	if not alive(A0_2._viewport:camera()) then
		A0_2:_create_camera()
	end
	A0_2:_create_future_camera()
	A0_2:_clear_workspace()
	A0_2._resolution_changed_callback_id = managers.viewport:add_resolution_changed_func(callback(A0_2, A0_2, "_configure_viewport"))
end
function CoreCutscenePlayer._create_future_camera(A0_6)
	A0_6._future_camera_locator = World:spawn_unit("locator", Vector3(0, 0, 0), Rotation())
	A0_6._future_camera = World:create_camera()
	A0_6:_initialize_camera(A0_6._future_camera)
	A0_6._future_camera:link(A0_6._future_camera_locator:get_object("locator"))
	A0_6._future_camera:new_set_local_rotation(Rotation(-90, 0, 0))
	A0_6._cast:_reparent_to_locator_unit(A0_6._cast:_root_unit(), A0_6._future_camera_locator)
end
function CoreCutscenePlayer.add_keys(A0_7, A1_8)
	local L2_9, L3_10, L4_11, L5_12, L6_13, L7_14
	A1_8 = A1_8 or A0_7._cutscene
	L7_14 = L3_10(L4_11)
	for L5_12, L6_13 in L2_9(L3_10, L4_11, L5_12, L6_13, L7_14, L3_10(L4_11)) do
		L7_14 = A0_7._is_driving_sound_key
		L7_14 = L7_14(A0_7, L6_13)
		if L7_14 then
			L7_14 = A0_7._set_driving_sound_from_key
			L7_14(A0_7, L6_13)
		else
			L7_14 = L6_13.clone
			L7_14 = L7_14(L6_13)
			L7_14:set_key_collection(A0_7)
			L7_14:set_cast(A0_7._cast)
			table.insert(A0_7._owned_cutscene_keys, L7_14)
		end
	end
end
function CoreCutscenePlayer._is_driving_sound_key(A0_15, A1_16)
	return A1_16.ELEMENT_NAME == CoreSoundCutsceneKey.ELEMENT_NAME and A1_16:frame() == 0 and A1_16:sync_to_video()
end
function CoreCutscenePlayer._set_driving_sound_from_key(A0_17, A1_18)
	local L4_19
	L4_19 = cat_print
	L4_19("cutscene", string.format("[CoreCutscenePlayer] Using sound cue \"%s/%s\" to drive the playhead.", A1_18:bank(), A1_18:cue()))
	L4_19 = assert
	L4_19 = L4_19(Sound:make_bank(A1_18:bank(), A1_18:cue()), string.format("Driving sound cue \"%s/%s\" not found.", A1_18:bank(), A1_18:cue()))
	A0_17._driving_sound = L4_19
end
function CoreCutscenePlayer.set_timer(A0_20, A1_21)
	local L2_22
	L2_22 = A0_20._cast
	L2_22 = L2_22.set_timer
	L2_22(L2_22, A1_21)
	L2_22 = alive
	L2_22 = L2_22(A0_20._workspace)
	if L2_22 then
		L2_22 = A0_20._workspace
		L2_22 = L2_22.set_timer
		L2_22(L2_22, A1_21)
	end
	L2_22 = A0_20._camera_controller
	L2_22 = L2_22(A0_20)
	if alive(L2_22) then
		L2_22:set_timer(A1_21)
	end
end
function CoreCutscenePlayer.viewport(A0_23)
	local L1_24
	L1_24 = A0_23._viewport
	return L1_24
end
function CoreCutscenePlayer.cutscene_name(A0_25)
	return A0_25._cutscene:name()
end
function CoreCutscenePlayer.cutscene_duration(A0_26)
	return A0_26._cutscene:duration()
end
function CoreCutscenePlayer.camera_attributes(A0_27)
	({}).aspect_ratio = A0_27:_camera():aspect_ratio()
	;({}).fov = A0_27:_camera():fov()
	;({}).near_range = A0_27:_camera():near_range()
	;({}).far_range = A0_27:_camera():far_range()
	if A0_27._dof_attributes then
		for 