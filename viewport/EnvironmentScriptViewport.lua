EnvironmentScriptViewport = EnvironmentScriptViewport or class(CoreScriptViewport.ScriptViewport)
function EnvironmentScriptViewport.environment_change_name(A0_0)
	local L1_1
	L1_1 = A0_0._environment_change
	if L1_1 then
		L1_1 = A0_0._environment_change
		L1_1 = L1_1.environment_name
		return L1_1
	end
end
function EnvironmentScriptViewport.environment_change_alternative(A0_2)
	local L1_3
	L1_3 = A0_2._environment_change
	if L1_3 then
		L1_3 = A0_2._environment_change
		L1_3 = L1_3.alternative_environment
		return L1_3
	end
end
function EnvironmentScriptViewport.set_environment(A0_4, A1_5, A2_6)
	local L3_7, L4_8, L5_9
	L3_7 = A1_5
	L4_8 = RenderSettings
	L4_8 = L4_8.split_screen
	if L4_8 then
		L5_9 = A1_5
		L5_9 = L5_9 .. "_coop"
		if managers.environment:exists(L5_9) or Database:lookup("environment", L5_9):valid() then
			L3_7 = L5_9
		end
	end
	L5_9 = A0_4._vpm_interface
	L5_9 = L5_9.set_environment_name_cache
	L5_9(L5_9, A1_5)
	L5_9 = A0_4._vpm_interface
	L5_9 = L5_9.create_environment_change
	L5_9 = L5_9(L5_9, A0_4._environment_change, L3_7, A2_6)
	A0_4._environment_change = L5_9
	L5_9 = A0_4._environment_change
	if L5_9 then
		L5_9 = A0_4._environment_change
		L5_9.alternative_environment = L4_8
		L5_9 = A0_4._environment_change
		L5_9.environment_name = A1_5
	end
	L5_9 = A0_4.feed_now
	L5_9(A0_4)
end
