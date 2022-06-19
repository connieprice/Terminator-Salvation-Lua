AMAmmoBox = AMAmmoBox or class(CoreActionElement)
function AMAmmoBox.init(A0_0, A1_1, A2_2)
	CoreActionElement.init(A0_0, A1_1, A2_2)
	World:preload_unit(A0_0.unit_name)
end
function AMAmmoBox.activate_now(A0_3)
	local L1_4
	L1_4 = World
	L1_4 = L1_4.spawn_unit
	L1_4 = L1_4(L1_4, A0_3.unit_name, A0_3.position, A0_3.rotation)
	A0_3._unit = L1_4
	L1_4 = A0_3._unit
	L1_4 = L1_4.interact
	L1_4 = L1_4(L1_4)
	assert(L1_4)
	L1_4:enable_interact()
	A0_3:deactivate_now()
end
