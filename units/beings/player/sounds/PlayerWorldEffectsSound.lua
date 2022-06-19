PlayerWorldEffectsSound = PlayerWorldEffectsSound or class()
function PlayerWorldEffectsSound.init(A0_0, A1_1)
	A0_0._unit = A1_1
	A0_0._small_bullet_swish_sound = Sound:make_bank(A0_0._soundbank_name, "bullet_zip_small")
	A0_0._enabled = false
	A0_0:enable()
end
function PlayerWorldEffectsSound.destroy(A0_2, A1_3)
	A0_2:disable()
end
function PlayerWorldEffectsSound.unit_afro_hit(A0_4, A1_5, A2_6, A3_7, A4_8, A5_9)
	local L6_10
	L6_10 = tweak_data
	L6_10 = L6_10.player
	L6_10 = L6_10.world_sound
	L6_10 = L6_10.bullet_zip_by
	L6_10 = L6_10.EXTEND_DISTANCE
	L6_10 = A3_7 * L6_10
	L6_10 = A4_8 + L6_10
	A0_4._small_bullet_swish_sound:set_position(L6_10)
	A0_4._small_bullet_swish_sound_instance = A0_4._small_bullet_swish_sound:play()
end
function PlayerWorldEffectsSound.enable(A0_11)
	if not A0_11._enabled then
		managers.action_event:register_listener(A0_11, A0_11._unit, A0_11._unit)
		A0_11._enabled = true
	end
end
function PlayerWorldEffectsSound.disable(A0_12)
	if A0_12._enabled then
		managers.action_event:unregister_listener(A0_12)
		A0_12._enabled = false
	end
end
