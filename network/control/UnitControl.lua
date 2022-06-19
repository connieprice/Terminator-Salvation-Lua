require("shared/TableAlgorithms")
require("shared/Queue")
require("network/Peer")
UnitControl = UnitControl or class()
function not_functions(A0_0)
	return type(A0_0) ~= "function"
end
UnitControl.controller = {}
UnitControl.controller.HUMAN = 0
UnitControl.controller.AI = 1
UnitControl.controller.NONE = 2
function UnitControl.init(A0_1, A1_2)
	A0_1._unit = A1_2
	A0_1._unit_id = managers.unit_control_id:get_unit_id(A0_1._unit)
	A0_1._queue = Queue:new()
	A0_1._send = Network:self()
	A0_1.TYPE_INPUT = 1
	A0_1.TYPE_SAVE = 2
	A0_1._controller = UnitControl.controller.NONE
end
function UnitControl.destroy(A0_3, A1_4)
	managers.unit_control_id:free_unit_id(A0_3._unit)
	A0_3._unit_id = 0
end
function UnitControl.update(A0_5, A1_6, A2_7, A3_8)
	local L4_9
	L4_9 = A0_5._queue
	L4_9 = L4_9.is_empty
	L4_9 = L4_9(L4_9)
	if L4_9 then
		return
	end
	L4_9 = A0_5._queue
	L4_9 = L4_9.pop_first
	L4_9 = L4_9(L4_9)
	if L4_9.kind == A0_5.TYPE_SAVE then
		A0_5:load_extensions(L4_9.saved)
		L4_9 = A0_5._queue:pop_first()
		assert(L4_9.kind ~= A0_5.TYPE_SAVE)
	end
	if L4_9.kind == A0_5.TYPE_INPUT then
		A0_5:receive_input(L4_9.input)
	end
end
function UnitControl.push_save(A0_10, A1_11)
	local L2_12
	L2_12 = {}
	L2_12.kind = A0_10.TYPE_SAVE
	L2_12.saved = TableAlgorithms.copy_if(A1_11, not_functions)
	A0_10._queue:push_last(L2_12)
end
function UnitControl.is_owned(A0_13)
	local L1_14
	L1_14 = true
	return L1_14
end
function UnitControl.push_input(A0_15, A1_16)
	local L2_17, L3_18
	L2_17 = TableAlgorithms
	L2_17 = L2_17.copy_if
	L3_18 = A1_16
	L2_17 = L2_17(L3_18, not_functions)
	L3_18 = {}
	L3_18.input = A1_16
	L3_18.kind = A0_15.TYPE_INPUT
	A0_15._queue:push_last(L3_18)
end
function UnitControl.unit_id(A0_19)
	local L1_20
	L1_20 = A0_19._unit_id
	return L1_20
end
function UnitControl.save_extensions(A0_21)
	local L1_22, L2_23, L3_24, L4_25, L5_26, L6_27, L7_28, L8_29, L9_30
	L1_22 = A0_21._unit
	L2_23 = L1_22
	L1_22 = L1_22.extensions
	L1_22 = L1_22(L2_23)
	L2_23 = {}
	L2_23.position = L3_24
	L2_23.rotation = L3_24
	L2_23.extension_data = L3_24
	for L6_27, L7_28 in L3_24(L4_25) do
		L8_29 = A0_21._unit
		L8_29 = L8_29[L7_28]
		L9_30 = A0_21._unit
		L8_29 = L8_29(L9_30)
		L9_30 = L8_29.save
		if L9_30 then
			L9_30 = L2_23.extension_data
			L9_30[L7_28] = {}
			L9_30 = L2_23.extension_data
			L9_30 = L9_30[L7_28]
			assert(L9_30)
			L8_29:save(L9_30)
			assert(L9_30)
		end
	end
	return L2_23
end
function UnitControl.load_extensions(A0_31, A1_32)
	local L2_33, L3_34, L4_35, L5_36, L6_37, L7_38, L8_39, L9_40
	L2_33 = A0_31._unit
	L2_33 = L2_33.set_position
	L2_33(L3_34, L4_35)
	L2_33 = A0_31._unit
	L2_33 = L2_33.set_rotation
	L2_33(L3_34, L4_35)
	L2_33 = A0_31._unit
	L2_33 = L2_33.extensions
	L2_33 = L2_33(L3_34)
	for L6_37, L7_38 in L3_34(L4_35) do
		L8_39 = A0_31._unit
		L8_39 = L8_39[L7_38]
		L9_40 = A0_31._unit
		L8_39 = L8_39(L9_40)
		L9_40 = L8_39.save
		if L9_40 then
			L9_40 = A1_32.extension_data
			L9_40 = L9_40[L7_38]
			assert(L9_40)
			L8_39:load(L9_40)
		end
	end
	L6_37 = false
	L3_34(L4_35, L5_36, L6_37)
