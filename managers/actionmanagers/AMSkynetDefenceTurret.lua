require("managers/actionmanagers/AiUnitSpawn")
AMSkynetDefenceTurret = AMSkynetDefenceTurret or class(AiUnitSpawn)
function AMSkynetDefenceTurret.init(A0_0, A1_1, A2_2)
	AiUnitSpawn.init(A0_0, A1_1, A2_2)
	if A0_0._mode == "spawn" then
		A0_0:setup("skynet_defence_turret")
	end
end
function AMSkynetDefenceTurret._setup_ai(A0_3, A1_4)
	local L2_5, L3_6
	L2_5 = A0_3.brain_name
	if L2_5 == "rail" then
		L3_6 = A0_3
		L2_5 = A0_3.setup_rail_unit
		L2_5(L3_6, A1_4)
	else
	end
	L3_6 = A1_4
	L2_5 = A1_4.ai_data
	L2_5 = L2_5(L3_6)
	L3_6 = A0_3.brain_name
	L3_6 = L3_6 or SkynetDefenceTurretHubElementData.brain_names[1]
	A1_4:ai_nerve_system():setup(L3_6)
	if not A0_3.units then
		return
	end
	AiUnitSpawn._setup_ai(A0_3, A1_4)
end
function AMSkynetDefenceTurret.setup_rail_unit(A0_7, A1_8)
	local L2_9, L3_10, L4_11
	L3_10 = A1_8
	L2_9 = A1_8.ai_data
	L2_9 = L2_9(L3_10)
	L4_11 = A1_8
	L3_10 = A1_8.damage
	L3_10 = L3_10(L4_11)
	L4_11 = tonumber
	L4_11 = L4_11(A0_7.attack_range)
	L4_11 = L4_11 or 0
	L4_11 = L4_11 * 100
	L2_9.default_attack_range = L4_11
	L4_11 = tonumber
	L4_11 = L4_11(A0_7.attack_delay)
	L4_11 = L4_11 or 0
	L2_9.default_attack_delay = L4_11
	L4_11 = A0_7._get_units_by_names
	L4_11 = L4_11(A0_7, A0_7.targets)
	L4_11 = L4_11 or {}
	L2_9.default_forced_target_units = L4_11
	L4_11 = tonumber
	L4_11 = L4_11(A0_7.invulnerable_range)
	L4_11 = L4_11 or 0
	L4_11 = L4_11 * 100
	L3_10:set_invulnerable_range(L4_11)
end
function AMSkynetDefenceTurret._get_units_by_names(A0_12, A1_13)
	local L2_14, L3_15, L4_16, L5_17, L6_18, L7_19, L8_20
	L2_14 = {}
	for L6_18, L7_19 in L3_15(L4_16) do
		L8_20 = managers
		L8_20 = L8_20.unit_scripting
		L8_20 = L8_20.get_unit_by_name
		L8_20 = L8_20(L8_20, L7_19.script_name)
		table.insert(L2_14, L8_20)
	end
	return L2_14
end
