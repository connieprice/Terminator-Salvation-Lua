AMSyncedSound = AMSyncedSound or class(CoreActionElement)
require("shared/sound/SoundHolder")
function AMSyncedSound.init(A0_0, A1_1, A2_2)
	CoreActionElement.init(A0_0, A1_1, A2_2)
	managers.unit_scripting:define_unit(A0_0._name, "no_group")
end
function AMSyncedSound.activate_now(A0_3)
	local L1_4, L2_5
	L1_4 = Sound
	L2_5 = L1_4
	L1_4 = L1_4.make_bank
	L1_4 = L1_4(L2_5, A0_3.soundbank_name, A0_3.cue_name)
	if not L1_4 then
		L2_5 = Application
		L2_5 = L2_5.error
		L2_5(L2_5, "Sound " .. A0_3.cue_name .. " not found in soundbank " .. A0_3.soundbank_name)
		L2_5 = A0_3.deactivate_now
		L2_5(A0_3)
		return
	end
	L2_5 = World
	L2_5 = L2_5.spawn_unit
	L2_5 = L2_5(L2_5, "sound_holder", Vector3(0, 0, 0), Rotation(0, 0, 0))
	A0_3._unit = L2_5
	L2_5 = managers
	L2_5 = L2_5.unit_scripting
	L2_5 = L2_5.register_unit
	L2_5(L2_5, A0_3._name, A0_3._unit)
	L2_5 = Application
	L2_5 = L2_5.debug
	L2_5(L2_5, "AMSyncedSound play: " .. A0_3.cue_name .. " bank=" .. A0_3.soundbank_name)
	L2_5 = A0_3._unit
	L2_5 = L2_5.base
	L2_5 = L2_5(L2_5)
	L2_5 = L2_5.play_sound
	L2_5(L2_5, L1_4, A0_3.offset_time)
	L2_5 = A0_3.next_cue_name
	if L2_5 then
		L2_5 = A0_3.next_cue_name
		if L2_5 ~= "" then
			L2_5 = Sound
			L2_5 = L2_5.make_bank
			L2_5 = L2_5(L2_5, A0_3.soundbank_name, A0_3.next_cue_name)
			A0_3._unit:base():set_prime_sound(L2_5)
		end
	end
	L2_5 = nil
	if managers.unit_scripting:unit_exists(A0_3.previous_unit.script_name) then
		L2_5 = managers.unit_scripting:get_unit_by_name(A0_3.previous_unit.script_name)
	end
	if alive(L2_5) then
		if not A0_3.crossfade_time then
			A0_3.crossfade_time = 0
		end
		L2_5:base():cross_fade(A0_3.crossfade_time, 1, 0)
		L2_5:base():kill_later(A0_3.crossfade_time)
	end
	if A0_3.volume_set_name and A0_3.volume_set_name ~= "" then
		A0_3._unit:base():activate_volume_set(A0_3.volume_set_name)
	end
	A0_3:deactivate_now()
end
