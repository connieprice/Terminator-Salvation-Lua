core:module("CoreLightEnvironment")
core:require_module("CoreClass")
if not LightEnvironment then
	LightEnvironment = CoreClass.class(CoreClass.GetSet)
end
LightEnvironment.init = function(l_1_0, l_1_1)
	CoreClass.GetSet.init(l_1_0, l_1_1)
end

LightEnvironment.update = function(l_2_0, l_2_1, l_2_2)
	if l_2_0._blend_time and l_2_0._blend_time > 0 then
		l_2_0:_interpolate(math.clamp(l_2_0._blend / l_2_0._blend_time, 0, 1))
		l_2_0._blend = l_2_0._blend + l_2_2
		l_2_0._dirty = true
		if l_2_0._blend_time < l_2_0._blend then
			l_2_0._env._post_effect:set_name(l_2_0._env1._post_effect._name)
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		return l_2_0._blend_time < l_2_0._blend
	else
		return true
	end
end

LightEnvironment.is_blending = function(l_3_0)
	if l_3_0._blend > l_3_0._blend_time then
		return not l_3_0._blend_time or l_3_0._blend_time <= 0
	end
	do return end
	return false
end

LightEnvironment.name = function(l_4_0)
	local l_4_1 = l_4_0:is_blending()
	do
		local l_4_2, l_4_4 = l_4_1 and math.clamp(l_4_0._blend / l_4_0._blend_time, 0, 1) or nil
	do
		end
		local l_4_3 = nil
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	return l_4_0._env._post_effect._name, l_4_1 and l_4_0._env1._post_effect._name or nil, l_4_3
end

LightEnvironment._interpolate = function(l_5_0, l_5_1)
	l_5_0._env._post_effect:interpolate(l_5_0._env0._post_effect, l_5_0._env1._post_effect, l_5_1)
	l_5_0._env._underlay_effect:interpolate(l_5_0._env0._underlay_effect, l_5_0._env1._underlay_effect, l_5_1)
	l_5_0._env._sky:interpolate(l_5_0._env0._sky, l_5_0._env1._sky, l_5_1)
end


