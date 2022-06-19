AMWeaponPickup = AMWeaponPickup or class(CoreActionElement)
function AMWeaponPickup.init(A0_0, A1_1, A2_2)
	CoreActionElement.init(A0_0, A1_1, A2_2)
	World:preload_unit(A0_0.unit_name)
end
function AMWeaponPickup.activate_now(A0_3)
	local L1_4, L2_5
	L1_4 = World
	L2_5 = L1_4
	L1_4 = L1_4.spawn_unit
	L1_4 = L1_4(L2_5, A0_3.unit_name, A0_3.position, A0_3.rotation)
	A0_3._unit = L1_4
	L1_4 = A0_3._unit
	L2_5 = L1_4
	L1_4 = L1_4.logic
	L1_4 = L1_4(L2_5)
	if L1_4 then
		L2_5 = A0_3.ammo
		if L2_5 >= 0 then
			L2_5 = A0_3._unit
			L2_5 = L2_5.logic
			L2_5 = L2_5(L2_5)
			L2_5 = L2_5.max_ammo
			L2_5 = L2_5(L2_5)
			if L2_5 < 0 then
				L2_5 = math.huge or L2_5
			end
			A0_3.ammo = math.clamp(A0_3.ammo, 0, L2_5)
			A0_3._unit:logic():set_ammo(A0_3.ammo)
		end
	else
		L2_5 = cat_print
		L2_5("warning", "No weapon logic set for weapon:" .. A0_3.unit_name)
	end
	L2_5 = A0_3._unit
	L2_5 = L2_5.interact
	L2_5 = L2_5(L2_5)
	assert(L2_5)
	L2_5:enable_interact()
	A0_3:deactivate_now()
end
