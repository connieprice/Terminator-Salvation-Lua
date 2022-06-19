TankDisplayManager = TankDisplayManager or class()
function TankDisplayManager.init(A0_0)
	local L1_1
	A0_0._startup = false
	A0_0._shutdown = false
	A0_0._startup_done = false
	A0_0._tank_active = false
end
function TankDisplayManager.startup(A0_2)
	local L1_3
	A0_2._tank_active = true
	A0_2._startup = true
end
function TankDisplayManager.is_active(A0_4)
	local L1_5
	L1_5 = A0_4._tank_active
	return L1_5
end
function TankDisplayManager.wants_to_startup(A0_6)
	local L1_7
	L1_7 = A0_6._startup
	return L1_7
end
function TankDisplayManager.shutdown(A0_8)
	local L1_9
	A0_8._shutdown = true
end
function TankDisplayManager.wants_to_shutdown(A0_10)
	local L1_11
	L1_11 = A0_10._shutdown
	return L1_11
end
function TankDisplayManager.set_startup_done(A0_12)
	local L1_13
	A0_12._startup_done = true
end
function TankDisplayManager.startup_done(A0_14)
	local L1_15
	L1_15 = A0_14._startup_done
	return L1_15
end
