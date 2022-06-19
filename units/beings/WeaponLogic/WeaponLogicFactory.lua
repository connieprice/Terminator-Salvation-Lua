WeaponLogicFactory = WeaponLogicFactory or class()
function WeaponLogicFactory.create_weapon_logic(A0_0, A1_1, A2_2)
	local L3_3, L4_4, L5_5
	L3_3 = A0_0.class_name
	L4_4 = assert
	L5_5 = L3_3 and L3_3 ~= ""
	L4_4(L5_5)
	L4_4 = rawget
	L5_5 = _G
	L4_4 = L4_4(L5_5, L3_3)
	L5_5 = assert
	L5_5(L4_4, "Weapon logic class named '" .. L3_3 .. "' doesn't exist")
	L5_5 = WeaponLogicFactory
	L5_5 = L5_5._create_setup
	L5_5 = L5_5(A0_0.setup)
	return (L4_4:new(A1_1, A2_2, L5_5))
end
function WeaponLogicFactory._create_setup(A0_6)
	local L1_7, L2_8, L3_9, L4_10
	if not A0_6 then
		return
	end
	L1_7 = A0_6.class_name
	L2_8 = assert
	L3_9 = L1_7 and L1_7 ~= ""
	L2_8(L3_9)
	L2_8 = rawget
	L3_9 = _G
	L4_10 = L1_7
	L2_8 = L2_8(L3_9, L4_10)
	L3_9 = assert
	L4_10 = L2_8
	L3_9(L4_10, "Weapon logic setup class named '" .. L1_7 .. "' doesn't exist")
	L3_9 = A0_6.parameters
	L4_10 = nil
	if L3_9 then
		L4_10 = L2_8:new(unpack(L3_9))
	else
		L4_10 = L2_8:new()
	end
	return L4_10
end
