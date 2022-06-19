require("shared/TableAlgorithms")
require("shared/Queue")
require("network/Peer")
if not UnitControl then
	UnitControl = class()
end
not_functions = function(l_1_0)
		return type(l_1_0) ~= "function"
  end
UnitControl.controller = {}
UnitControl.controller.HUMAN = 0
UnitControl.controller.AI = 1
UnitControl.controller.NONE = 2
UnitControl.init = function(l_2_0, l_2_1)
	l_2_0._unit = l_2_1
	l_2_0._unit_id = managers.unit_control_id:get_unit_id(l_2_0._unit)
	l_2_0._queue = Queue:new()
	l_2_0._send = Network:self()
	l_2_0.TYPE_INPUT = 1
	l_2_0.TYPE_SAVE = 2
	l_2_0._controller = UnitControl.controller.NONE
end

UnitControl.destroy = function(l_3_0, l_3_1)
	managers.unit_control_id:free_unit_id(l_3_0._unit)
	l_3_0._unit_id = 0
end

UnitControl.update = function(l_4_0, l_4_1, l_4_2, l_4_3)
	if l_4_0._queue:is_empty() then
		return 
	end
	local l_4_4 = l_4_0._queue:pop_first()
	if l_4_4.kind == l_4_0.TYPE_SAVE then
		l_4_0:load_extensions(l_4_4.saved)
		l_4_4 = l_4_0._queue:pop_first()
		local l_4_5 = assert
		l_4_5(l_4_4.kind ~= l_4_0.TYPE_SAVE)
	end
	if l_4_4.kind == l_4_0.TYPE_INPUT then
		l_4_0:receive_input(l_4_4.input)
	end
end

UnitControl.push_save = function(l_5_0, l_5_1)
	local l_5_2 = {}
	l_5_2.kind = l_5_0.TYPE_SAVE
	l_5_2.saved = TableAlgorithms.copy_if(l_5_1, not_functions)
	l_5_0._queue:push_last(l_5_2)
end

UnitControl.is_owned = function(l_6_0)
	return true
end

UnitControl.push_input = function(l_7_0, l_7_1)
	local l_7_2 = TableAlgorithms.copy_if(l_7_1, not_functions)
	local l_7_3 = {}
	l_7_3.input = l_7_1
	l_7_3.kind = l_7_0.TYPE_INPUT
	l_7_0._queue:push_last(l_7_3)
end

UnitControl.unit_id = function(l_8_0)
	return l_8_0._unit_id
end

UnitControl.save_extensions = function(l_9_0)
	local l_9_6, l_9_7, l_9_8, l_9_9 = nil
	local l_9_1 = l_9_0._unit:extensions()
	local l_9_2 = {}
	l_9_2.position = l_9_0._unit:position()
	l_9_2.rotation = l_9_0._unit:rotation()
	l_9_2.extension_data = {}
	for i_0,i_1 in pairs(l_9_1) do
		if l_9_0._unit[i_1](l_9_0._unit).save then
			l_9_2.extension_data[i_1] = {}
			assert(l_9_2.extension_data[i_1])
			 -- DECOMPILER ERROR: Confused about usage of registers!

			l_9_0._unit[i_1](l_9_0._unit):save(l_9_2.extension_data[i_1])
			 -- DECOMPILER ERROR: Confused about usage of registers!

			assert(l_9_2.extension_data[i_1])
		end
	end
	return l_9_2
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

UnitControl.load_extensions = function(l_10_0, l_10_1)
	local l_10_6, l_10_7, l_10_8, l_10_9, l_10_10, l_10_11 = nil
	l_10_0._unit:set_position(l_10_1.position)
	l_10_0._unit:set_rotation(l_10_1.rotation)
	local l_10_2 = l_10_0._unit:extensions()
	for i_0,i_1 in pairs(l_10_2) do
		if l_10_0._unit[i_1](l_10_0._unit).save then
			assert(l_10_1.extension_data[i_1])
			 -- DECOMPILER ERROR: Confused about usage of registers!

			l_10_0._unit[i_1](l_10_0._unit):load(l_10_1.extension_data[i_1])
		end
	end
	l_10_0._unit:set_extension_update_enabled("controller_interpreter", false)
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

UnitControl.save_join = function(l_11_0)
	local l_11_1 = save_extensions()
	local l_11_2 = TableSerializer.save(l_11_1)
	l_11_0._send:unit_save(l_11_0._unit_id, l_11_2)
end

UnitControl.load_join = function(l_12_0, l_12_1)
	 -- WARNING: undefined locals caused missing assignments!
