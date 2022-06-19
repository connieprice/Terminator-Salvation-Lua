if not AMRumble then
	AMRumble = class(CoreActionElement)
end
AMRumble.init = function(l_1_0, l_1_1, l_1_2)
	CoreActionElement.init(l_1_0, l_1_1, l_1_2)
end

AMRumble.activate_now = function(l_2_0)
	local l_2_5 = nil
	local l_2_4 = managers.rumble:play
	l_2_4(managers.rumble, l_2_0.preset, l_2_0.position)
	l_2_4 = l_2_0.camera_shake
	if l_2_4 then
		l_2_4 = ipairs
		l_2_4 = l_2_4(l_2_0.preset.atoms)
		for i_0,i_1 in l_2_4 do
			local l_2_7 = managers.camera:play_shake_effect
			local l_2_8 = managers.camera
			l_2_7(l_2_8, {radius = l_2_0.preset.radius, scale = l_2_0.preset.scale, frequency = l_2_0.camera_frequency, peak = l_2_6.peak, attack = l_2_6.attack, sustain = l_2_6.sustain, release = l_2_6.release}, l_2_0.position)
		end
	end
	l_2_0:deactivate_now()
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end


