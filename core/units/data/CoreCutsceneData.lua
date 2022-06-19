CoreCutsceneData = CoreCutsceneData or class()
CutsceneData = CoreCutsceneData
function CoreCutsceneData.init(A0_0, A1_1)
	A0_0.__unit = assert(A1_1, "Unit not supplied to CoreCutsceneData.")
	A0_0.__cutscene_name = A0_0:_cutscene_name(A1_1:name())
	A0_0:cutscene_player(true, true)
	managers.cutscene:register_unit_with_cutscene_data_extension(A0_0.__unit)
end
function CoreCutsceneData.destroy(A0_2)
	A0_2:destroy_cutscene_player()
	managers.cutscene:unregister_unit_with_cutscene_data_extension(A0_2.__unit)
	A0_2.__unit = nil
	A0_2.__cutscene_name = nil
end
function CoreCutsceneData.cutscene_player(A0_3, A1_4, A2_5)
	local L3_6
	L3_6 = A0_3.__cutscene_player
	if L3_6 == nil then
		L3_6 = managers
		L3_6 = L3_6.cutscene
		L3_6 = L3_6.get_cutscene
		L3_6 = L3_6(L3_6, A0_3.__cutscene_name)
		if not A1_4 then
			cat_print("spam", "[CoreCutsceneData] The cutscene \"" .. L3_6:name() .. "\" has been cleaned up. Call CoreCutsceneData:reset_cutscene_player() before attempting to replay it.")
		end
		A0_3.__cutscene_player = core_or_local("CutscenePlayer", L3_6)
		A0_3.__cutscene_player:add_keys()
		if not A2_5 then
			A0_3.__cutscene_player:prime()
		end
		function A0_3.__cutscene_player.destroy(A0_7)
			assert(A0_7 == _UPVALUE0_.__cutscene_player)
			_UPVALUE0_.__cutscene_player = nil
			_UPVALUE1_(A0_7)
		end
	end
	L3_6 = A0_3.__cutscene_player
	return L3_6
end
function CoreCutsceneData.destroy_cutscene_player(A0_8)
	if A0_8.__cutscene_player then
		A0_8.__cutscene_player:destroy()
		assert(A0_8.__cutscene_player == nil)
	end
end
function CoreCutsceneData.reset_cutscene_player(A0_9)
	A0_9:destroy_cutscene_player()
	A0_9:cutscene_player(true)
end
function CoreCutsceneData._cutscene_name(A0_10, A1_11)
	return string.match(A1_11, "cutscene_(.+)")
end
