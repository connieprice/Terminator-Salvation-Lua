if not AMSyncedSound then
	AMSyncedSound = class(CoreActionElement)
end
require("shared/sound/SoundHolder")
AMSyncedSound.init = function(l_1_0, l_1_1, l_1_2)
	CoreActionElement.init(l_1_0, l_1_1, l_1_2)
	managers.unit_scripting:define_unit(l_1_0._name, "no_group")
end

AMSyncedSound.activate_now = function(l_2_0)
	local l_2_1 = Sound:make_bank(l_2_0.soundbank_name, l_2_0.cue_name)
	if not l_2_1 then
		Application:error("Sound " .. l_2_0.cue_name .. " not found in soundbank " .. l_2_0.soundbank_name)
		l_2_0:deactivate_now()
		return 
	end
	l_2_0._unit = World:spawn_unit("sound_holder", Vector3(0, 0, 0), Rotation(0, 0, 0))
	managers.unit_scripting:register_unit(l_2_0._name, l_2_0._unit)
	Application:debug("AMSyncedSound play: " .. l_2_0.cue_name .. " bank=" .. l_2_0.soundbank_name)
	l_2_0._unit:base():play_sound(l_2_1, l_2_0.offset_time)
	if l_2_0.next_cue_name and l_2_0.next_cue_name ~= "" then
		local l_2_2 = Sound:make_bank(l_2_0.soundbank_name, l_2_0.next_cue_name)
		l_2_0._unit:base():set_prime_sound(l_2_2)
	end
	local l_2_3 = nil
	if managers.unit_scripting:unit_exists(l_2_0.previous_unit.script_name) then
		l_2_3 = managers.unit_scripting:get_unit_by_name(l_2_0.previous_unit.script_name)
	end
	if alive(l_2_3) then
		if not l_2_0.crossfade_time then
			l_2_0.crossfade_time = 0
		end
		l_2_3:base():cross_fade(l_2_0.crossfade_time, 1, 0)
		l_2_3:base():kill_later(l_2_0.crossfade_time)
	end
	if l_2_0.volume_set_name and l_2_0.volume_set_name ~= "" then
		l_2_0._unit:base():activate_volume_set(l_2_0.volume_set_name)
	end
	l_2_0:deactivate_now()
end


