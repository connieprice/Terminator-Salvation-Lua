EnvironmentAreaManager = EnvironmentAreaManager or class(CoreEnvironmentAreaManager)
function EnvironmentAreaManager.add_area(A0_0, A1_1)
	local L2_2
	L2_2 = FaithEnvironmentArea
	L2_2 = L2_2.new
	L2_2 = L2_2(L2_2, A1_1)
	table.insert(A0_0._areas, L2_2)
	return L2_2
end
FaithEnvironmentArea = FaithEnvironmentArea or class(EnvironmentArea)
function FaithEnvironmentArea.init(A0_3, A1_4)
	EnvironmentArea.init(A0_3, A1_4)
	if managers.environment:exists_on_disk(A0_3._properties.environment .. "_coop") then
		managers.environment:preload_environment(A0_3._properties.environment .. "_coop")
	end
end
