CoreAreaManager = CoreAreaManager or class(CallbackHandler)
function CoreAreaManager.init(A0_0)
	CallbackHandler.init(A0_0)
	A0_0:_set_default_interval(0.1)
	A0_0._every_frame_check = {}
	A0_0._area_group_map = {}
	A0_0._brush = Draw:brush()
end
function CoreAreaManager._set_default_interval(A0_1, A1_2)
	A0_1._DEFAULT_INTERVAL = A1_2
end
function CoreAreaManager.default_interval(A0_3)
	local L1_4
	L1_4 = A0_3._DEFAULT_INTERVAL
	return L1_4
end
function CoreAreaManager.create_area(A0_5, A1_6)
	local L2_7
	L2_7 = A1_6.parameter
	L2_7 = L2_7(A1_6, "name")
	A0_5._area_group_map[L2_7] = A0_5._area_group_map[L2_7] or (rawget(_G, "AreaGroup") or rawget(_G, "CoreAreaGroup")):new(A0_5, A1_6, L2_7)
	A0_5._area_group_map[L2_7]:parse(A1_6)
	return A0_5._area_group_map[L2_7]
end
function CoreAreaManager.get_area(A0_8, A1_9, A2_10)
	local L3_11
	L3_11 = A0_8._area_group_map
	L3_11[A1_9] = A0_8._area_group_map[A1_9] or (rawget(_G, "AreaGroup") or rawget(_G, "CoreAreaGroup")):new(A0_8, A2_10, A1_9)
	L3_11 = parse_values_node
	L3_11 = L3_11(A2_10)
	if L3_11.area_type then
		A0_8._area_group_map[A1_9]:set_properties(L3_11)
	end
	return A0_8._area_group_map[A1_9]
end
function CoreAreaManager.update(A0_12, A1_13, A2_14)
	local L3_15, L4_16, L5_17, L6_18, L7_19
	L3_15(L4_16, L5_17)
	for L6_18, L7_19 in L3_15(L4_16) do
		L7_19()
	end
	L3_15(L4_16)
end
function CoreAreaManager.debug_draw(A0_20)
	local L1_21, L2_22, L3_23, L4_24, L5_25, L6_26, L7_27, L8_28, L9_29
	if not L1_21 then
		return
	end
	if not L1_21 then
		return
	end
	for L4_24, L5_25 in L1_21(L2_22) do
		L6_26 = 0.25
		L7_27 = 0.5
		L8_28 = 0
		L9_29 = 0
		if L5_25:active() then
			L7_27 = 0
			L8_28 = 0.5
			L9_29 = 0
		end
		for 