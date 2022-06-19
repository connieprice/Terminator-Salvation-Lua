if not EnvironmentAreaManager then
	EnvironmentAreaManager = class(CoreEnvironmentAreaManager)
end
EnvironmentAreaManager.add_area = function(l_1_0, l_1_1)
	local l_1_2 = FaithEnvironmentArea:new(l_1_1)
	table.insert(l_1_0._areas, l_1_2)
	return l_1_2
end

if not FaithEnvironmentArea then
	FaithEnvironmentArea = class(EnvironmentArea)
end
FaithEnvironmentArea.init = function(l_2_0, l_2_1)
	EnvironmentArea.init(l_2_0, l_2_1)
	if managers.environment:exists_on_disk(l_2_0._properties.environment .. "_coop") then
		managers.environment:preload_environment(l_2_0._properties.environment .. "_coop")
	end
end