end
function UnitControl.save_join(A0_41)
	local L1_42, L2_43
	L1_42 = save_extensions
	L1_42 = L1_42()
	L2_43 = TableSerializer
	L2_43 = L2_43.save
	L2_43 = L2_43(L1_42)
	A0_41._send:unit_save(A0_41._unit_id, L2_43)
end
function UnitControl.load_join(A0_44, A1_45)
end
function UnitControl.set_ai_controlled_keep_controller_wrapper(A0_46)
	A0_46:set_ai_controlled()
	A0_46._controller_wrapper = A0_46._controller_wrapper
end
function UnitControl.saved_controller_wrapper(A0_47)
	local L1_48
	L1_48 = A0_47._controller_wrapper
	return L1_48
end
function UnitControl.set_extensions_enabled(A0_49, A1_50, A2_51)
	local L3_52, L4_53, L5_54, L6_55, L7_56, L8_57, L9_58
	L3_52 = A0_49._unit
	L4_53 = L3_52.extensions
	L4_53 = L4_53(L5_54)
	for L8_57, L9_58 in L5_54(L6_55) do
		if TableAlgorithms.find_value(L9_58, L4_53) then
			L3_52:set_extension_update_enabled(L9_58, A2_51)
		end
	end
end
function UnitControl.set_ai_controlled(A0_59)
	managers.director:remove_non_ai_unit(A0_59._unit)
	A0_59._unit:ai_nerve_system():enable()
	A0_59._unit:camera_controller_interpreter():disable()
	A0_59._unit:camera():release_camera_input()
	A0_59._unit:controller_interpreter():disable()
	A0_59._unit:look():disable()
	A0_59._controller = UnitControl.controller.AI
	A0_59._controller_wrapper = nil
	A0_59:set_extensions_enabled({
		"controller_interpreter",
		"camera_controller_interpreter",
		"look",
		"control"
	}, false)
	A0_59:set_extensions_enabled({
		"ai_nerve_system"
	}, true)
	if A0_59._unit:player_data() and alive(A0_59._unit:player_data().on_rail_vehicle) then
		A0_59._unit:player_data().on_rail_vehicle:damage_data().no_lethal_damage = true
	end
end
function UnitControl.set_user_controlled(A0_60, A1_61)
	A0_60._unit:controller_interpreter():enable(A1_61)
	if A0_60._unit:ai_nerve_system() ~= nil then
		A0_60._unit:ai_nerve_system():disable()
	end
	A0_60._unit:camera():set_camera_input(A1_61)
	A0_60._unit:controller_interpreter():enable(A1_61)
	A0_60._unit:look():enable()
	A0_60._controller = UnitControl.controller.HUMAN
	managers.director:add_non_ai_unit(A0_60._unit)
	A0_60._controller_wrapper = A1_61
	A0_60:set_extensions_enabled({
		"controller_interpreter",
		"camera_controller_interpreter",
		"look",
		"control"
	}, true)
	A0_60:set_extensions_enabled({
		"ai_nerve_system"
	}, false)
	if A0_60._unit:player_data() and alive(A0_60._unit:player_data().on_rail_vehicle) then
		A0_60._unit:player_data().on_rail_vehicle:damage_data().no_lethal_damage = false
	end
end
function UnitControl.set_remote_controlled(A0_62)
	if not A0_62._unit:ai_nerve_system() then
		error("Unit " .. A0_62._unit:name() .. " should have a ai_nerve_system!")
	else
		A0_62._unit:ai_nerve_system():disable()
	end
	A0_62._unit:camera():release_camera_input()
	A0_62._unit:controller_interpreter():disable()
	A0_62._unit:look():disable()
	A0_62._controller = UnitControl.controller.HUMAN
	managers.director:add_non_ai_unit(A0_62._unit)
	A0_62:set_extensions_enabled({
		"controller_interpreter",
		"camera_controller_interpreter",
		"look",
		"ai_nerve_system"
	}, false)
	A0_62:set_extensions_enabled({"control"}, true)
end
function UnitControl.set_no_control(A0_63)
	managers.director:remove_non_ai_unit(A0_63._unit)
	A0_63._unit:ai_nerve_system():disable()
	A0_63._unit:camera():release_camera_input()
	A0_63._unit:controller_interpreter():disable()
	A0_63._controller = UnitControl.controller.NONE
	A0_63:set_extensions_enabled({
		"controller_interpreter",
		"camera_controller_interpreter",
		"look",
		"control",
		"ai_nerve_system"
	}, false)
end
function UnitControl.is_human_controlled(A0_64)
	local L2_65
	L2_65 = A0_64._controller
	L2_65 = L2_65 == UnitControl.controller.HUMAN
	return L2_65
end
function UnitControl.is_ai_controlled(A0_66)
	local L2_67
	L2_67 = A0_66._controller
	L2_67 = L2_67 == UnitControl.controller.AI
	return L2_67
end
