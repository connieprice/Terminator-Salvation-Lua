MachineSound = MachineSound or class()
function MachineSound._get_sound(A0_0, A1_1)
	Sound:make_bank(A0_0._soundbank_name, A1_1):set_output(A0_0._unit:get_object(A0_0._sound_output_object_name))
	return (Sound:make_bank(A0_0._soundbank_name, A1_1))
end
