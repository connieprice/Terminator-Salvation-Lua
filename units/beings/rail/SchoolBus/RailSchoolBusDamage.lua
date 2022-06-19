require("units/beings/rail/RailDamage")
RailSchoolBusDamage = RailSchoolBusDamage or class(RailDamage)
RailSchoolBusDamage._PARTS = {
	bodies = {
		{
			body_names = {"ray_coll"},
			name = "ray_coll",
			destroyed_sequence_name = "kill_vehicle",
			hp = 150000
		}
	},
	damage_unit = true,
	unit_destroyed_sequence = "kill_vehicle",
	unit_damage_steps = {
		{
			damage = 0,
			sequence_name = "dmg_state_0",
			to_lower = nil,
			to_higher = "panic"
		},
		{
			damage = 0.2,
			sequence_name = "dmg_state_1",
			to_lower = "idle",
			to_higher = "panic"
		},
		{
			damage = 0.35,
			sequence_name = "dmg_state_2",
			to_lower = "idle",
			to_higher = "panic"
		},
		{
			damage = 0.55,
			sequence_name = "dmg_state_3",
			to_lower = "idle",
			to_higher = "panic"
		},
		{
			damage = 0.75,
			sequence_name = "dmg_state_4",
			to_lower = "idle",
			to_higher = nil
		}
	}
}
function RailSchoolBusDamage.init(A0_0, A1_1, A2_2, A3_3, A4_4, A5_5, A6_6)
	RailDamage.init(A0_0, A1_1, BodyDamage, A3_3, A4_4, A5_5, A6_6)
	A0_0:_setup_bodies()
end
function RailSchoolBusDamage._setup_bodies(A0_7)
	RailDamage._setup_body_group(A0_7, RailSchoolBusDamage._PARTS)
end
function RailSchoolBusDamage.add_damage(A0_8, A1_9, A2_10, A3_11, A4_12, A5_13, A6_14, A7_15, A8_16)
	if alive(A2_10) and A2_10:slot() == 2 then
		A7_15 = A7_15 * tweak_data.rail.vehicle.rail_vehicle_school_bus.FRIENDLY_DAMAGE_MULTIPLICATOR
	end
	RailDamage.add_damage(A0_8, A1_9, A2_10, A3_11, A4_12, A5_13, A6_14, A7_15, A8_16)
end
function RailSchoolBusDamage.check_god_mode(A0_17)
	A0_17._player_in_vehicle = A0_17._player_in_vehicle or managers.unit_scripting:get_unit_by_name("character_slot1")
	if A0_17._player_in_vehicle and A0_17._player_in_vehicle:damage():immune_to_damage() then
		return true
	end
	return false
end
