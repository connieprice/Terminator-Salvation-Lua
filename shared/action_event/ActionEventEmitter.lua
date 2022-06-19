local L0_0
L0_0 = ActionEventEmitter
L0_0 = L0_0 or {}
ActionEventEmitter = L0_0
L0_0 = ActionEventEmitter
function L0_0.new(A0_1, A1_2)
	local L2_3, L3_4
	L2_3 = {}
	L2_3.unit = A1_2
	L2_3.name = A0_1
	L3_4 = {}
	L2_3._listener_data = L3_4
	L3_4 = {}
	L2_3._continuous_events = L3_4
	L3_4 = {}
	function L2_3.destroy(A0_5)
		managers.action_event:_destroy_emitter(A0_5)
	end
	function L3_4.__index(A0_6, A1_7, ...)
		if A1_7:sub(-6) == "_start" then
			A0_6[A1_7] = function(A0_9, A1_10, ...)
				local L3_12, L4_13, L5_14, L6_15, L7_16, L8_17
				L3_12 = managers
				L3_12 = L3_12.action_event
				L4_13 = L3_12
				L3_12 = L3_12._start_event
				L5_14 = A1_10
				L6_15 = A0_9
				L7_16 = _UPVALUE0_
				L8_17 = ...
				L3_12(L4_13, L5_14, L6_15, L7_16, L8_17)
			end
		elseif A1_7:sub(-5) == "_stop" then
			A0_6[A1_7] = function(A0_18, A1_19, ...)
				local L3_21, L4_22, L5_23, L6_24, L7_25, L8_26
				L3_21 = managers
				L3_21 = L3_21.action_event
				L4_22 = L3_21
				L3_21 = L3_21._stop_event
				L5_23 = A1_19
				L6_24 = A0_18
				L7_25 = _UPVALUE0_
				L8_26 = ...
				L3_21(L4_22, L5_23, L6_24, L7_25, L8_26)
			end
		elseif A1_7:sub(-7) == "_change" then
			A0_6[A1_7] = function(A0_27, A1_28, ...)
				local L3_30, L4_31, L5_32, L6_33, L7_34, L8_35
				L3_30 = managers
				L3_30 = L3_30.action_event
				L4_31 = L3_30
				L3_30 = L3_30._change_event
				L5_32 = A1_28
				L6_33 = A0_27
				L7_34 = _UPVALUE0_
				L8_35 = ...
				L3_30(L4_31, L5_32, L6_33, L7_34, L8_35)
			end
		elseif A1_7:sub(1, 5) == "unit_" then
			A0_6[A1_7] = function(A0_36, A1_37, ...)
				local L3_39, L4_40, L5_41, L6_42, L7_43, L8_44
				L3_39 = managers
				L3_39 = L3_39.action_event
				L4_40 = L3_39
				L3_39 = L3_39._call_unit_event
				L5_41 = A1_37
				L6_42 = A0_36
				L7_43 = _UPVALUE0_
				L8_44 = ...
				L3_39(L4_40, L5_41, L6_42, L7_43, L8_44)
			end
		else
			A0_6[A1_7] = function(A0_45, ...)
				local L2_47, L3_48, L4_49, L5_50, L6_51
				L2_47 = managers
				L2_47 = L2_47.action_event
				L3_48 = L2_47
				L2_47 = L2_47._fire_event
				L4_49 = A0_45
				L5_50 = _UPVALUE0_
				L6_51 = ...
				L2_47(L3_48, L4_49, L5_50, L6_51)
			end
		end
		return A0_6[A1_7]
	end
	setmetatable(L2_3, L3_4)
	return L2_3
end
