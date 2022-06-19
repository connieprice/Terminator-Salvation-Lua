require("units/UnitDamage")
require("units/damage/StunDamage")
require("units/damage/StunBodySetup")
require("TweakData")
local l_0_0 = tweak_data.enemy.flyer
if not FlyerDamage then
	FlyerDamage = class(UnitDamage)
end
local l_0_1 = {}
 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

 -- DECOMPILER ERROR: Overwrote pending register.

 -- DECOMPILER ERROR: Overwrote pending register.

StunBodySetup:new("default_body", l_0_0.STUN_MAX_HEALTH, l_0_0.STUN_HEALTH_PER_SECOND, true).init = .end
FlyerDamage.destroy = function(l_2_0)
	l_2_0._stun_damage:destroy()
end

FlyerDamage.fully_damaged = function(l_3_0, l_3_1)
	l_3_0._unit:set_slot(6)
end

FlyerDamage.update_damage = function(l_4_0, l_4_1, l_4_2, l_4_3)
	l_4_0._time_until_next_hurt = l_4_0._time_until_next_hurt - l_4_3
	l_4_0._stun_damage:update(l_4_3)
end

FlyerDamage._on_damage = function(l_5_0, l_5_1, l_5_2, l_5_3, l_5_4, l_5_5)
	-- upvalues: l_0_0
	if l_5_0._time_until_next_hurt <= 0 and l_5_1 > 0 and l_5_5 then
		local l_5_6 = l_5_3:with_z(0):normalized()
		local l_5_7 = l_5_6:cross(math.UP)
		local l_5_8 = l_5_5:center_of_mass()
		local l_5_9 = l_5_2 - l_5_8
		local l_5_10 = l_5_9:dot(l_5_7)
		if l_5_10 > 0 then
			l_5_2 = l_5_2 - 0.5 * l_5_9 + 60 * l_5_7
			l_5_6 = l_5_6 - l_5_7:normalized()
		else
			l_5_2 = l_5_2 - 0.5 * l_5_9 - 60 * l_5_7
			l_5_6 = l_5_6 + l_5_7:normalized()
		end
		l_5_0._unit:push_at(l_0_0.IMPACT_MASS, l_5_6 * l_0_0.IMPACT_VELOCITY, l_5_2)
		local l_5_11 = l_0_0.TIME_BETWEEN_IMPACT_PUSHES
		local l_5_12 = l_5_11.min
		local l_5_13 = l_5_11.max
		l_5_0._time_until_next_hurt = l_5_12 + math.random() * (l_5_13 - l_5_12)
		l_5_0._emitter:unit_hurt(l_5_0._unit)
	end
end

FlyerDamage.get_outline_weakspots = function(l_6_0)
	return l_6_0._outline_weakspots
end

FlyerDamage.check_outline_weakspot = function(l_7_0, l_7_1)
	local l_7_5, l_7_6, l_7_7, l_7_8, l_7_9, l_7_10 = nil
	if l_7_0._outline_weakspots then
		for i_0,i_1 in pairs(l_7_0._outline_weakspots) do
			if i_1.body_name == l_7_1 then
				return {i_1.obj}
			end
		end
	end
end

FlyerDamage.hide_all_outline_weakspots = function(l_8_0)
	local l_8_4, l_8_5, l_8_6, l_8_7 = nil
	for i_0,i_1 in pairs(l_8_0._outline_weakspots) do
		i_1.obj:set_visibility(false)
	end
end


