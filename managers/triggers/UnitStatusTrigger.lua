require("units/editor/UnitStatusCondition")
if not UnitStatusTrigger then
	UnitStatusTrigger = class(CoreTriggerBase)
end
UnitStatusTrigger.init = function(l_1_0, l_1_1, l_1_2, l_1_3)
	CoreTriggerBase.init(l_1_0, l_1_1, l_1_2, l_1_3)
	l_1_0._name = l_1_2:parameter("name")
	l_1_0._status_type = l_1_2:parameter("status_type")
	l_1_0._threshold = tonumber(l_1_2:parameter("threshold"))
	l_1_0._hub_element_name = l_1_2:parameter("hub_element_name")
	l_1_0:parse_hitzones(l_1_2:parameter("hitzones_alive"), l_1_2:parameter("hitzones_destroyed"))
	managers.unit_scripting:get_unit_by_name_callback(l_1_0._name, callback(l_1_0, l_1_0, "unit_spawned"))
end

UnitStatusTrigger.parse_hitzones = function(l_2_0, l_2_1, l_2_2)
	local l_2_8, l_2_9, l_2_13, l_2_14 = nil
	local l_2_3 = {}
	local l_2_4 = {}
	if l_2_3 then
		for i_0 in string.gmatch(l_2_1, "(%d+)%s*[,]*") do
			table.insert(l_2_3, tonumber(i_0))
		end
	end
	if l_2_4 then
		for i_0 in string.gmatch(l_2_2, "(%d+)%s*[,]*") do
			table.insert(l_2_4, tonumber(i_0))
		end
	end
	local l_2_15 = {}
	l_2_15.alive = l_2_3
	l_2_15.destroyed = l_2_4
	l_2_0._hitzones = l_2_15
end

UnitStatusTrigger.unit_spawned = function(l_3_0, l_3_1)
	local l_3_2 = UnitStatusCondition:new(l_3_0._status_type, callback(l_3_0, l_3_0, "status_achieved"))
	l_3_2.threshold = l_3_0._threshold
	l_3_2.hitzones = l_3_0._hitzones
	l_3_2.hub_element_name = l_3_0._hub_element_name
	l_3_1:base():register_status_callback(l_3_2)
end

UnitStatusTrigger.status_achieved = function(l_4_0)
	l_4_0._user:trigger_activated(l_4_0._id, 1)
end


