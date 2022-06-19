require("units/beings/rail/RailDamage")
if not SkynetDefenceTurretDamage then
	SkynetDefenceTurretDamage = class(RailDamage)
end
local l_0_0 = SkynetDefenceTurretDamage
local l_0_1 = {}
local l_0_2 = {}
local l_0_3 = {}
local l_0_4 = {}
 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

local l_0_5 = {}
l_0_5.damage = 0.3
l_0_5.sequence_name = "medium_damage"
local l_0_6 = {}
l_0_6.damage = 0.7
l_0_6.sequence_name = "severe_damage"
l_0_4, l_0_3 = {damage = 0.1, sequence_name = "light_damage"}, {damage = 0, sequence_name = nil}
l_0_1.unit_damage_steps, l_0_2 = l_0_2, {l_0_3, l_0_4, l_0_5, l_0_6}
l_0_1.unit_destroyed_sequence = "kill_turret"
l_0_1.damage_unit = true
l_0_0._SKYNET_DEFENCE_TURRET = l_0_1
l_0_0 = SkynetDefenceTurretDamage
l_0_1 = function(l_1_0, l_1_1, l_1_2, l_1_3, l_1_4, l_1_5, l_1_6)
	RailDamage.init(l_1_0, l_1_1, BodyDamage, l_1_3, l_1_4, l_1_5, l_1_6)
	l_1_0:_setup_bodies()
end

l_0_0.init = l_0_1
l_0_0 = SkynetDefenceTurretDamage
l_0_1 = function(l_2_0)
	RailDamage._setup_body_group(l_2_0, SkynetDefenceTurretDamage._SKYNET_DEFENCE_TURRET)
end

l_0_0._setup_bodies = l_0_1
l_0_0 = SkynetDefenceTurretDamage
l_0_1 = function(l_3_0, l_3_1, l_3_2, l_3_3, l_3_4, l_3_5, l_3_6, l_3_7, l_3_8)
	local l_3_9 = l_3_0._unit:damage_data()
	local l_3_10 = l_3_0._unit:get_object(SkynetDefenceTurretBase._CENTER_OBJECT_NAME):position()
	local l_3_11 = l_3_10 - l_3_2:position():length()
	do
		local l_3_12, l_3_14, l_3_16 = l_3_0._invulnerable_range or 0
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	l_3_9.invulnerable = l_3_12 < l_3_11
	if l_3_2 and l_3_2:name() ~= l_3_0._unit:name() then
		RailDamage.add_damage(l_3_0, l_3_1, l_3_2, l_3_3, l_3_4, l_3_5, l_3_6, l_3_7, l_3_8)
	end
end

l_0_0.add_damage = l_0_1
l_0_0 = SkynetDefenceTurretDamage
l_0_1 = function(l_4_0, l_4_1)
	l_4_0._invulnerable_range = l_4_1
end

l_0_0.set_invulnerable_range = l_0_1
l_0_0 = SkynetDefenceTurretDamage
l_0_1 = function(l_5_0)
	return false
end

l_0_0.check_god_mode = l_0_1

