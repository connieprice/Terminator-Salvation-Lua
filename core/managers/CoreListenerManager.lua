require("core/utils/dev/CoreLinkedStackMap")
CoreListenerManager = CoreListenerManager or class()
function CoreListenerManager.init(A0_0)
	A0_0._set_map = {}
	A0_0._category_map = {}
	A0_0._listener_map = {}
	A0_0._active_category_map = {}
	A0_0._active_set_count_map = {}
	A0_0._active_set_stack_map = {}
	A0_0._activation_map = {}
	A0_0._stack_activation_map = {}
	A0_0._set_activation_map = {}
	A0_0._last_activation_id = 0
	A0_0._enabled = true
	A0_0:add_stack("main")
end
function CoreListenerManager.get_closest_listener_position(A0_1, A1_2)
	local L2_3, L3_4
	A0_1:callback_on_all_active_listeners(function(A0_5)
		local L1_6
		L1_6 = Sound
		L1_6 = L1_6.listener
		L1_6 = L1_6(L1_6, A0_5)
		if alive(L1_6) and (not _UPVALUE1_ or (L1_6:position() - _UPVALUE0_):length() < _UPVALUE1_) then
			_UPVALUE1_, _UPVALUE2_ = (L1_6:position() - _UPVALUE0_):length(), L1_6:position()
		end
	end)
	return L2_3, L3_4
end
function CoreListenerManager.set_enabled(A0_7, A1_8)
	A1_8 = not not A1_8
	if A0_7._enabled ~= A1_8 then
		A0_7:callback_on_all_active_listeners(function(A0_9)
			Sound:set_listener_enabled(A0_9, _UPVALUE0_)
		end)
		A0_7._enabled = A1_8
	end
end
function CoreListenerManager.callback_on_all_active_listeners(A0_10, A1_11)
	local L2_12, L3_13, L4_14, L5_15, L6_16, L7_17, L8_18, L9_19, L10_20, L11_21, L12_22, L13_23, L14_24, L15_25, L16_26, L17_27, L18_28
	L2_12 = {}
	L3_13 = {}
	for L7_17, L8_18 in L4_14(L5_15) do
		L9_19 = L8_18.top
		L9_19 = L9_19(L10_20)
		if L9_19 then
			if not L10_20 then
				for L13_23, L14_24 in L10_20(L11_21) do
					if not L15_25 then
						for L18_28, 