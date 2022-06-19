AMChangeEnvironment = AMChangeEnvironment or class(CoreActionElement)
function AMChangeEnvironment.init(A0_0, A1_1, A2_2)
	local L3_3
	L3_3 = CoreActionElement
	L3_3 = L3_3.init
	L3_3(A0_0, A1_1, A2_2)
	L3_3 = managers
	L3_3 = L3_3.environment
	L3_3 = L3_3.preload_environment
	L3_3(L3_3, A0_0.environment_name)
	L3_3 = A0_0.environment_name
	L3_3 = L3_3 .. "_coop"
	if managers.environment:exists_on_disk(L3_3) then
		managers.environment:preload_environment(L3_3)
	end
end
function AMChangeEnvironment.activate_now(A0_4)
	if A0_4.fade_in_time == 0 then
		A0_4.fade_in_time = 0.001
	end
	for 