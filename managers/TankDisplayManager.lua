if not TankDisplayManager then
	TankDisplayManager = class()
end
TankDisplayManager.init = function(l_1_0)
	l_1_0._startup = false
	l_1_0._shutdown = false
	l_1_0._startup_done = false
	l_1_0._tank_active = false
end

TankDisplayManager.startup = function(l_2_0)
	l_2_0._tank_active = true
	l_2_0._startup = true
end

TankDisplayManager.is_active = function(l_3_0)
	return l_3_0._tank_active
end

TankDisplayManager.wants_to_startup = function(l_4_0)
	return l_4_0._startup
end

TankDisplayManager.shutdown = function(l_5_0)
	l_5_0._shutdown = true
end

TankDisplayManager.wants_to_shutdown = function(l_6_0)
	return l_6_0._shutdown
end

TankDisplayManager.set_startup_done = function(l_7_0)
	l_7_0._startup_done = true
end

TankDisplayManager.startup_done = function(l_8_0)
	return l_8_0._startup_done
end


