require("units/beings/rail/RailDamage")
SkynetDefenceTurretDamage = SkynetDefenceTurretDamage or class(RailDamage)
SkynetDefenceTurretDamage._SKYNET_DEFENCE_TURRET = {
	bodies = {
		{
			body_names = {
				"b_turret_col"
			},
			name = "whole_turret",
			destroyed_sequence_name = "kill_turret",
			hp = 77777
		}
	},
	unit_damage_steps = {
		{damage = 0, sequence_name = nil},
		{
			damage = 0.1,
			sequence_name = "light_damage"
		},
		{
			damage = 0.3,
			sequence_name = "medium_damage"
		},
		{
			damage = 0.7,
			sequence_name = "severe_damage"
		}
	},
	unit_destroyed_sequence = "kill_turret",
	damage_unit = true
}
function SkynetDefenceTurretDamage.init(A0_0, A1_1, A2_2, A3_3, A4_4, A5_5, A6_6)
	RailDamage.init(A0_0, A1_1, BodyDamage, A3_3, A4_4, A5_5, A6_6)
	A0_0:_setup_bodies()
end
function SkynetDefenceTurretDamage._setup_bodies(A0_7)
	RailDamage._setup_body_group(A0_7, SkynetDefenceTurretDamage._SKYNET_DEFENCE_TURRET)
end
function SkynetDefenceTurretDamage.add_damage(A0_8, A1_9, A2_10, A3_11, A4_12, A5_13, A6_14, A7_15, A8_16)
	A0_8._unit:damage_data().invulnerable = (A0_8._unit:get_object(SkynetDefenceTurretBase._CENTER_OBJECT_NAME):position() - A2_10:position()):length() > (A0_8._invulnerable_range or 0)
	if A2_10 and A2_10:name() ~= A0_8._unit:name() then
		RailDamage.add_damage(A0_8, A1_9, A2_10, A3_11, A4_12, A5_13, A6_14, A7_15, A8_16)
	end
end
function SkynetDefenceTurretDamage.set_invulnerable_range(A0_17, A1_18)
	A0_17._invulnerable_range = A1_18
end
function SkynetDefenceTurretDamage.check_god_mode(A0_19)
	local L1_20
	L1_20 = false
	return L1_20
end
