CoreEnvironmentEffectsManager = CoreEnvironmentEffectsManager or class()
function CoreEnvironmentEffectsManager.init(A0_0)
	local L1_1
	L1_1 = {}
	A0_0._effects = L1_1
	L1_1 = {}
	A0_0._current_effects = L1_1
	L1_1 = {}
	A0_0._mission_effects = L1_1
end
function CoreEnvironmentEffectsManager.add_effect(A0_2, A1_3, A2_4)
	A0_2._effects[A1_3] = A2_4
	if A2_4:default() then
		A0_2:use(A1_3)
	end
end
function CoreEnvironmentEffectsManager.effect(A0_5, A1_6)
	return A0_5._effects[A1_6]
end
function CoreEnvironmentEffectsManager.effects(A0_7)
	local L1_8
	L1_8 = A0_7._effects
	return L1_8
end
function CoreEnvironmentEffectsManager.effects_names(A0_9)
	local L1_10, L2_11, L3_12, L4_13, L5_14
	L1_10 = {}
	for L5_14, 