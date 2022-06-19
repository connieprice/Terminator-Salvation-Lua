if not AMAmmoBox then
	AMAmmoBox = class(CoreActionElement)
end
AMAmmoBox.init = function(l_1_0, l_1_1, l_1_2)
	CoreActionElement.init(l_1_0, l_1_1, l_1_2)
	World:preload_unit(l_1_0.unit_name)
end

AMAmmoBox.activate_now = function(l_2_0)
	l_2_0._unit = World:spawn_unit(l_2_0.unit_name, l_2_0.position, l_2_0.rotation)
	local l_2_1 = l_2_0._unit:interact()
	assert(l_2_1)
	l_2_1:enable_interact()
	l_2_0:deactivate_now()
end


