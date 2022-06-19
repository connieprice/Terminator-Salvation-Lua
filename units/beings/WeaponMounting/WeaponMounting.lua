WeaponMounting = WeaponMounting or class()
function WeaponMounting.mount(A0_0, A1_1, A2_2)
	local L3_3, L4_4, L5_5, L6_6, L7_7, L8_8, L9_9, L10_10, L11_11
	for L6_6, L7_7 in L3_3(L4_4) do
		L8_8 = L7_7.character_object_name
		L9_9 = L7_7.weapon_object_name
		L10_10 = L7_7.unit_link
		if L10_10 then
			L11_11 = A0_0
			L10_10 = A0_0.link
			L10_10(L11_11, L8_8, A1_1, L9_9)
		else
			L11_11 = A1_1
			L10_10 = A1_1.get_object
			L10_10 = L10_10(L11_11, L9_9)
			L11_11 = assert
			L11_11(L10_10)
			L11_11 = L10_10.set_local_position
			L11_11(L10_10, Vector3())
			L11_11 = L10_10.set_local_rotation
			L11_11(L10_10, Rotation())
			L11_11 = A0_0.get_object
			L11_11 = L11_11(A0_0, L8_8)
			assert(L11_11)
			L10_10:link(L11_11)
		end
	end
end
