PlayerHudData = PlayerHudData or class()
function PlayerHudData.init(A0_0, A1_1)
	A0_0._default_reticule_type = "circle_reticule"
end
function PlayerHudData.texture_name(A0_2)
	local L1_3
	L1_3 = A0_2._texture_name
	return L1_3
end
function PlayerHudData.small_texture_name(A0_4)
	local L1_5
	L1_5 = A0_4._small_texture_name
	return L1_5
end
function PlayerHudData.reticule_type(A0_6)
	return A0_6._reticule_type or A0_6._default_reticule_type
end
