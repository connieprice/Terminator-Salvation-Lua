if not UnitDeathTrigger then
	UnitDeathTrigger = class(CoreTriggerBase)
end
UnitDeathTrigger.init = function(l_1_0, l_1_1, l_1_2, l_1_3)
	CoreTriggerBase.init(l_1_0, l_1_1, l_1_2, l_1_3)
	local l_1_4 = l_1_2:parameter("name")
	managers.unit_scripting:define_unit(l_1_4)
	managers.unit_scripting:add_unit_death_callback(l_1_4, function(...)
		-- upvalues: l_1_0
		l_1_0:unit_killed(...)
  end)
end

UnitDeathTrigger.unit_killed = function(l_2_0)
	l_2_0._user:trigger_activated(l_2_0._id, 1)
end


