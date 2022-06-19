require("managers/actionmanagers/AiUnitSpawn")
if not AMSkynetDefenceTurret then
	AMSkynetDefenceTurret = class(AiUnitSpawn)
end
AMSkynetDefenceTurret.init = function(l_1_0, l_1_1, l_1_2)
	AiUnitSpawn.init(l_1_0, l_1_1, l_1_2)
	if l_1_0._mode == "spawn" then
		l_1_0:setup("skynet_defence_turret")
	end
end

AMSkynetDefenceTurret._setup_ai = function(l_2_0, l_2_1)
	if l_2_0.brain_name == "rail" then
		l_2_0:setup_rail_unit(l_2_1)
	end
	local l_2_2 = l_2_1:ai_data()
	if not l_2_0.brain_name then
		local l_2_3, l_2_4, l_2_5 = SkynetDefenceTurretHubElementData.brain_names[1]
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	l_2_1:ai_nerve_system():setup(l_2_3)
	if not l_2_0.units then
		return 
	end
	AiUnitSpawn._setup_ai(l_2_0, l_2_1)
end

AMSkynetDefenceTurret.setup_rail_unit = function(l_3_0, l_3_1)
	local l_3_2 = l_3_1:ai_data()
	local l_3_3 = l_3_1:damage()
	l_3_2.default_attack_range = (tonumber(l_3_0.attack_range) or 0) * 100
	l_3_2.default_attack_delay = tonumber(l_3_0.attack_delay) or 0
	if not l_3_0:_get_units_by_names(l_3_0.targets) then
		l_3_2.default_forced_target_units = {}
	end
	local l_3_4 = (tonumber(l_3_0.invulnerable_range) or 0) * 100
	l_3_3:set_invulnerable_range(l_3_4)
end

AMSkynetDefenceTurret._get_units_by_names = function(l_4_0, l_4_1)
	local l_4_6, l_4_7, l_4_8, l_4_9 = nil
	local l_4_2 = {}
	for i_0,i_1 in pairs(l_4_1) do
		table.insert(l_4_2, managers.unit_scripting:get_unit_by_name(i_1.script_name))
	end
	return l_4_2
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end


