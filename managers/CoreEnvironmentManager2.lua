core:module("CoreEnvironmentManager2")
core:require_module("CoreClass")
core:require_module("RadialBlurManager")
local l_0_0 = core:require_core_module("CoreEnvironmentManager2")
if not EnvironmentManager then
	EnvironmentManager = CoreClass.class(l_0_0.EnvironmentManager)
end
EnvironmentManager.init = function(l_1_0, l_1_1)
	-- upvalues: l_0_0
	l_0_0.EnvironmentManager.init(l_1_0, l_1_1)
	if not l_1_1 then
		l_1_0._radial_blur_manager = RadialBlurManager.RadialBlurManager:new()
		Application:global_material():set_variable("effect_hdr_scale", 7)
	end
	l_1_0._dirty = true
	l_1_0._pain_post_effect = nil
	l_1_0._pain_post_effect_time = 0
end

EnvironmentManager.paused_update = function(l_2_0, l_2_1, l_2_2)
	l_2_0:update(l_2_1, l_2_2)
end

EnvironmentManager.update = function(l_3_0, l_3_1, l_3_2)
	-- upvalues: l_0_0
	l_0_0.EnvironmentManager.update(l_3_0, l_3_1, l_3_2)
	l_3_0._radial_blur_manager:update(l_3_1, l_3_2)
end

EnvironmentManager.set = function(l_4_0, l_4_1, l_4_2)
end

EnvironmentManager.set_visualization = function(l_5_0, l_5_1)
	l_5_0._visualization = l_5_1
end

EnvironmentManager.change_environment = function(l_6_0, l_6_1, l_6_2)
end

EnvironmentManager.set_pain_progress = function(l_7_0, l_7_1)
	l_7_0._pain_post_effect_time = l_7_1
end

EnvironmentManager.set_pain_effect = function(l_8_0, l_8_1)
	l_8_0._pain_post_effect = l_8_1
end

EnvironmentManager.create_blur = function(l_9_0, l_9_1, l_9_2)
	l_9_0._radial_blur_manager:create_blur(TimerManager:game(), l_9_1, l_9_2)
end

EnvironmentManager.set_velocity_blur = function(l_10_0, l_10_1, l_10_2, l_10_3)
	l_10_0._radial_blur_manager:set_velocity_blur(l_10_1, l_10_2, l_10_3)
end

EnvironmentManager.set_radial_blur_visible = function(l_11_0, l_11_1, l_11_2)
	l_11_0._radial_blur_manager:set_visible(l_11_1, l_11_2)
end

EnvironmentManager.radial_blur_manager = function(l_12_0)
	return l_12_0._radial_blur_manager
end

if not EnvironmentDefinition then
	EnvironmentDefinition = CoreClass.class()
end
EnvironmentDefinition.init = function(l_13_0, l_13_1, l_13_2, l_13_3)
	l_13_0._sky = l_13_1
	l_13_0._post_effect = l_13_2
	l_13_0._underlay_effect = l_13_3
end


