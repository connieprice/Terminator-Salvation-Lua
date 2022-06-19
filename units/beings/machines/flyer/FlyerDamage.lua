local L0_0
L0_0 = require
L0_0("units/UnitDamage")
L0_0 = require
L0_0("units/damage/StunDamage")
L0_0 = require
L0_0("units/damage/StunBodySetup")
L0_0 = require
L0_0("TweakData")
L0_0 = tweak_data
L0_0 = L0_0.enemy
L0_0 = L0_0.flyer
FlyerDamage = FlyerDamage or class(UnitDamage)
function FlyerDamage.init(A0_1, A1_2)
	UnitDamage.init(A0_1, A1_2)
	A0_1._time_until_next_hurt = 0
	A0_1:register_damage_callback(function(A0_3, A1_4, A2_5, A3_6, A4_7, A5_8)
		_UPVALUE0_:_on_damage(A0_3, A1_4, A2_5, A3_6, A5_8)
	end)
	A0_1._stun_damage = StunDamage:new(A1_2, A0_1, _UPVALUE0_)
	A0_1._outline_weakspots = {}
	A0_1._emitter = managers.action_event:create_emitter(A1_2)
	A0_1._outline_weakspots[1] = {
		body_name = "default_body",
		obj = A0_1._unit:get_object("g_outline")
	}
	A0_1._unit:damage_data().health = tweak_data.enemy.flyer.HEALTH
end
function FlyerDamage.destroy(A0_9)
	A0_9._stun_damage:destroy()
end
function FlyerDamage.fully_damaged(A0_10, A1_11)
	A0_10._unit:set_slot(6)
end
function FlyerDamage.update_damage(A0_12, A1_13, A2_14, A3_15)
	A0_12._time_until_next_hurt = A0_12._time_until_next_hurt - A3_15
	A0_12._stun_damage:update(A3_15)
end
function FlyerDamage._on_damage(A0_16, A1_17, A2_18, A3_19, A4_20, A5_21)
	local L6_22, L7_23
	L6_22 = A0_16._time_until_next_hurt
	if L6_22 <= 0 and A1_17 > 0 and A5_21 then
		L7_23 = A3_19
		L6_22 = A3_19.with_z
		L6_22 = L6_22(L7_23, 0)
		L7_23 = L6_22
		L6_22 = L6_22.normalized
		L6_22 = L6_22(L7_23)
		L7_23 = L6_22.cross
		L7_23 = L7_23(L6_22, math.UP)
		if 0 < (A2_18 - A5_21:center_of_mass()):dot(L7_23) then
			A2_18 = A2_18 - 0.5 * (A2_18 - A5_21:center_of_mass()) + 60 * L7_23
			L6_22 = (L6_22 - L7_23):normalized()
		else
			A2_18 = A2_18 - 0.5 * (A2_18 - A5_21:center_of_mass()) - 60 * L7_23
			L6_22 = (L6_22 + L7_23):normalized()
		end
		A0_16._unit:push_at(_UPVALUE0_.IMPACT_MASS, L6_22 * _UPVALUE0_.IMPACT_VELOCITY, A2_18)
		A0_16._time_until_next_hurt = _UPVALUE0_.TIME_BETWEEN_IMPACT_PUSHES.min + math.random() * (_UPVALUE0_.TIME_BETWEEN_IMPACT_PUSHES.max - _UPVALUE0_.TIME_BETWEEN_IMPACT_PUSHES.min)
		A0_16._emitter:unit_hurt(A0_16._unit)
	end
end
function FlyerDamage.get_outline_weakspots(A0_24)
	local L1_25
	L1_25 = A0_24._outline_weakspots
	return L1_25
end
function FlyerDamage.check_outline_weakspot(A0_26, A1_27)
	if A0_26._outline_weakspots then
		for 