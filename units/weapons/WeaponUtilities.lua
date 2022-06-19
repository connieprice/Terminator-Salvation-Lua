if not WeaponUtilities then
	WeaponUtilities = class()
end
WeaponUtilities.circular_dispersion = function(l_1_0, l_1_1, l_1_2)
	local l_1_3 = SharedMath.normalized_rand(l_1_1, l_1_2)
	local l_1_4 = math.random() * 360
	local l_1_5 = Rotation(l_1_0, math.UP)
	local l_1_6 = Rotation(l_1_3, l_1_4, 0)
	return Vector3(0, 1, 0):rotate_with(l_1_6):rotate_with(l_1_5)
end

WeaponUtilities.elliptical_dispersion = function(l_2_0, l_2_1, l_2_2, l_2_3)
	local l_2_4 = SharedMath.normalized_rand(l_2_1, l_2_2)
	local l_2_5 = math.random() * 360 - 180
	local l_2_6 = math.tan(l_2_4)
	local l_2_7, l_2_8 = SharedMath.point_on_ellipse(l_2_6 * l_2_3, l_2_6, l_2_5)
	local l_2_9 = Rotation(l_2_0, math.UP)
	local l_2_10 = Rotation(Vector3(l_2_8, 1, l_2_7):normalized(), math.UP)
	return Vector3(0, 1, 0):rotate_with(l_2_10):rotate_with(l_2_9)
end

WeaponUtilities.dispersion = function(l_3_0, l_3_1, l_3_2)
	local l_3_3 = WeaponUtilities.circular_dispersion
	local l_3_4 = l_3_0
	local l_3_5 = l_3_1
	local l_3_6 = l_3_2
	return l_3_3(l_3_4, l_3_5, l_3_6)
end

WeaponUtilities.sound_objects = function(l_4_0, l_4_1, l_4_2, l_4_3, l_4_4, l_4_5)
	local l_4_6 = l_4_1 .. "shot"
	if l_4_2 then
		l_4_6 = l_4_6 .. l_4_2
	end
	local l_4_7 = Sound:make_bank(l_4_3, l_4_6)
	l_4_7:set_output(l_4_0:get_object(l_4_5))
	if l_4_4 == false then
		local l_4_8 = l_4_1 .. "shot_end"
		if l_4_2 then
			l_4_8 = l_4_8 .. l_4_2
		end
		local l_4_9 = Sound:make_bank(l_4_3, l_4_8)
		l_4_9:set_output(l_4_0:get_object(l_4_5))
		return l_4_7, l_4_9
	end
	return l_4_7
end

local l_0_0 = WeaponUtilities
local l_0_1 = {}
l_0_1.m4_carbine = "m4"
l_0_1.m249_machinegun = "m249"
l_0_1.r870_shotgun = "r870"
l_0_1.rpg7_grenadelauncher_onfoot = "rpg"
l_0_1.m67_grenade = "grenade"
l_0_1.pipebomb = "pipebomb"
l_0_1.m79_grenadelauncher = "m79"
l_0_0.weapon_name_to_short_name = l_0_1

