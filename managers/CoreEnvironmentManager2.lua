local L0_0
L0_0 = core
L0_0 = L0_0.module
L0_0(L0_0, "CoreEnvironmentManager2")
L0_0 = core
L0_0 = L0_0.require_module
L0_0(L0_0, "CoreClass")
L0_0 = core
L0_0 = L0_0.require_module
L0_0(L0_0, "RadialBlurManager")
L0_0 = core
L0_0 = L0_0.require_core_module
L0_0 = L0_0(L0_0, "CoreEnvironmentManager2")
EnvironmentManager = EnvironmentManager or CoreClass.class(L0_0.EnvironmentManager)
function EnvironmentManager.init(A0_1, A1_2)
	_UPVALUE0_.EnvironmentManager.init(A0_1, A1_2)
	if not A1_2 then
		A0_1._radial_blur_manager = RadialBlurManager.RadialBlurManager:new()
		Application:global_material():set_variable("effect_hdr_scale", 7)
	end
	A0_1._dirty = true
	A0_1._pain_post_effect = nil
	A0_1._pain_post_effect_time = 0
end
function EnvironmentManager.paused_update(A0_3, A1_4, A2_5)
	A0_3:update(A1_4, A2_5)
end
function EnvironmentManager.update(A0_6, A1_7, A2_8)
	_UPVALUE0_.EnvironmentManager.update(A0_6, A1_7, A2_8)
	A0_6._radial_blur_manager:update(A1_7, A2_8)
end
function EnvironmentManager.set(A0_9, A1_10, A2_11)
end
function EnvironmentManager.set_visualization(A0_12, A1_13)
	A0_12._visualization = A1_13
end
function EnvironmentManager.change_environment(A0_14, A1_15, A2_16)
end
function EnvironmentManager.set_pain_progress(A0_17, A1_18)
	A0_17._pain_post_effect_time = A1_18
end
function EnvironmentManager.set_pain_effect(A0_19, A1_20)
	A0_19._pain_post_effect = A1_20
end
function EnvironmentManager.create_blur(A0_21, A1_22, A2_23)
	A0_21._radial_blur_manager:create_blur(TimerManager:game(), A1_22, A2_23)
end
function EnvironmentManager.set_velocity_blur(A0_24, A1_25, A2_26, A3_27)
	A0_24._radial_blur_manager:set_velocity_blur(A1_25, A2_26, A3_27)
end
function EnvironmentManager.set_radial_blur_visible(A0_28, A1_29, A2_30)
	A0_28._radial_blur_manager:set_visible(A1_29, A2_30)
end
function EnvironmentManager.radial_blur_manager(A0_31)
	local L1_32
	L1_32 = A0_31._radial_blur_manager
	return L1_32
end
EnvironmentDefinition = EnvironmentDefinition or CoreClass.class()
function EnvironmentDefinition.init(A0_33, A1_34, A2_35, A3_36)
	A0_33._sky = A1_34
	A0_33._post_effect = A2_35
	A0_33._underlay_effect = A3_36
end
