if not AMWeaponPickup then
	AMWeaponPickup = class(CoreActionElement)
end
AMWeaponPickup.init = function(l_1_0, l_1_1, l_1_2)
	CoreActionElement.init(l_1_0, l_1_1, l_1_2)
	World:preload_unit(l_1_0.unit_name)
end

AMWeaponPickup.activate_now = function(l_2_0)
	l_2_0._unit = World:spawn_unit(l_2_0.unit_name, l_2_0.position, l_2_0.rotation)
	local l_2_1 = l_2_0._unit:logic()
	if l_2_1 and l_2_0.ammo >= 0 and (l_2_0._unit:logic():max_ammo() >= 0 or not math.huge) then
		l_2_0.ammo = math.clamp(l_2_0.ammo, 0, l_2_0._unit:logic():max_ammo())
		l_2_0._unit:logic():set_ammo(l_2_0.ammo)
	else
		cat_print("warning", "No weapon logic set for weapon:" .. l_2_0.unit_name)
	end
	local l_2_5 = l_2_0._unit:interact()
	assert(l_2_5)
	l_2_5:enable_interact()
	l_2_0:deactivate_now()
end


