DramaSceneConversation = DramaSceneConversation or class()
function DramaSceneConversation.init(A0_0)
	A0_0._lines = {}
end
DramaSceneManager = DramaSceneManager or class()
function DramaSceneManager.init(A0_1, A1_2)
	local L2_3, L3_4, L4_5, L5_6, L6_7, L7_8, L8_9, L9_10, L10_11
	L2_3 = {}
	A0_1._sound_names = L2_3
	L2_3 = {}
	A0_1._conversations = L2_3
	L2_3 = {}
	A0_1._unit_name_to_script_name = L2_3
	L2_3 = true
	L3_4 = Database
	L3_4 = L3_4.all
	L3_4 = L3_4(L4_5, L5_6, L6_7)
	for L7_8, L8_9 in L4_5(L5_6) do
		L10_11 = L8_9
		L9_10 = L8_9.name
		L9_10 = L9_10(L10_11)
		L10_11 = L9_10
		L9_10 = L9_10.sub
		L9_10 = L9_10(L10_11, 0, 5)
		if L9_10 == "vc_lv" then
			L10_11 = Database
			L10_11 = L10_11.load_node
			L10_11 = L10_11(L10_11, L8_9)
			A0_1:_read_sound_names(L10_11)
		end
	end
	L7_8 = "character_slot2"
	L4_5(L5_6, L6_7, L7_8)
	L7_8 = "character_slot3"
	L4_5(L5_6, L6_7, L7_8)
	L7_8 = "character_slot4"
	L4_5(L5_6, L6_7, L7_8)
	A0_1._line_finished = false
	A0_1._interrupt_finished = true
	A0_1._wall_timer = L4_5
end
function DramaSceneManager._split_voice_line_id(A0_12, A1_13)
	local L2_14, L3_15, L4_16, L5_17, L6_18, L7_19
	L3_15 = A1_13
	L2_14 = A1_13.sub
	L4_16 = 1
	L5_17 = 7
	L2_14 = L2_14(L3_15, L4_16, L5_17)
	L4_16 = A1_13
	L3_15 = A1_13.sub
	L5_17 = 3
	L6_18 = 4
	L3_15 = L3_15(L4_16, L5_17, L6_18)
	L4_16 = 9
	L6_18 = A1_13
	L5_17 = A1_13.find
	L7_19 = "_"
	L5_17 = L5_17(L6_18, L7_19, L4_16)
	L6_18 = nil
	if L5_17 then
		L7_19 = A1_13.sub
		L7_19 = L7_19(A1_13, L4_16, L5_17 - 1)
		L6_18 = L7_19
	end
	L7_19 = A1_13.sub
	L7_19 = L7_19(A1_13, L5_17 + 1)
	return {
		name = A1_13,
		wait_time = 0.4,
		conversation_id = L2_14,
		scenario_id = L3_15,
		index = tonumber(L7_19),
		actor_name = L6_18
	}
end
function DramaSceneManager._read_sound_names(A0_20, A1_21)
	for 