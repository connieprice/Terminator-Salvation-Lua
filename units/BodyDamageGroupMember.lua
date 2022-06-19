require("units/BodyDamage")
if not BodyDamageGroupMember then
	BodyDamageGroupMember = class(BodyDamage)
end
BodyDamageGroupMember.init = function(l_1_0, l_1_1, l_1_2, l_1_3, l_1_4, l_1_5, l_1_6)
	BodyDamage.init(l_1_0, l_1_1, l_1_2, l_1_3, l_1_4)
	l_1_0._group = l_1_5
	l_1_0._damage_unit = l_1_6
end

BodyDamageGroupMember.damage_endurance = function(l_2_0, l_2_1, l_2_2, l_2_3, l_2_4, l_2_5, l_2_6, l_2_7)
	l_2_0._group:add_damage(l_2_6)
	local l_2_8 = BodyDamage.damage_endurance
	local l_2_9 = l_2_0
	local l_2_10 = l_2_1
	local l_2_11 = l_2_2
	local l_2_12 = l_2_3
	local l_2_13 = l_2_4
	local l_2_14 = l_2_5
	local l_2_15 = l_2_6
	local l_2_16 = l_2_7
	return l_2_8(l_2_9, l_2_10, l_2_11, l_2_12, l_2_13, l_2_14, l_2_15, l_2_16)
end

BodyDamageGroupMember.damage_bullet = function(l_3_0, l_3_1, l_3_2, l_3_3, l_3_4, l_3_5, l_3_6)
	local l_3_16, l_3_17, l_3_18 = l_3_0:damage_endurance, l_3_0, "bullet"
	l_3_16 = l_3_16(l_3_17, l_3_18, l_3_1, l_3_2, l_3_3, l_3_4, l_3_5, Vector3(0, 0, 0))
	l_3_5 = l_3_16
	l_3_16 = l_3_0._damage_unit
	if l_3_16 then
		l_3_16 = l_3_0._unit_extension
		l_3_16, l_3_17 = l_3_16:damage_bullet, l_3_16
		local l_3_7, l_3_8 = nil
		l_3_18 = l_3_1
		local l_3_9 = nil
		l_3_7 = l_3_0._body
		local l_3_10 = nil
		l_3_8 = l_3_2
		local l_3_11 = nil
		l_3_9 = l_3_3
		local l_3_12 = nil
		l_3_10 = l_3_4
		local l_3_13 = nil
		l_3_11 = l_3_5
		local l_3_14 = nil
		l_3_12 = l_3_6
		local l_3_15 = nil
		return l_3_16(l_3_17, l_3_18, l_3_7, l_3_8, l_3_9, l_3_10, l_3_11, l_3_12)
	end
	l_3_16 = true
	l_3_17 = 0
	return l_3_16, l_3_17
end

BodyDamageGroupMember.damage_explosion = function(l_4_0, l_4_1, l_4_2, l_4_3, l_4_4, l_4_5, l_4_6)
	local l_4_15, l_4_16, l_4_17, l_4_18 = l_4_0:damage_endurance, l_4_0, "explosion", l_4_1
	l_4_15 = l_4_15(l_4_16, l_4_17, l_4_18, l_4_2, l_4_3, l_4_4, l_4_5, Vector3(0, 0, 0))
	l_4_5 = l_4_15
	l_4_15 = l_4_0._damage_unit
	if l_4_15 then
		l_4_15 = l_4_0._unit_extension
		l_4_15, l_4_16 = l_4_15:damage_explosion, l_4_15
		local l_4_7, l_4_8 = nil
		l_4_17 = l_4_1
		local l_4_9 = nil
		l_4_18 = l_4_0._body
		local l_4_10 = nil
		l_4_7 = l_4_2
		local l_4_11 = nil
		l_4_8 = l_4_3
		local l_4_12 = nil
		l_4_9 = l_4_4
		local l_4_13 = nil
		l_4_10 = l_4_5
		local l_4_14 = nil
		return l_4_15(l_4_16, l_4_17, l_4_18, l_4_7, l_4_8, l_4_9, l_4_10)
	end
	l_4_15 = true
	l_4_16 = 0
	return l_4_15, l_4_16
end


