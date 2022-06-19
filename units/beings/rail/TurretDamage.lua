TurretDamage = TurretDamage or class(UnitDamage)
function TurretDamage.init(A0_0, A1_1, A2_2, A3_3, A4_4, A5_5, A6_6)
	A3_3 = A3_3 or {}
	UnitDamage.init(A0_0, A1_1, TurretBodyDamage, A3_3, A4_4, A5_5, A6_6)
	A0_0:set_update_callback("update_turret_damage", true)
	A0_0._brush = Draw:brush(Color(1, 0, 0))
	A0_0._brush:set_font("editor_font", 5)
	A0_0._health_regen_per_second = 0
	A0_0._health_regen_delay = 0
	A0_0._time_since_damage = 0
end
function TurretDamage.save(A0_7, A1_8)
	UnitDamage.save(A0_7, A1_8)
end
function TurretDamage.load(A0_9, A1_10)
	UnitDamage.load(A0_9, A1_10)
end
function TurretDamage.destroy(A0_11)
	local L1_12
end
function TurretDamage.dead(A0_13, A1_14)
end
function TurretDamage.add_damage(A0_15, A1_16, A2_17, A3_18, A4_19, A5_20, A6_21, A7_22, A8_23)
	UnitDamage.add_damage(A0_15, A1_16, A2_17, A3_18, A4_19, A5_20, A6_21, A7_22, A8_23)
	A0_15._unit:base():report_damage(A7_22, "turret")
	A0_15._time_since_damage = 0
	A0_15._last_hit_direction = A6_21
end
function TurretDamage.update_turret_damage(A0_24, A1_25, A2_26, A3_27, A4_28)
	A0_24._time_since_damage = A0_24._time_since_damage + A3_27
	if A1_25:damage_data():is_fully_damaged() then
		return
	end
	if A0_24._time_since_damage > A0_24._health_regen_delay and A1_25:damage_data().damage > 0 then
		A1_25:damage_data().damage = A1_25:damage_data().damage - A3_27 * A0_24._health_regen_per_second
		if A1_25:damage_data().damage < 0 then
			A1_25:damage_data().damage = 0
		end
	end
end
function TurretDamage.set_health_regen(A0_29, A1_30, A2_31)
	A0_29._health_regen_per_second = A1_30
	A0_29._health_regen_delay = A2_31
end
TurretBodyDamage = TurretBodyDamage or class(BodyDamage)
function TurretBodyDamage.init(A0_32, A1_33, A2_34, A3_35, A4_36)
	BodyDamage.init(A0_32, A1_33, A2_34, A3_35, A4_36, "human_flesh")
	A0_32._unit = A1_33
end
