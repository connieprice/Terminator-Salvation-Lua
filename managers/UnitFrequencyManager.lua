require("shared/TableAlgorithms")
if not UnitFrequencyManager then
	UnitFrequencyManager = class()
end
UnitFrequencyManager.init = function(l_1_0)
	l_1_0._coop_frequencies = {}
	l_1_0:load_frequencies()
end

UnitFrequencyManager.load_frequencies = function(l_2_0)
	local l_2_5, l_2_6, l_2_7, l_2_8 = nil
	local l_2_1 = File:new_parse_xml("data/settings/brush_unit_frequencies.xml")
	for i_0 in l_2_1:children() do
		if l_2_9:has_parameter("value") then
			l_2_0._coop_frequencies[i_0:parameter("name")] = tonumber(l_2_9:parameter("value"))
		end
	end
end

UnitFrequencyManager.apply_coop_frequencies = function(l_3_0)
	local l_3_4, l_3_5, l_3_6, l_3_7, l_3_8 = nil
	for i_0,i_1 in pairs(l_3_0._coop_frequencies) do
		MassUnitManager:set_frequency(i_0, i_1)
	end
end

UnitFrequencyManager.reset_frequencies = function(l_4_0)
	MassUnitManager:clear_frequencies()
end


