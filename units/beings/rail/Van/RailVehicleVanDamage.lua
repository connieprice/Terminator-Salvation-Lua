require("units/beings/rail/RailDamage")
RailVehicleVanDamage = RailVehicleVanDamage or class(RailDamage)
RailVehicleVanDamage._PARTS = {
	bodies = {
		{
			body_names = {
				"default_body"
			},
			name = "default_body",
			hp = 22500
		}
	},
	unit_destroyed_sequence = "kill_vehicle",
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
			damage = 0.65,
			sequence_name = "dmg_state_2"
		},
		{
			damage = 1,
			sequence_name = "dmg_state_3"
		}
	},
	damage_unit = true
}
function RailVehicleVanDamage.init(A0_0, A1_1, A2_2, A3_3, A4_4, A5_5, A6_6)
	RailDamage.init(A0_0, A1_1, BodyDamage, A3_3, A4_4, A5_5, A6_6)
	A0_0:_setup_bodies()
end
function RailVehicleVanDamage._setup_bodies(A0_7)
	RailDamage._setup_body_group(A0_7, RailVehicleVanDamage._PARTS)
end
function RailVehicleVanDamage.add_damage(A0_8, A1_9, A2_10, A3_11, A4_12, A5_13, A6_14, A7_15, A8_16)
	if alive(A2_10) and A2_10:name() == "rail_walker_driver" then
		return
	end
	RailDamage.add_damage(A0_8, A1_9, A2_10, A3_11, A4_12, A5_13, A6_14, A7_15, A8_16)
end