end

UnitControl.set_ai_controlled_keep_controller_wrapper = function(l_13_0)
	local l_13_1 = l_13_0._controller_wrapper
	l_13_0:set_ai_controlled()
	l_13_0._controller_wrapper = l_13_1
end

UnitControl.saved_controller_wrapper = function(l_14_0)
	return l_14_0._controller_wrapper
end

UnitControl.set_extensions_enabled = function(l_15_0, l_15_1, l_15_2)
	local l_15_8, l_15_9, l_15_10, l_15_11, l_15_12, l_15_13 = nil
	local l_15_3 = l_15_0._unit
	local l_15_4 = l_15_3:extensions()
	for i_0,i_1 in pairs(l_15_1) do
		if TableAlgorithms.find_value(i_1, l_15_4) then
			l_15_3:set_extension_update_enabled(i_1, l_15_2)
		end
	end
end

UnitControl.set_ai_controlled = function(l_16_0)
	managers.director:remove_non_ai_unit(l_16_0._unit)
	l_16_0._unit:ai_nerve_system():enable()
	l_16_0._unit:camera_controller_interpreter():disable()
	l_16_0._unit:camera():release_camera_input()
	l_16_0._unit:controller_interpreter():disable()
	l_16_0._unit:look():disable()
	l_16_0._controller = UnitControl.controller.AI
	l_16_0._controller_wrapper = nil
	local l_16_1, l_16_2 = l_16_0:set_extensions_enabled, l_16_0
	do
		local l_16_3 = {}
		 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

		l_16_1(l_16_2, l_16_3, false)
		l_16_1(l_16_2, l_16_3, true)
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

	end
	if l_16_1 and l_16_1 then
		 -- WARNING: undefined locals caused missing assignments!
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 71 
end

UnitControl.set_user_controlled = function(l_17_0, l_17_1)
	l_17_0._unit:controller_interpreter():enable(l_17_1)
	if l_17_0._unit:ai_nerve_system() ~= nil then
		l_17_0._unit:ai_nerve_system():disable()
	end
	l_17_0._unit:camera():set_camera_input(l_17_1)
	l_17_0._unit:controller_interpreter():enable(l_17_1)
	l_17_0._unit:look():enable()
	l_17_0._controller = UnitControl.controller.HUMAN
	managers.director:add_non_ai_unit(l_17_0._unit)
	l_17_0._controller_wrapper = l_17_1
	local l_17_2, l_17_3 = l_17_0:set_extensions_enabled, l_17_0
	do
		local l_17_4 = {}
		 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

		l_17_2(l_17_3, l_17_4, true)
		l_17_2(l_17_3, l_17_4, false)
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

	end
	if l_17_2 and l_17_2 then
		 -- WARNING: undefined locals caused missing assignments!
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 79 
end

UnitControl.set_remote_controlled = function(l_18_0)
	if not l_18_0._unit:ai_nerve_system() then
		error("Unit " .. l_18_0._unit:name() .. " should have a ai_nerve_system!")
	else
		l_18_0._unit:ai_nerve_system():disable()
	end
	l_18_0._unit:camera():release_camera_input()
	l_18_0._unit:controller_interpreter():disable()
	l_18_0._unit:look():disable()
	l_18_0._controller = UnitControl.controller.HUMAN
	managers.director:add_non_ai_unit(l_18_0._unit)
	local l_18_1, l_18_2 = l_18_0:set_extensions_enabled, l_18_0
	do
		local l_18_3 = {}
		 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

		l_18_1(l_18_2, l_18_3, false)
		l_18_1(l_18_2, l_18_3, true)
	end
	 -- WARNING: undefined locals caused missing assignments!
end

UnitControl.set_no_control = function(l_19_0)
	managers.director:remove_non_ai_unit(l_19_0._unit)
	l_19_0._unit:ai_nerve_system():disable()
	l_19_0._unit:camera():release_camera_input()
	l_19_0._unit:controller_interpreter():disable()
	l_19_0._controller = UnitControl.controller.NONE
	local l_19_1, l_19_2 = l_19_0:set_extensions_enabled, l_19_0
	do
		local l_19_3 = {}
		 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

		l_19_1(l_19_2, l_19_3, false)
	end
	 -- WARNING: undefined locals caused missing assignments!
end

UnitControl.is_human_controlled = function(l_20_0)
	return l_20_0._controller == UnitControl.controller.HUMAN
end

UnitControl.is_ai_controlled = function(l_21_0)
	return l_21_0._controller == UnitControl.controller.AI
end


