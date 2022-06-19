require("units/beings/rail/RailDamage")
BikerDamage = BikerDamage or class(RailDamage)
BikerDamage._BIKE = {
	bodies = {
		{
			body_names = {
				"b_chassi_ray"
			},
			name = "whole_darn_bike",
			destroyed_sequence_name = "kill_vehicle_spin",
			hp = 77777
		}
	},
	unit_destroyed_sequence = "kill_vehicle_spin",
	bullseye_kill_sequence = "kill_vehicle_explode",
	damage_unit = true,
	unit_damage_steps = {
		{damage = 0, sequence_name = nil},
		{
			damage = 0.05,
			sequence_name = "light_damage"
		},
		{
			damage = 0.49,
			sequence_name = "severe_damage"
		}
	}
}
function BikerDamage.init(A0_0, A1_1, A2_2, A3_3, A4_4, A5_5, A6_6)
	RailDamage.init(A0_0, A1_1, BodyDamage, A3_3, A4_4, A5_5, A6_6)
	A0_0:_setup_bodies()
	A0_0._outline_weakspots = {}
	A0_0._outline_weakspots[1] = {
		body_name = "b_chassi_ray",
		obj = A0_0._unit:get_object("g_outline_biker")
	}
end
function BikerDamage._setup_bodies(A0_7)
	RailDamage._setup_body_group(A0_7, BikerDamage._BIKE)
end
function BikerDamage.check_outline_weakspot(A0_8, A1_9)
	if A0_8._outline_weakspots then
		for 