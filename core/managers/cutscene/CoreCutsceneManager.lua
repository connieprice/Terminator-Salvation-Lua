require("core/managers/cutscene/CoreCutscene")
require("core/managers/cutscene/CoreCutsceneKeys")
require("core/managers/cutscene/CoreCutsceneCast")
require("core/managers/cutscene/CoreCutscenePlayer")
require("core/managers/cutscene/CoreCutsceneActorDatabase")
CoreCutsceneManager = CoreCutsceneManager or mixin(class(), BasicEventHandling)
function CoreCutsceneManager.cutscene_actor_unit_type(A0_0, A1_1)
	local L2_2
	L2_2 = Global
	L2_2 = L2_2.__CutsceneManager__replaced_actor_unit_types
	if L2_2 then
		L2_2 = Global
		L2_2 = L2_2.__CutsceneManager__replaced_actor_unit_types
		L2_2 = L2_2[A1_1]
	else
		L2_2 = L2_2 or A1_1
	end
	return L2_2
end
function CoreCutsceneManager.replace_cutscene_actor_unit_type(A0_3, A1_4, A2_5)
	local L3_6
	L3_6 = assert
	L3_6(UnitDatabase:get_unit_data(A1_4), string.format("Unrecognized Unit \"%s\".", A1_4))
	L3_6 = assert
	L3_6(A2_5 == nil or UnitDatabase:get_unit_data(A2_5), string.format("Unrecognized Unit \"%s\".", A2_5 or ""))
	L3_6 = Global
	L3_6.__CutsceneManager__replaced_actor_unit_types = Global.__CutsceneManager__replaced_actor_unit_types or {}
	if A2_5 then
		L3_6 = cat_print
		L3_6("cutscene", string.format("[CoreCutsceneManager] Replacing all \"%s\" actors with instances of \"%s\".", A1_4, A2_5))
	else
		L3_6 = Global
		L3_6 = L3_6.__CutsceneManager__replaced_actor_unit_types
		L3_6 = L3_6[A1_4]
		if L3_6 then
			L3_6 = cat_print
			L3_6("cutscene", string.format("[CoreCutsceneManager] Undoing replacement of all \"%s\" actors.", A1_4))
		end
	end
	L3_6 = Global
	L3_6 = L3_6.__CutsceneManager__replaced_actor_unit_types
	L3_6[A1_4] = A2_5
end
function CoreCutsceneManager.init(A0_7)
	if UnitDatabase:get_unit_data("locator") and not UnitDatabase:get_unit_data("locator"):preloaded() then
		World:preload_unit("locator")
	end
	managers.listener:add_set("cutscene", {"cutscene"})
	A0_7._timer = TimerManager:game_animation()
	A0_7._actor_database = core_or_local("CutsceneActorDatabase")
	A0_7._input_controller = managers.controller:create_controller()
	A0_7._input_controller:disable()
	A0_7._gui_workspace = A0_7:_create_gui_workspace()
	A0_7._video_workspace = A0_7:_create_video_workspace()
	if Application:ews_enabled() then
		A0_7._database = ProjectDatabase
		A0_7._database_for_saving = ProjectDatabase
		A0_7:populate_from_database()
	else
		A0_7._database = Database
		A0_7:populate_from_database()
	end
end
function CoreCutsceneManager.post_init(A0_8)
	A0_8:_prime_cutscenes_in_world()
end
function CoreCutsceneManager.destroy(A0_9)
	if A0_9._player then
		A0_9._player:destroy()
		A0_9._player = nil
	end
	A0_9:_destroy_units_with_cutscene_data_extension()
	if alive(A0_9._video_workspace) then
		Overlay:newgui():destroy_workspace(A0_9._video_workspace)
	end
	A0_9._video_workspace = nil
	if alive(A0_9._gui_workspace) then
		Overlay:newgui():destroy_workspace(A0_9._gui_workspace)
	end
	A0_9._gui_workspace = nil
	if A0_9._input_controller then
		A0_9._input_controller:destroy()
		A0_9._input_controller = nil
	end
	managers.listener:remove_set("cutscene")
end
function CoreCutsceneManager.timer(A0_10)
	local L1_11
	L1_11 = A0_10._timer
	return L1_11
end
function CoreCutsceneManager.set_timer(A0_12, A1_13)
	A0_12._timer = assert(A1_13, "Must supply a timer.")
	if A0_12._player then
		A0_12._player:set_timer(A1_13)
	end
	if A0_12:gui_workspace() then
		A0_12:gui_workspace():set_timer(A0_12._timer)
	end
	if A0_12:video_workspace() then
		A0_12:video_workspace():set_timer(A0_12._timer)
	end
