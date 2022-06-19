if not UnitScriptingUnitInfo then
	UnitScriptingUnitInfo = class()
end
UnitScriptingUnitInfo.init = function(l_1_0, l_1_1)
	l_1_0._name = l_1_1
	l_1_0._unit = nil
	l_1_0._death_callbacks = {}
	l_1_0._registered = false
end

UnitScriptingUnitInfo.destroy = function(l_2_0)
end

UnitScriptingUnitInfo.register_unit = function(l_3_0, l_3_1)
	l_3_0._unit = l_3_1
	l_3_0._registered = true
end

UnitScriptingUnitInfo.unregister = function(l_4_0)
	l_4_0._unit = nil
	l_4_0._registered = false
end

UnitScriptingUnitInfo.registered = function(l_5_0)
	return l_5_0._registered
end

UnitScriptingUnitInfo.add_death_callback = function(l_6_0, l_6_1)
	table.insert(l_6_0._death_callbacks, l_6_1)
end

UnitScriptingUnitInfo.unit_dead = function(l_7_0)
	local l_7_4, l_7_5, l_7_6, l_7_7 = nil
	for i_0,i_1 in ipairs(l_7_0._death_callbacks) do
		i_1()
	end
end

UnitScriptingUnitInfo.unit = function(l_8_0)
	local l_8_2 = type
	l_8_2 = l_8_2(l_8_0._unit)
	if l_8_2 == "function" then
		l_8_2 = l_8_0._unit
		local l_8_1 = nil
		return l_8_2()
	else
		l_8_2 = l_8_0._unit
		return l_8_2
	end
end

UnitScriptingUnitInfo.name = function(l_9_0)
	return l_9_0._name
end

UnitScriptingUnitInfo.active = function(l_10_0)
	if type(l_10_0._unit) == "function" then
		return true
	elseif not l_10_0._registered then
		return true
	else
		local l_10_1 = alive
		local l_10_2 = l_10_0._unit
		return l_10_1(l_10_2)
	end
end


