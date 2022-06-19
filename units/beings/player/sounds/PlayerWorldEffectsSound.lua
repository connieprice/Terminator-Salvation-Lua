if not PlayerWorldEffectsSound then
	PlayerWorldEffectsSound = class()
end
PlayerWorldEffectsSound.init = function(l_1_0, l_1_1)
	l_1_0._unit = l_1_1
	l_1_0._small_bullet_swish_sound = Sound:make_bank(l_1_0._soundbank_name, "bullet_zip_small")
	l_1_0._enabled = false
	l_1_0:enable()
end

PlayerWorldEffectsSound.destroy = function(l_2_0, l_2_1)
	l_2_0:disable()
end

PlayerWorldEffectsSound.unit_afro_hit = function(l_3_0, l_3_1, l_3_2, l_3_3, l_3_4, l_3_5)
	local l_3_6 = l_3_4 + l_3_3 * tweak_data.player.world_sound.bullet_zip_by.EXTEND_DISTANCE
	l_3_0._small_bullet_swish_sound:set_position(l_3_6)
	l_3_0._small_bullet_swish_sound_instance = l_3_0._small_bullet_swish_sound:play()
end

PlayerWorldEffectsSound.enable = function(l_4_0)
	if not l_4_0._enabled then
		managers.action_event:register_listener(l_4_0, l_4_0._unit, l_4_0._unit)
		l_4_0._enabled = true
	end
end

PlayerWorldEffectsSound.disable = function(l_5_0)
	if l_5_0._enabled then
		managers.action_event:unregister_listener(l_5_0)
		l_5_0._enabled = false
	end
end


