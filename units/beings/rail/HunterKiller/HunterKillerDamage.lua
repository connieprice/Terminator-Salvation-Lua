require("units/beings/rail/RailDamage")
HunterKillerDamage = HunterKillerDamage or class(RailDamage)
HunterKillerDamage._PARTS = {
	bodies = {
		{
			body_names = {
				"hz_sensor_left"
			},
			name = "sensor_left",
			destroyed_sequence_name = "kill_sensor_left",
			zone = "sensor_left",
			hp = tweak_data.enemy.hk.SENSOR_POD_ENDURANCE
		},
		{
			body_names = {
				"hz_sensor_right"
			},
			name = "sensor_right",
			destroyed_sequence_name = "kill_sensor_right",
			zone = "sensor_right",
			hp = tweak_data.enemy.hk.SENSOR_POD_ENDURANCE
		},
		{
			body_names = {
				"hz_turret_front_left"
			},
			name = "turret_front_left",
			destroyed_sequence_name = "kill_turret_left",
			zone = "turret_front_left",
			hp = tweak_data.enemy.hk.PLASMA_CANNON_ENDURANCE
		},
		{
			body_names = {
				"hz_turret_front_right"
			},
			name = "turret_front_right",
			destroyed_sequence_name = "kill_turret_right",
			zone = "turret_front_right",
			hp = tweak_data.enemy.hk.PLASMA_CANNON_ENDURANCE
		},
		{
			body_names = {
				"hz_engine_left"
			},
			name = "engine_left",
			destroyed_sequence_name = "damage_engine_left",
			zone = "engine_left",
			hp = tweak_data.enemy.hk.ENGINE_ENDURANCE
		},
		{
			body_names = {
				"hz_engine_right"
			},
			name = "engine_right",
			destroyed_sequence_name = "damage_engine_right",
			zone = "engine_right",
			hp = tweak_data.enemy.hk.ENGINE_ENDURANCE
		},
		{
			body_names = {
				"hz_sensor_front"
			},
			name = "sensor_front",
			destroyed_sequence_name = "kill_sensor_front",
			zone = "sensor_front",
			hp = tweak_data.enemy.hk.SENSOR_POD_ENDURANCE
		},
		{
			body_names = {
				"hz_turret_back"
			},
			name = "turret_back",
			destroyed_sequence_name = "kill_turret_back",
			zone = "turret_back",
			hp = tweak_data.enemy.hk.PLASMA_CANNON_ENDURANCE * 3
		},
		{
			body_names = {"b_body_1"},
			name = "health_limited",
			destroyed_sequence_name = "kill_turret_back",
			zone = "health_limited",
			hp = 9.9999998E16
		}
	},
	damage_unit = true,
	unit_destroyed_sequence = "kill_vehicle"
}
function HunterKillerDamage._set_parts_dynamic(A0_0)
	local L1_1
	L1_1 = managers
	L1_1 = L1_1.player_slot
	L1_1 = L1_1.number_of_occupied_slots
	L1_1 = L1_1(L1_1)
	if L1_1 == 2 then
		L1_1 = "_COOP"
	else
		L1_1 = L1_1 or ""
	end
	HunterKillerDamage._PARTS.bodies[1].hp = tweak_data.enemy.hk["SENSOR_POD_ENDURANCE" .. L1_1] or tweak_data.enemy.hk.SENSOR_POD_ENDURANCE
	HunterKillerDamage._PARTS.bodies[2].hp = tweak_data.enemy.hk["SENSOR_POD_ENDURANCE" .. L1_1] or tweak_data.enemy.hk.SENSOR_POD_ENDURANCE
	HunterKillerDamage._PARTS.bodies[3].hp = tweak_data.enemy.hk["PLASMA_CANNON_ENDURANCE" .. L1_1] or tweak_data.enemy.hk.PLASMA_CANNON_ENDURANCE
	HunterKillerDamage._PARTS.bodies[4].hp = tweak_data.enemy.hk["PLASMA_CANNON_ENDURANCE" .. L1_1] or tweak_data.enemy.hk.PLASMA_CANNON_ENDURANCE
	HunterKillerDamage._PARTS.bodies[5].hp = tweak_data.enemy.hk["ENGINE_ENDURANCE" .. L1_1] or tweak_data.enemy.hk.ENGINE_ENDURANCE
	HunterKillerDamage._PARTS.bodies[6].hp = tweak_data.enemy.hk["ENGINE_ENDURANCE" .. L1_1] or tweak_data.enemy.hk.ENGINE_ENDURANCE
	HunterKillerDamage._PARTS.bodies[7].hp = tweak_data.enemy.hk["SENSOR_POD_ENDURANCE" .. L1_1] or tweak_data.enemy.hk.SENSOR_POD_ENDURANCE
	HunterKillerDamage._PARTS.bodies[8].hp = tweak_data.enemy.hk["PLASMA_CANNON_ENDURANCE" .. L1_1] or tweak_data.enemy.hk.PLASMA_CANNON_ENDURANCE
	if tweak_data.rail.vehicle.DEBUG then
		cat_debug("rail", "SPAWNING" .. L1_1 .. " " .. "hunter_killer")
		for 