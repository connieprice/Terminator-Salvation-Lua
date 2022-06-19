if not RailSchoolBus then
	RailSchoolBus = class(RailWheeledVehicle)
end
RailSchoolBus.init = function(l_1_0, l_1_1)
	RailWheeledVehicle.init(l_1_0, l_1_1)
	local l_1_2 = managers.unit_scripting:get_unit_by_name("character_slot1")
	if alive(l_1_2) then
		l_1_2:difficulty_level():register_unmounted_rail_vehicle(l_1_1)
	end
end

RailSchoolBus.update = function(l_2_0, l_2_1, l_2_2, l_2_3)
	RailWheeledVehicle.update(l_2_0, l_2_1, l_2_2, l_2_3)
end

RailSchoolBus.destroy = function(l_3_0)
	RailWheeledVehicle.destroy(l_3_0)
end


