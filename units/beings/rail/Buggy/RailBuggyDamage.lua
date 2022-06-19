require("units/beings/rail/RailDamage")
RailBuggyDamage = RailBuggyDamage or class(RailDamage)
RailBuggyDamage._PARTS = {
	bodies = {
		{
			body_names = {
				"b_chassi_ray"
			},
			name = "chassie",
			destroyed_sequence_name = "kill_vehicle",
			hp = 50000
		}
	},
	unit_damage_steps = {
		{
			damage = 0,
			sequence_name = "dmg_state_0"
		},
		{
			damage = 0.2,
			sequence_name = "dmg_state_1"
		},
		{
			damage = 0.5,
			sequence_name = "dmg_state_2"
		},
		{
			damage = 0.7,
			sequence_name = "dmg_state_3"
		}
	},
	damage_unit = true,
	unit_destroyed_sequence = "kill_vehicle"
}
function RailBuggyDamage.init(A0_0, A1_1, A2_2, A3_3, A4_4, A5_5, A6_6)
	RailDamage.init(A0_0, A1_1, BodyDamage, A3_3, A4_4, A5_5, A6_6)
	A0_0:_setup_bodies()
end
function RailBuggyDamage._setup_bodies(A0_7)
	RailDamage._setup_body_group(A0_7, RailBuggyDamage._PARTS)
end
function RailBuggyDamage.add_damage(A0_8, A1_9, A2_10, A3_11, A4_12, A5_13, A6_14, A7_15, A8_16)
	if alive(A2_10) and A2_10:slot() == 2 then
		A7_15 = A7_15 * tweak_data.rail.vehicle.rail_vehicle_buggy.FRIENDLY_DAMAGE_MULTIPLICATOR
	end
	if tweak_data.rail.vehicle.rail_vehicle_buggy.NO_LETHAL_DAMAGE and alive(A0_8._unit) then
		A0_8._unit:damage_data().no_lethal_damage = true
	end
	RailDamage.add_damage(A0_8, A1_9, A2_10, A3_11, A4_12, A5_13, A6_14, A7_15, A8_16)
end