end
function CoreCutsceneManager.populate_from_database(A0_14)
	local L1_15, L2_16, L3_17, L4_18, L5_19, L6_20, L7_21, L8_22
	L1_15 = {}
	A0_14._cutscenes = L1_15
	A0_14._player = nil
	L1_15 = A0_14._database
	L2_16 = L1_15
	L1_15 = L1_15.all
	L1_15 = L1_15(L2_16, L3_17, L4_18)
	L2_16 = A0_14._database_for_saving
	L2_16 = L2_16 ~= nil
	for L6_20, L7_21 in L3_17(L4_18) do
		L8_22 = A0_14._database
		L8_22 = L8_22.load_node
		L8_22 = L8_22(L8_22, L7_21)
		if L2_16 or core_or_local("Cutscene", L8_22, A0_14):is_optimized() then
			A0_14._cutscenes[L7_21:name()] = core_or_local("Cutscene", L8_22, A0_14)
		end
	end
end
function CoreCutsceneManager.register_unit_with_cutscene_data_extension(A0_23, A1_24)
	A0_23._units_with_cutscene_data_extension = A0_23._units_with_cutscene_data_extension or {}
	table.insert(A0_23._units_with_cutscene_data_extension, A1_24)
end
function CoreCutsceneManager.unregister_unit_with_cutscene_data_extension(A0_25, A1_26)
	if A0_25._units_with_cutscene_data_extension then
		table.delete(A0_25._units_with_cutscene_data_extension, A1_26)
		if #A0_25._units_with_cutscene_data_extension == 0 then
			A0_25._units_with_cutscene_data_extension = nil
		end
	end
end
function CoreCutsceneManager._prime_cutscenes_in_world(A0_27)
	local L1_28, L2_29, L3_30, L4_31, L5_32
	for L4_31, L5_32 in L1_28(L2_29) do
		if alive(L5_32) then
			cat_print("cutscene", string.format("[CoreCutsceneManager] Priming in-world cutscene \"%s\".", L5_32:cutscene_data():cutscene_player():cutscene_name()))
			L5_32:cutscene_data():cutscene_player():prime()
		end
	end
end
function CoreCutsceneManager._destroy_units_with_cutscene_data_extension(A0_33)
	local L1_34, L2_35, L3_36, L4_37, L5_38, L6_39
	L1_34 = table
	L1_34 = L1_34.list_copy
	L1_34 = L1_34(L2_35)
	for L5_38, L6_39 in L2_35(L3_36) do
		A0_33:unregister_unit_with_cutscene_data_extension(L6_39)
		if alive(L6_39) then
			cat_print("cutscene", string.format("[CoreCutsceneManager] Destroying Unit with CutsceneData extension \"%s\".", L6_39:name()))
			World:delete_unit(L6_39)
		end
	end
	L3_36 = L3_36 == nil
	L2_35(L3_36, L4_37)
end
function CoreCutsceneManager.register_cutscene_actor(A0_40, A1_41)
	assert(alive(A1_41), "Zombie unit registered as cutscene actor.")
	assert(A1_41.unit_data and A1_41:unit_data().cutscene_actor and (A1_41.unit_data and A1_41:unit_data().cutscene_actor) ~= "", "Unnamed unit registered as cutscene actor.")
	if A0_40:cutscene_actors_in_world()[A1_41.unit_data and A1_41:unit_data().cutscene_actor] ~= nil then
		return A0_40:cutscene_actors_in_world()[A1_41.unit_data and A1_41:unit_data().cutscene_actor] == A1_41
	end
	A0_40:actor_database():append_unit_info(A1_41)
	A0_40._cutscene_actors = A0_40._cutscene_actors or {}
	A0_40._cutscene_actors[A1_41.unit_data and A1_41:unit_data().cutscene_actor] = A1_41
	return true
end
function CoreCutsceneManager.unregister_cutscene_actor(A0_42, A1_43)
	assert(alive(A1_43), "Zombie unit unregistered as cutscene actor.")
	assert(A1_43.unit_data and A1_43:unit_data().cutscene_actor and (A1_43.unit_data and A1_43:unit_data().cutscene_actor) ~= "", "Unnamed unit unregistered as cutscene actor.")
	if A0_42:cutscene_actors_in_world()[A1_43.unit_data and A1_43:unit_data().cutscene_actor] == nil then
		return false
	end
	A0_42._cutscene_actors[A1_43.unit_data and A1_43:unit_data().cutscene_actor] = nil
	if table.empty(A0_42._cutscene_actors) then
		A0_42._cutscene_actors = nil
	end
	return true
end
function CoreCutsceneManager.cutscene_actors_in_world(A0_44)
	local L1_45
	L1_45 = A0_44._cutscene_actors
	if L1_45 == nil then
		L1_45 = {}
		return L1_45
	end
	L1_45 = table
	L1_45 = L1_45.collect
	L1_45 = L1_45(A0_44._cutscene_actors, function(A0_46)
		return not alive(A0_46) or nil
	end)
	for 