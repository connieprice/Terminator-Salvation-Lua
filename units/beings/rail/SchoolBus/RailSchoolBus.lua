RailSchoolBus = RailSchoolBus or class(RailWheeledVehicle)
function RailSchoolBus.init(A0_0, A1_1)
	local L2_2
	L2_2 = RailWheeledVehicle
	L2_2 = L2_2.init
	L2_2(A0_0, A1_1)
	L2_2 = managers
	L2_2 = L2_2.unit_scripting
	L2_2 = L2_2.get_unit_by_name
	L2_2 = L2_2(L2_2, "character_slot1")
	if alive(L2_2) then
		L2_2:difficulty_level():register_unmounted_rail_vehicle(A1_1)
	end
end
function RailSchoolBus.update(A0_3, A1_4, A2_5, A3_6)
	RailWheeledVehicle.update(A0_3, A1_4, A2_5, A3_6)
end
function RailSchoolBus.destroy(A0_7)
	RailWheeledVehicle.destroy(A0_7)
end
