SkynetDefenceTurretInput = SkynetDefenceTurretInput or class()
function SkynetDefenceTurretInput.init(A0_0, A1_1)
	A0_0:clear()
end
function SkynetDefenceTurretInput.clear(A0_2)
	local L1_3
	A0_2._aim_target_position = nil
	A0_2._aim_target_position_missile = nil
	A0_2._fire_missile = false
	A0_2._fire_gatling = false
end
function SkynetDefenceTurretInput.fire_missile(A0_4)
	local L1_5
	L1_5 = A0_4._fire_missile
	return L1_5
end
function SkynetDefenceTurretInput.set_fire_missile(A0_6)
	local L1_7
	A0_6._fire_missile = true
end
function SkynetDefenceTurretInput.fire_gatling(A0_8)
	local L1_9
	L1_9 = A0_8._fire_gatling
	return L1_9
end
function SkynetDefenceTurretInput.set_fire_gatling(A0_10)
	local L1_11
	A0_10._fire_gatling = true
end
function SkynetDefenceTurretInput.aim_target_position(A0_12)
	local L1_13
	L1_13 = A0_12._aim_target_position
	return L1_13
end
function SkynetDefenceTurretInput.set_aim_target_position(A0_14, A1_15)
	A0_14._aim_target_position = A1_15
end
function SkynetDefenceTurretInput.aim_target_position_missile(A0_16)
	local L1_17
	L1_17 = A0_16._aim_target_position_missile
	return L1_17
end
function SkynetDefenceTurretInput.set_aim_target_position_missile(A0_18, A1_19)
	A0_18._aim_target_position_missile = A1_19
end
function SkynetDefenceTurretInput.miss_dispersion(A0_20)
	local L1_21
	L1_21 = A0_20._miss_dispersion
	return L1_21
end
function SkynetDefenceTurretInput.set_miss_dispersion(A0_22, A1_23)
	A0_22._miss_dispersion = A1_23
end
