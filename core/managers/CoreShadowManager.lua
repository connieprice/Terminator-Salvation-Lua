core:module("CoreShadowManager")
core:require_module("CoreClass")
core:require_module("CoreCode")
ShadowBlock = ShadowBlock or CoreClass.class()
function ShadowBlock.init(A0_0)
	A0_0._parameters = {}
end
function ShadowBlock.map(A0_1)
	local L1_2
	L1_2 = A0_1._parameters
	return L1_2
end
function ShadowBlock.set(A0_3, A1_4, A2_5)
	A0_3._parameters[A1_4] = A2_5
end
function ShadowBlock.get(A0_6, A1_7)
	return A0_6._parameters[A1_7]
end
ShadowManager = ShadowManager or CoreClass.class()
function ShadowManager.init(A0_8)
	local L1_9
	L1_9 = {}
	A0_8._preloaded_shadow_blocks = L1_9
	L1_9 = {}
	A0_8._stack = L1_9
	A0_8._shadow_mul = 1
	A0_8._needs_update = false
end
function ShadowManager.update(A0_10, A1_11, A2_12)
end
function ShadowManager.paused_update(A0_13, A1_14, A2_15)
	A0_13:update(A1_14, A2_15)
end
function ShadowManager.load(A0_16, A1_17)
	if not A0_16._preloaded_shadow_blocks[A1_17] then
		Application:stack_dump_error("[ShadowManager] Shadow block not preloaded: ", A1_17)
		A0_16:preload(A1_17)
	end
	return A0_16._preloaded_shadow_blocks[A1_17]
end
function ShadowManager.list(A0_18, A1_19)
	local L2_20, L3_21, L4_22, L5_23, L6_24, L7_25, L8_26, L9_27
	L2_20 = {}
	L3_21 = Database
	L3_21 = L3_21.all
	L3_21 = L3_21(L4_22, L5_23, L6_24)
	for L7_25, L8_26 in L4_22(L5_23) do
		L9_27 = L8_26.name
		L9_27 = L9_27(L8_26)
		if not A1_19 or string.find(L9_27, A1_19) then
			table.insert(L2_20, L9_27)
		end
	end
	return L2_20
end
function ShadowManager.get(A0_28)
	local L1_29
	L1_29 = A0_28._current_shadow_block
	return L1_29
end
function ShadowManager.stack_size(A0_30)
	return #A0_30._stack
end
function ShadowManager.push(A0_31, A1_32)
	local L2_33
	if type(A1_32) == "string" then
		L2_33 = assert(A0_31._preloaded_shadow_blocks[A1_32], "Shadow settings are not preloaded!")
	else
		L2_33 = A1_32
	end
	if A0_31._current_shadow_block then
		table.insert(A0_31._stack, A0_31._current_shadow_block)
	end
	A0_31:set(L2_33)
	return A0_31:stack_size()
end
function ShadowManager.pop(A0_34)
	if A0_34:stack_size() > 0 then
		A0_34:set(A0_34._stack[A0_34:stack_size()])
		table.remove(A0_34._stack)
	end
	return A0_34:stack_size() - 1
end
function ShadowManager.set(A0_35, A1_36)
	A0_35._needs_update = true
	if type(A1_36) == "string" then
		A0_35._current_shadow_block = assert(A0_35._preloaded_shadow_blocks[A1_36], "Shadow settings are not preloaded!")
	else
		A0_35._current_shadow_block = A1_36
	end
	A0_35:feed_now()
end
function ShadowManager.feed_now(A0_37)
	local L1_38, L2_39, L3_40
	L1_38 = A0_37._current_shadow_block
	if L1_38 then
		L1_38 = A0_37._current_shadow_block
		L3_40 = A0_37
		L2_39 = A0_37._set_split_depths
		L2_39(L3_40, L1_38:get("d0"), L1_38:get("d1"), L1_38:get("d2"), L1_38:get("d3"), L1_38:get("o1"), L1_38:get("o2"), L1_38:get("o3"), L1_38:get("f"))
		A0_37._needs_update = false
	end
end
function ShadowManager.set_now(A0_41, A1_42)
	A0_41:set(A1_42)
	A0_41:feed_now()
end
function ShadowManager.set_shadow_mul(A0_43, A1_44)
	A0_43._shadow_mul = A1_44
	A0_43:feed_now()
end
function ShadowManager.preload(A0_45, A1_46, A2_47)
	local L3_48, L4_49
	if not A2_47 then
		L3_48 = A0_45._preloaded_shadow_blocks
		L3_48 = L3_48[A1_46]
	elseif not L3_48 then
		L3_48 = ShadowBlock
		L4_49 = L3_48
		L3_48 = L3_48.new
		L3_48 = L3_48(L4_49)
		L4_49 = A0_45._preloaded_shadow_blocks
		L4_49[A1_46] = L3_48
		L4_49 = Database
		L4_49 = L4_49.lookup
		L4_49 = L4_49(L4_49, "shadow_setting", A1_46)
		assert(L4_49:valid())
		for 