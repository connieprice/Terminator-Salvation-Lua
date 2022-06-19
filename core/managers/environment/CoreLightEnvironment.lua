core:module("CoreLightEnvironment")
core:require_module("CoreClass")
LightEnvironment = LightEnvironment or CoreClass.class(CoreClass.GetSet)
function LightEnvironment.init(A0_0, A1_1)
	CoreClass.GetSet.init(A0_0, A1_1)
end
function LightEnvironment.update(A0_2, A1_3, A2_4)
	local L3_5
	L3_5 = A0_2._blend_time
	if L3_5 then
		L3_5 = A0_2._blend_time
		if L3_5 > 0 then
			L3_5 = A0_2._interpolate
			L3_5(A0_2, math.clamp(A0_2._blend / A0_2._blend_time, 0, 1))
			L3_5 = A0_2._blend
			L3_5 = L3_5 + A2_4
			A0_2._blend = L3_5
			A0_2._dirty = true
			L3_5 = A0_2._blend
			L3_5 = L3_5 > A0_2._blend_time
			if L3_5 then
				A0_2._env._post_effect:set_name(A0_2._env1._post_effect._name)
			end
			return L3_5
		end
	else
		L3_5 = true
		return L3_5
	end
end
function LightEnvironment.is_blending(A0_6)
	local L1_7
	L1_7 = A0_6._blend_time
	if L1_7 then
		L1_7 = A0_6._blend_time
		if L1_7 > 0 then
			L1_7 = A0_6._blend
			L1_7 = L1_7 <= A0_6._blend_time
			return L1_7
		end
	else
		L1_7 = false
		return L1_7
	end
end
function LightEnvironment.name(A0_8)
	local L1_9, L2_10, L3_11
	L2_10 = A0_8
	L1_9 = A0_8.is_blending
	L1_9 = L1_9(L2_10)
	if L1_9 then
		L2_10 = math
		L2_10 = L2_10.clamp
		L3_11 = A0_8._blend
		L3_11 = L3_11 / A0_8._blend_time
		L2_10 = L2_10(L3_11, 0, 1)
	else
		L2_10 = L2_10 or nil
	end
	if L1_9 then
		L3_11 = A0_8._env1
		L3_11 = L3_11._post_effect
		L3_11 = L3_11._name
	else
		L3_11 = L3_11 or nil
	end
	return A0_8._env._post_effect._name, L3_11, L2_10
end
function LightEnvironment._interpolate(A0_12, A1_13)
	A0_12._env._post_effect:interpolate(A0_12._env0._post_effect, A0_12._env1._post_effect, A1_13)
	A0_12._env._underlay_effect:interpolate(A0_12._env0._underlay_effect, A0_12._env1._underlay_effect, A1_13)
	A0_12._env._sky:interpolate(A0_12._env0._sky, A0_12._env1._sky, A1_13)
end
