if not MachineSound then
	MachineSound = class()
end
MachineSound._get_sound = function(l_1_0, l_1_1)
	local l_1_2 = Sound:make_bank(l_1_0._soundbank_name, l_1_1)
	l_1_2:set_output(l_1_0._unit:get_object(l_1_0._sound_output_object_name))
	return l_1_2
end


