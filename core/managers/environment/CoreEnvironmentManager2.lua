core:module("CoreEnvironmentManager2")
core:require_module("CoreClass")
core:require_module("CoreCode")
core:require_module("CoreSky")
core:require_module("CoreUnderlayEffect")
core:require_module("CorePostEffect")
core:require_module("CoreLightEnvironment")
core:require_module("CoreDebug")
if not EnvironmentManager then
	EnvironmentManager = CoreClass.class()
end
EnvironmentManager.init = function(l_1_0, l_1_1)
	l_1_0:deprecated_init(l_1_1)
	l_1_0._environment_blends = {}
end

EnvironmentManager.update = function(l_2_0, l_2_1, l_2_2)
	local l_2_7, l_2_8, l_2_9, l_2_10, l_2_11 = nil
	local l_2_3 = Profiler:start("CoreEnvironmentManager2")
	for i_0,i_1 in ipairs(l_2_0._environment_blends) do
		if i_1:update(l_2_1, l_2_2) then
			table.remove(l_2_0._environment_blends, i_0)
		end
	end
	Profiler:stop(l_2_3)
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

EnvironmentManager._set = function(l_3_0, l_3_1, l_3_2, l_3_3)
	l_3_0:set(l_3_2)
end

EnvironmentManager.NUM_FLARE_SLICES = 8
EnvironmentManager.deprecated_init = function(l_4_0, l_4_1)
	l_4_0._net_update_type = 0
	l_4_0._net_update_time = 0
	l_4_0._net_port = 12345
	l_4_0._current_rotation_map = {}
	l_4_0._current_position_map = {}
	l_4_0._rotation_mod_map = {}
	l_4_0._position_mod_map = {}
	l_4_0:setrotation(180)
	l_4_0._dirty = true
	l_4_0._enable_dof = false
	l_4_0._fog_mul = 1
	l_4_0._env_change_cb = {}
	l_4_0._post_processor_effects = {}
	l_4_0._underlay_effects = {}
	l_4_0._preloaded_effects = {}
	l_4_0._preloaded_underlays = {}
	l_4_0._preloaded_sky = {}
	l_4_0._environments = {}
	l_4_0:setup_modifiers()
	if l_4_1 then
		l_4_0._nano_load = true
	elseif not l_4_0._out_sky then
		l_4_0._out_sky = l_4_0:load_sky("default")
	end
	if not l_4_0._out_posteffect then
		l_4_0._out_posteffect = l_4_0:load_post_effect("default")
	end
	if not l_4_0._out_underlayeffect then
		l_4_0._out_underlayeffect = l_4_0:load_underlay_effect("default")
	end
end

EnvironmentManager.set_dof = function(l_5_0, l_5_1, l_5_2, l_5_3, l_5_4, l_5_5, l_5_6)
	managers.DOF:set_dof(l_5_1, l_5_2, l_5_3, l_5_4, l_5_5, l_5_6)
end

EnvironmentManager.set_fog_mul = function(l_6_0, l_6_1)
	l_6_0._fog_mul = l_6_1
	managers.viewport:feed_all_environments()
end

EnvironmentManager.enable_dof = function(l_7_0)
end

EnvironmentManager.disable_dof = function(l_8_0)
end

EnvironmentManager.get_sky = function(l_9_0)
	return l_9_0._current_sky
end

EnvironmentManager.get_underlayeffect = function(l_10_0)
	return l_10_0._current_underlay_effect
end

EnvironmentManager.get_posteffect = function(l_11_0)
	return l_11_0._current_post_effect
end

EnvironmentManager.num_flare_slices = function(l_12_0)
	return l_12_0.NUM_FLARE_SLICES
end

EnvironmentManager.clear_luminance = function(l_13_0)
	l_13_0._luminance_copy_flag = true
end

EnvironmentManager.preload_cubemap = function(l_14_0, l_14_1)
	local l_14_2 = l_14_1:value("global_texture")
	if l_14_2 then
		managers.global_texture:preload(l_14_2, "CUBEMAP")
	end
	return l_14_1
end

EnvironmentManager.prepare_full_load = function(l_15_0, l_15_1)
	if not l_15_1._out_posteffect then
		l_15_1._out_posteffect = l_15_0._out_posteffect
	end
	if not l_15_1._out_underlayeffect then
		l_15_1._out_underlayeffect = l_15_0._out_underlayeffect
	end
	if not l_15_1._out_sky then
		l_15_1._out_sky = l_15_0._out_sky
	end
end

EnvironmentManager.preload_environment = function(l_16_0, l_16_1, l_16_2)
	local l_16_13, l_16_14, l_16_15, l_16_16, l_16_17, l_16_18, l_16_19 = nil
	local l_16_3 = string.lower(l_16_1)
	if not l_16_0._environments[l_16_3] or l_16_2 then
		local l_16_4 = Database:lookup("environment", l_16_3)
		if not l_16_4:valid() then
			print("Can't find environment with name: " .. l_16_1)
			assert(false)
		end
		local l_16_5, l_16_6, l_16_7 = nil, nil, nil
		local l_16_8 = l_16_3
		local l_16_9 = Database:load_node(l_16_4)
		for i_0 in l_16_9:children() do
			if i_0:parameter("name") ~= "" then
				if i_0:name() == "sky" then
					l_16_5 = i_0:parameter("name")
				end
			else
				if i_0:name() == "underlay_effect" then
					l_16_6 = i_0:parameter("name")
				end
			else
				if i_0:name() == "post_effect" then
					l_16_7 = i_0:parameter("name")
				end
			end
		end
		l_16_0._environments[l_16_3] = {}
		l_16_0._environments[l_16_3]._sky = l_16_0:preload_cubemap(l_16_0:load_sky(l_16_5))
		l_16_0._environments[l_16_3]._post_effect = l_16_0:load_post_effect(l_16_7)
		l_16_0._environments[l_16_3]._underlay_effect = l_16_0:load_underlay_effect(l_16_6)
		l_16_0._environments[l_16_3]._sky_name = l_16_5
		l_16_0._environments[l_16_3]._post_effect_name = l_16_7
		l_16_0._environments[l_16_3]._underlay_effect_name = l_16_6
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

EnvironmentManager.change_environment = function(l_17_0, l_17_1)
	Application:throw_exception("Deprecated function!")
end

EnvironmentManager.exists = function(l_18_0, l_18_1)
	return l_18_0._environments[l_18_1] ~= nil
end

EnvironmentManager.exists_on_disk = function(l_19_0, l_19_1)
	local l_19_5, l_19_6 = ipairs, managers.environment:getall()
	l_19_5 = l_19_5(l_19_6)
	for i_0,i_1 in l_19_5 do
		if l_19_1 == l_19_4 then
			return true
		end
	end
	return false
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

EnvironmentManager.get_loaded = function(l_20_0, l_20_1)
	local l_20_6, l_20_7, l_20_8 = nil
	local l_20_2 = {}
	for i_0,i_1 in pairs(l_20_0._environments) do
		table.insert(l_20_2, i_0)
	end
	return l_20_2
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

EnvironmentManager.handled_by_editor = function(l_21_0)
	return l_21_0._handled_by_editor
end

EnvironmentManager.create_environment_change = function(l_22_0, l_22_1, l_22_2, l_22_3)
	l_22_0:preload_environment(l_22_2)
	if l_22_1 then
		l_22_1:set_blend(math.huge)
	end
	local l_22_5 = not l_22_3 or l_22_3 > 0
	do
		local l_22_6 = nil
	end
	local l_22_7 = nil
	do
		local l_22_8 = l_22_1 and l_22_1:env() or l_22_0._environments[l_22_2]
		 -- DECOMPILER ERROR: Confused about usage of registers!

		if l_22_5 then
			({
env = {_post_effect = CorePostEffect.PostEffect:new(), _underlay_effect = CoreUnderlayEffect.UnderlayEffect:new(), _sky = CoreSky.Sky:new()}, env0 = l_22_8, env1 = l_22_7, blend_time = l_22_3, blend = 0, dirty = true}).env._post_effect:copy(({
env = {_post_effect = CorePostEffect.PostEffect:new(), _underlay_effect = CoreUnderlayEffect.UnderlayEffect:new(), _sky = CoreSky.Sky:new()}, env0 = l_22_8, env1 = l_22_7, blend_time = l_22_3, blend = 0, dirty = true}).env0._post_effect)
			 -- DECOMPILER ERROR: Confused about usage of registers!

			 -- DECOMPILER ERROR: Confused about usage of registers!

			({
env = {_post_effect = CorePostEffect.PostEffect:new(), _underlay_effect = CoreUnderlayEffect.UnderlayEffect:new(), _sky = CoreSky.Sky:new()}, env0 = l_22_8, env1 = l_22_7, blend_time = l_22_3, blend = 0, dirty = true}).env._underlay_effect:copy(({
env = {_post_effect = CorePostEffect.PostEffect:new(), _underlay_effect = CoreUnderlayEffect.UnderlayEffect:new(), _sky = CoreSky.Sky:new()}, env0 = l_22_8, env1 = l_22_7, blend_time = l_22_3, blend = 0, dirty = true}).env0._underlay_effect)
			 -- DECOMPILER ERROR: Confused about usage of registers!

			 -- DECOMPILER ERROR: Confused about usage of registers!

			({
env = {_post_effect = CorePostEffect.PostEffect:new(), _underlay_effect = CoreUnderlayEffect.UnderlayEffect:new(), _sky = CoreSky.Sky:new()}, env0 = l_22_8, env1 = l_22_7, blend_time = l_22_3, blend = 0, dirty = true}).env._sky:copy(({
env = {_post_effect = CorePostEffect.PostEffect:new(), _underlay_effect = CoreUnderlayEffect.UnderlayEffect:new(), _sky = CoreSky.Sky:new()}, env0 = l_22_8, env1 = l_22_7, blend_time = l_22_3, blend = 0, dirty = true}).env0._sky)
		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		else
			({
env = {_post_effect = CorePostEffect.PostEffect:new(), _underlay_effect = CoreUnderlayEffect.UnderlayEffect:new(), _sky = CoreSky.Sky:new()}, env0 = l_22_8, env1 = l_22_7, blend_time = l_22_3, blend = 0, dirty = true}).env._post_effect:copy(({
env = {_post_effect = CorePostEffect.PostEffect:new(), _underlay_effect = CoreUnderlayEffect.UnderlayEffect:new(), _sky = CoreSky.Sky:new()}, env0 = l_22_8, env1 = l_22_7, blend_time = l_22_3, blend = 0, dirty = true}).env1._post_effect)
			 -- DECOMPILER ERROR: Confused about usage of registers!

			 -- DECOMPILER ERROR: Confused about usage of registers!

			({
env = {_post_effect = CorePostEffect.PostEffect:new(), _underlay_effect = CoreUnderlayEffect.UnderlayEffect:new(), _sky = CoreSky.Sky:new()}, env0 = l_22_8, env1 = l_22_7, blend_time = l_22_3, blend = 0, dirty = true}).env._underlay_effect:copy(({
env = {_post_effect = CorePostEffect.PostEffect:new(), _underlay_effect = CoreUnderlayEffect.UnderlayEffect:new(), _sky = CoreSky.Sky:new()}, env0 = l_22_8, env1 = l_22_7, blend_time = l_22_3, blend = 0, dirty = true}).env1._underlay_effect)
			 -- DECOMPILER ERROR: Confused about usage of registers!

			 -- DECOMPILER ERROR: Confused about usage of registers!

			({
env = {_post_effect = CorePostEffect.PostEffect:new(), _underlay_effect = CoreUnderlayEffect.UnderlayEffect:new(), _sky = CoreSky.Sky:new()}, env0 = l_22_8, env1 = l_22_7, blend_time = l_22_3, blend = 0, dirty = true}).env._sky:copy(({
env = {_post_effect = CorePostEffect.PostEffect:new(), _underlay_effect = CoreUnderlayEffect.UnderlayEffect:new(), _sky = CoreSky.Sky:new()}, env0 = l_22_8, env1 = l_22_7, blend_time = l_22_3, blend = 0, dirty = true}).env1._sky)
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		if l_22_5 then
			table.insert(l_22_0._environment_blends, CoreLightEnvironment.LightEnvironment:new({
env = {_post_effect = CorePostEffect.PostEffect:new(), _underlay_effect = CoreUnderlayEffect.UnderlayEffect:new(), _sky = CoreSky.Sky:new()}, env0 = l_22_8, env1 = l_22_7, blend_time = l_22_3, blend = 0, dirty = true}))
		end
		return CoreLightEnvironment.LightEnvironment:new({
env = {_post_effect = CorePostEffect.PostEffect:new(), _underlay_effect = CoreUnderlayEffect.UnderlayEffect:new(), _sky = CoreSky.Sky:new()}, env0 = l_22_8, env1 = l_22_7, blend_time = l_22_3, blend = 0, dirty = true})
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

EnvironmentManager.feed = function(l_23_0, l_23_1, l_23_2, l_23_3)
	if not l_23_0._handled_by_editor and l_23_1:dirty() then
		local l_23_4 = Profiler:start("CoreEnvironmentManager2:feed")
		managers.shadow:feed_now()
		l_23_0:set_sky(l_23_1:env()._sky)
		l_23_0:set_underlay_effect(l_23_1:env()._underlay_effect)
		l_23_0:set_post_effect(l_23_1:env()._post_effect, l_23_2, l_23_3)
		l_23_1:set_dirty(false)
		Profiler:stop(l_23_4)
	end
end

EnvironmentManager.update_remote = function(l_24_0, l_24_1, l_24_2)
	if l_24_0._connect then
		l_24_0._net_handler = CoreEnvNetHandler:new(l_24_0._out_sky, l_24_0._out_underlayeffect, l_24_0._out_posteffect)
		if l_24_0._client_ip then
			l_24_0._net_peer = Network:handshake(l_24_0._client_ip, l_24_0._net_port)
		else
			Network:bind(l_24_0._net_port, l_24_0._net_handler)
		end
		l_24_0._connect = nil
		l_24_0._handled_by_editor = true
	end
	if l_24_0._net_peer and l_24_1 - l_24_0._net_update_time > 0.01 then
		l_24_0._net_update_time = l_24_1
		if l_24_0._net_update_type == 0 then
			l_24_0:send_posteffect_params(l_24_0._net_peer, l_24_0._current_post_effect)
		elseif l_24_0._net_update_type == 1 then
			l_24_0:send_underlay_params(l_24_0._net_peer, l_24_0._current_underlay_effect)
		else
			l_24_0:send_sky_params(l_24_0._net_peer, l_24_0._current_sky)
		end
		l_24_0._net_update_type = l_24_0._net_update_type + 1
	if l_24_0._net_update_type > 2 then
		end
		l_24_0._net_update_type = 0
	end
	if l_24_0._from_server and l_24_0._handled_by_editor then
		l_24_0:set_sky(l_24_0._out_sky)
		l_24_0:set_underlay_effect(l_24_0._out_underlayeffect)
		l_24_0:set_post_effect(l_24_0._out_posteffect)
	end
end

EnvironmentManager.paused_update = function(l_25_0, l_25_1, l_25_2)
	l_25_0:update(l_25_1, l_25_2)
end

EnvironmentManager.set_port = function(l_26_0, l_26_1)
	l_26_0._net_port = l_26_1
end

EnvironmentManager.connect_client = function(l_27_0, l_27_1)
	l_27_0._client_ip = l_27_1
	l_27_0._connect = true
end

EnvironmentManager.connect_server = function(l_28_0)
	l_28_0._from_server = true
	l_28_0._connect = true
end

EnvironmentManager.send_posteffect_params = function(l_29_0, l_29_1, l_29_2)
	local l_29_6, l_29_7, l_29_8, l_29_9, l_29_13, l_29_14, l_29_15, l_29_16, l_29_20, l_29_21, l_29_22, l_29_23, l_29_24, l_29_25, l_29_26, l_29_27, l_29_28, l_29_29, l_29_30, l_29_31, l_29_32, l_29_33, l_29_34, l_29_35, l_29_36, l_29_37, l_29_38 = nil
	for i_0,i_1 in pairs(l_29_2._post_processors) do
		for i_0,i_1 in pairs(i_1._modifiers) do
			for i_0,i_1 in pairs(i_1._params) do
				if type(i_1) == "number" then
					l_29_0._net_peer:enveditor_posteffect_float(l_29_10, l_29_19, i_0, i_1)
				else
					if type(i_1) == "string" then
						l_29_0._net_peer:enveditor_posteffect_string(l_29_10, l_29_19, i_0, i_1)
					end
				else
					l_29_0._net_peer:enveditor_posteffect_vector3(l_29_0._net_peer, l_29_10, l_29_19, i_0, i_1)
				end
			end
		end
	end
end

EnvironmentManager.send_underlay_params = function(l_30_0, l_30_1, l_30_2)
	local l_30_6, l_30_7, l_30_8, l_30_9, l_30_13, l_30_14, l_30_15, l_30_16, l_30_17, l_30_18, l_30_19, l_30_20, l_30_21, l_30_22, l_30_23, l_30_24, l_30_25, l_30_26, l_30_27, l_30_28, l_30_29, l_30_30, l_30_31 = nil
	for i_0,i_1 in pairs(l_30_2._materials) do
		for i_0,i_1 in pairs(i_1._params) do
			if type(i_1) == "number" then
				l_30_0._net_peer:enveditor_underlay_float(l_30_10, i_0, i_1)
			else
				if type(i_1) == "string" then
					l_30_0._net_peer:enveditor_underlay_string(l_30_10, i_0, i_1)
				end
			else
				l_30_0._net_peer:enveditor_underlay_vector3(l_30_0._net_peer, l_30_10, i_0, i_1)
			end
		end
	end
end

EnvironmentManager.send_sky_params = function(l_31_0, l_31_1, l_31_2)
	local l_31_6, l_31_7, l_31_8, l_31_9, l_31_10, l_31_11, l_31_12, l_31_13, l_31_14, l_31_15, l_31_16, l_31_17, l_31_18, l_31_19, l_31_20, l_31_21, l_31_22, l_31_23, l_31_24 = nil
	for i_0,i_1 in pairs(l_31_2._params) do
		if type(i_1) == "number" then
			l_31_0._net_peer:enveditor_sky_float(i_0, i_1)
		else
			if type(i_1) == "string" then
				l_31_0._net_peer:enveditor_sky_string(i_0, i_1)
			end
		else
			l_31_0._net_peer:enveditor_sky_vector3(l_31_0._net_peer, i_0, i_1)
		end
	end
end

EnvironmentManager.get_current_environment_name = function(l_32_0)
	return l_32_0._current_env_name
end

EnvironmentManager.getall = function(l_33_0)
	local l_33_6, l_33_7, l_33_8, l_33_9 = nil
	local l_33_1 = {}
	local l_33_2 = Database:all(false, "environment")
	for i_0,i_1 in ipairs(l_33_2) do
		table.insert(l_33_1, i_1:name())
	end
	return l_33_1
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

EnvironmentManager.set_rotation_mod = function(l_34_0, l_34_1, l_34_2, l_34_3)
	if not l_34_0._rotation_mod_map[l_34_1] then
		local l_34_4, l_34_7, l_34_8 = {}
		l_34_7 = l_34_0._rotation_mod_map
		l_34_7[l_34_1] = l_34_4
		l_34_7 = l_34_0._dirty
		l_34_7 = l_34_7 or l_34_3 ~= nil
		l_34_0._dirty = l_34_7
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	if l_34_4[l_34_2] ~= l_34_3 then
		l_34_4[l_34_2] = l_34_3
		l_34_0._dirty = true
	end
end

EnvironmentManager.get_rotation_mod = function(l_35_0, l_35_1, l_35_2)
	local l_35_3 = l_35_0._rotation_mod_map[l_35_1]
	do
		if l_35_3 then
			return l_35_3[l_35_2]
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

EnvironmentManager.set_position_mod = function(l_36_0, l_36_1, l_36_2, l_36_3)
	if not l_36_0._position_mod_map[l_36_1] then
		local l_36_4, l_36_7, l_36_8 = {}
		l_36_7 = l_36_0._position_mod_map
		l_36_7[l_36_1] = l_36_4
		l_36_7 = l_36_0._dirty
		l_36_7 = l_36_7 or l_36_3 ~= nil
		l_36_0._dirty = l_36_7
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	if l_36_4[l_36_2] ~= l_36_3 then
		l_36_4[l_36_2] = l_36_3
		l_36_0._dirty = true
	end
end

EnvironmentManager.get_position_mod = function(l_37_0, l_37_1, l_37_2)
	local l_37_3 = l_37_0._position_mod_map[l_37_1]
	do
		if l_37_3 then
			return l_37_3[l_37_2]
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

EnvironmentManager.get_rotation = function(l_38_0, l_38_1)
	local l_38_8, l_38_9 = nil
	local l_38_2 = l_38_0._current_rotation_map[l_38_1]
	if not l_38_2 then
		local l_38_3 = Underlay:get_object(l_38_1)
		if l_38_3 then
			l_38_2 = l_38_3:rotation()
		else
			l_38_2 = Rotation()
		end
		l_38_0._current_rotation_map[l_38_1] = l_38_2
	end
	local l_38_4 = l_38_0._rotation_mod_map[l_38_1]
	if l_38_4 then
		for i_0,i_1 in pairs(l_38_4) do
			l_38_2 = l_38_2 + i_1
		end
	end
	return l_38_2
end

EnvironmentManager.set_rotation = function(l_39_0, l_39_1, l_39_2)
	if l_39_0._current_rotation_map[l_39_1] ~= l_39_2 then
		l_39_0._current_rotation_map[l_39_1] = l_39_2
		l_39_0._dirty = true
	end
end

EnvironmentManager.get_position = function(l_40_0, l_40_1)
	local l_40_8, l_40_9 = nil
	local l_40_2 = l_40_0._current_position_map[l_40_1]
	if not l_40_2 then
		local l_40_3 = Underlay:get_object(l_40_1)
		if l_40_3 then
			l_40_2 = l_40_3:position()
		else
			l_40_2 = Vector3()
		end
		l_40_0._current_position_map[l_40_1] = l_40_2
	end
	local l_40_4 = l_40_0._position_mod_map[l_40_1]
	if l_40_4 then
		for i_0,i_1 in pairs(l_40_4) do
			l_40_2 = l_40_2 + i_1
		end
	end
	return l_40_2
end

EnvironmentManager.set_position = function(l_41_0, l_41_1, l_41_2)
	if l_41_0._current_position_map[l_41_1] ~= l_41_2 then
		l_41_0._current_position_map[l_41_1] = l_41_2
		l_41_0._dirty = true
	end
end

EnvironmentManager.setrotation = function(l_42_0, l_42_1)
	l_42_0:set_rotation("sky", Rotation(0, 0, l_42_1))
end

EnvironmentManager.rotation = function(l_43_0)
	local l_43_3 = l_43_0:get_rotation
	l_43_3 = l_43_3(l_43_0, "sky")
	local l_43_1, l_43_2 = l_43_3
	return l_43_3(l_43_1)
end

EnvironmentManager.get_sky_rotation = function(l_44_0)
	local l_44_1, l_44_2 = l_44_0:rotation, l_44_0
	return l_44_1(l_44_2)
end

EnvironmentManager.set = function(l_45_0, l_45_1, l_45_2)
	Application:throw_exception("Deprecated function!")
end

EnvironmentManager.set_visualization = function(l_46_0, l_46_1)
	Application:error("No visualizations available!")
end

EnvironmentManager.get = function(l_47_0)
	return l_47_0._current_env_name
end

EnvironmentManager.needs_update = function(l_48_0, l_48_1)
	do
		l_48_0._dirty = l_48_1 or true
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

EnvironmentManager.reg_env_change_cb = function(l_49_0, l_49_1, l_49_2)
	local l_49_3 = l_49_0._env_change_cb
	do
		l_49_3[l_49_1] = l_49_2 or l_49_1
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

EnvironmentManager.un_env_change_cb = function(l_50_0, l_50_1)
	l_50_0._env_change_cb[l_50_1] = nil
end

EnvironmentManager.call_change_cb = function(l_51_0)
	local l_51_4, l_51_5, l_51_6, l_51_7, l_51_8 = nil
	for i_0,i_1 in pairs(l_51_0._env_change_cb) do
		i_0(i_1)
	end
end

EnvironmentManager.flush = function(l_52_0)
	l_52_0._post_processor_effects = {}
	l_52_0._underlay_effects = {}
	l_52_0._current_sky = nil
	l_52_0._current_underlay_effect = nil
	l_52_0._current_post_effect = nil
	l_52_0._current_underlay_file = nil
	l_52_0._dirty = true
end

EnvironmentManager.set_global_texture_stream_time = function(l_53_0, l_53_1)
	l_53_0._global_texture_stream_time = l_53_1
end

EnvironmentManager.set_light_adaption = function(l_54_0, l_54_1)
end

EnvironmentManager.light_adaption = function(l_55_0)
end

EnvironmentManager.sun_dir = function(l_56_0)
	local l_56_1 = Underlay:get_object("anim_sun")
	do
		if l_56_1 then
			return l_56_1:rotation():y()
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

EnvironmentManager.flare_dir = function(l_57_0)
	if l_57_0._flare_obj then
		return l_57_0._flare_obj:rotation():y()
	end
end

EnvironmentManager.load_underlay_now = function(l_58_0, l_58_1)
	local l_58_2 = assert(l_58_0._environments[l_58_1], "The environment is not preloaded!")._sky:value("underlay")
	l_58_0:load_underlay_now_with_name(l_58_2)
end

EnvironmentManager.load_underlay_now_with_name = function(l_59_0, l_59_1)
	Underlay:load(l_59_1)
	l_59_0._flare_obj = Underlay:get_object("anim_flare")
	l_59_0._sun_x_obj = Underlay:get_object("anim_sun_horizontal")
	local l_59_2 = Underlay:get_object("anim_sun")
	assert(not Underlay:get_object("sky") or l_59_2, "Could not find object sky or sun in underlay: " .. l_59_1)
	l_59_0._current_underlay_file = l_59_1
end

EnvironmentManager.no_underlay_needed = function(l_60_0)
	l_60_0._no_underlay_needed = true
end

EnvironmentManager.unload_underlay = function(l_61_0)
	if Underlay:loaded() then
		Underlay:unload()
		l_61_0._current_sky = nil
		l_61_0._current_underlay_file = nil
	end
end

EnvironmentManager.destroy = function(l_62_0)
	if CoreCode.alive(l_62_0._light) then
		World:delete_light(l_62_0._light)
	end
	if CoreCode.alive(l_62_0._camera) then
		Underlay:delete_camera(l_62_0._camera)
	end
end

EnvironmentManager.set_sky = function(l_63_0, l_63_1)
	local l_63_2 = false
	local l_63_3 = l_63_1:value("underlay")
	if l_63_0._current_sky ~= l_63_1 or l_63_0._current_underlay_file ~= l_63_3 then
		if not CoreCode.alive(l_63_0._light) then
			l_63_0._light = World:create_light("directional|specular")
			l_63_2 = true
		end
		if (l_63_0._current_underlay_file ~= l_63_3 and not l_63_0._no_underlay_needed) or not Underlay:loaded() then
			l_63_0:load_underlay_now_with_name(l_63_3)
			l_63_2 = true
		end
		l_63_0._current_underlay_file = l_63_3
	if l_63_2 or not CoreCode.alive(l_63_0._camera) then
		end
		if CoreCode.alive(l_63_0._camera) then
			Underlay:delete_camera(l_63_0._camera)
		end
		l_63_2 = true
		l_63_0._camera = Underlay:create_camera()
		l_63_0._camera:set_near_range(1000)
		l_63_0._camera:set_far_range(10000000)
		l_63_0._camera:set_fov(75)
		local l_63_4 = Underlay:get_object("camera_ref")
		if not l_63_4 then
			l_63_0._camera:set_local_position(Vector3(0, 0, 0))
		else
			l_63_0._camera:set_local_position(l_63_4:position())
		end
		Underlay:set_reference_camera(l_63_0._camera)
	end
	l_63_0._current_sky = l_63_1
	do
		local l_63_5, l_63_6, l_63_7, l_63_15, l_63_16, l_63_17, l_63_18, l_63_20 = l_63_1:value("sun_ray_color_scale") or 1
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	if type(l_63_5) == "string" then
		local l_63_8 = nil
		local l_63_9 = nil
		local l_63_10 = nil
		local l_63_11 = string.sub(l_63_9, 1, string.find(string.sub(l_63_5, 2), "#") - 1)
		local l_63_12 = string.sub(l_63_9, l_63_10 + 1)
		assert(l_63_11 == "LightIntensityDB")
		assert(LightIntensityDB:lookup(l_63_12))
		l_63_8 = LightIntensityDB:lookup(l_63_12)
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	l_63_0._light:set_color(l_63_1:value("sun_ray_color") * l_63_8)
	if l_63_2 then
		l_63_0._light:link(Underlay:get_object("anim_sun"))
		local l_63_19 = nil
		l_63_0._light:set_local_rotation(Rotation(-90, 0, 0))
		World:set_global_shadow_caster(l_63_0._light)
	end
	local l_63_21 = nil
	if l_63_1:value("global_texture") and l_63_1:value("global_texture") ~= "" and l_63_1:value("global_texture") ~= managers.global_texture:current_texture_name() then
		managers.global_texture:set_texture(l_63_1:value("global_texture"), "CUBEMAP", l_63_0._global_texture_stream_time)
	end
	l_63_0:apply_sky_rotation(l_63_1)
	l_63_0:apply_flare_rotation(l_63_1)
	l_63_0:call_change_cb()
	l_63_0._no_underlay_needed = false
end

EnvironmentManager.apply_sky_rotation = function(l_64_0, l_64_1)
	local l_64_5, l_64_6, l_64_8, l_64_9 = nil
	for i_0 in pairs(l_64_0._current_rotation_map) do
		if Underlay:get_object(i_0) then
			Underlay:get_object(i_0):set_rotation(l_64_0:get_rotation(l_64_7))
		end
	end
	for i_0 in pairs(l_64_0._current_position_map) do
		if Underlay:get_object(i_0) then
			Underlay:get_object(i_0):set_position(l_64_0:get_position(l_64_10))
		end
	end
	Underlay:set_time("sun", l_64_1:value("sun_anim") * Underlay:length("sun"))
	if not l_64_1:value("sun_anim_x") then
		Underlay:set_time("sun_horizontal", (not l_64_0._sun_x_obj or 0) * Underlay:length("sun_horizontal"))
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 59 
end

EnvironmentManager.apply_flare_rotation = function(l_65_0, l_65_1)
	if not l_65_1:value("flare_anim_y") then
		Underlay:set_time("flare", (not l_65_0._flare_obj or 0) * Underlay:length("flare"))
		Underlay:set_time("flare_horizontal", (l_65_1:value("flare_anim_x") or 0) * Underlay:length("flare_horizontal"))
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 13 
end

EnvironmentManager.set_underlay_effect = function(l_66_0, l_66_1)
	local l_66_5, l_66_6, l_66_7, l_66_8, l_66_9, l_66_10, l_66_11, l_66_12, l_66_13, l_66_18, l_66_19, l_66_20, l_66_21, l_66_22, l_66_23, l_66_24, l_66_25, l_66_26, l_66_27, l_66_28, l_66_29, l_66_30, l_66_31, l_66_32 = nil
	if Underlay:loaded() then
		l_66_0._current_underlay_effect = l_66_1
		for i_0,i_1 in pairs(l_66_1._materials) do
			if not CoreCode.alive(l_66_0._underlay_effects[i_0]) then
				l_66_0._underlay_effects[i_0] = Underlay:material(i_0)
			end
			if l_66_0._underlay_effects[i_0] then
				for i_0,i_1 in pairs(i_1._params) do
					local l_66_16 = nil
					if string.sub(i_0, 1, 1) ~= "$" then
						if l_66_15._params[i_0 .. "_scale"] then
							l_66_16:set_variable(i_0, l_66_0:modify_underlayeffect(l_66_14, i_0, i_1 * l_66_15._params[i_0 .. "_scale"]))
						end
					else
						l_66_16:set_variable(i_0, l_66_0:modify_underlayeffect(l_66_14, i_0, i_1))
					end
				end
			end
		end
		l_66_0:call_change_cb()
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	else
		Application:error("[EnvironmentManager] WARNING! Trying to set underlay effect without having a Underlay loaded!")
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

EnvironmentManager.set_post_effect = function(l_67_0, l_67_1, l_67_2, l_67_3)
	local l_67_7, l_67_8, l_67_9, l_67_10, l_67_11, l_67_12, l_67_13, l_67_14, l_67_15, l_67_16, l_67_17, l_67_18, l_67_19, l_67_20, l_67_21, l_67_22, l_67_23, l_67_24, l_67_25, l_67_26, l_67_44, l_67_46 = nil
	l_67_0._current_post_effect = l_67_1
	for i_0,i_1 in pairs(l_67_1._post_processors) do
		l_67_0._post_processor_effects[i_0] = {}
		l_67_0._post_processor_effects[i_0]._modifiers = {}
		l_67_0._post_processor_effects[i_0].proc = l_67_2:get_post_processor_effect(l_67_3, i_0, i_1._effect)
		if not l_67_0._post_processor_effects[l_67_33].proc then
			local l_67_31, l_67_32 = Application:error, Application
			l_67_31(l_67_32, "Can't find post processor effect: " .. l_67_33)
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		for i_0,i_1 in pairs(l_67_30._modifiers) do
			local l_67_27 = nil
			if not l_67_0._post_processor_effects[l_67_33]._modifiers[i_0] and l_67_0._post_processor_effects[l_67_33].proc:modifier(i_0) then
				local l_67_40, l_67_41, l_67_42, l_67_43, l_67_45 = , l_67_0._post_processor_effects[l_67_33]._modifiers, l_67_0._post_processor_effects[l_67_33].proc:modifier(i_0):material, l_67_0._post_processor_effects[l_67_33].proc:modifier(i_0)
				l_67_42 = l_67_42(l_67_43)
				l_67_41[l_67_38] = l_67_42
			end
			 -- DECOMPILER ERROR: Confused about usage of registers!

			for i_0,i_1 in pairs(l_67_39._params) do
				local l_67_35, l_67_36, l_67_37 = nil
				 -- DECOMPILER ERROR: Overwrote pending register.

				if string.sub(i_0, 1, 1) ~= "$" and (l_67_0._enable_dof or not l_67_0:is_dof_parameter(l_67_33, l_67_36, i_0)) and l_67_0._post_processor_effects[l_67_33]._modifiers[l_67_36] then
					if l_67_37._params[i_0 .. "_scale"] then
						do return end
					end
					 -- DECOMPILER ERROR: Overwrote pending register.

					 -- DECOMPILER ERROR: Confused about usage of registers!

					l_67_0._post_processor_effects[l_67_33]._modifiers[l_67_36]:set_variable(i_0, nil)
				end
			end
		end
	end
	l_67_0:call_change_cb()
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

EnvironmentManager.is_dof_parameter = function(l_68_0, l_68_1, l_68_2, l_68_3)
	if l_68_1 == "hdr_post_processor" and l_68_2 == "dof" and (l_68_3 == "near_focus_distance_min" or l_68_3 == "near_focus_distance_max" or l_68_3 == "far_focus_distance_min" or l_68_3 == "far_focus_distance_max" or l_68_3 == "clamp") then
		return true
	end
	return false
end

EnvironmentManager.load_post_effect = function(l_69_0, l_69_1)
	if not l_69_0._preloaded_effects[l_69_1] then
		local l_69_2 = Database:lookup("environment_effect", l_69_1)
		assert(l_69_2:valid(), l_69_1)
		l_69_0._preloaded_effects[l_69_1] = Database:load_node(l_69_2)
	end
	local l_69_3 = CorePostEffect.PostEffect:new()
	l_69_3:set_name(l_69_1)
	l_69_3:parse(l_69_0._preloaded_effects[l_69_1])
	return l_69_3
end

EnvironmentManager.load_underlay_effect = function(l_70_0, l_70_1)
	if not l_70_0._preloaded_underlays[l_70_1] then
		local l_70_2 = Database:lookup("environment_underlay", l_70_1)
		assert(l_70_2:valid(), l_70_1)
		l_70_0._preloaded_underlays[l_70_1] = Database:load_node(l_70_2)
	end
	local l_70_3 = CoreUnderlayEffect.UnderlayEffect:new()
	l_70_3:set_name(l_70_1)
	l_70_3:parse(l_70_0._preloaded_underlays[l_70_1])
	return l_70_3
end

EnvironmentManager.load_sky = function(l_71_0, l_71_1)
	if not l_71_0._preloaded_sky[l_71_1] then
		local l_71_2 = Database:lookup("environment_sky", l_71_1)
		assert(l_71_2:valid(), l_71_1)
		l_71_0._preloaded_sky[l_71_1] = Database:load_node(l_71_2)
	end
	local l_71_3 = CoreSky.Sky:new()
	l_71_3:set_name(l_71_1)
	l_71_3:parse(l_71_0._preloaded_sky[l_71_1])
	return l_71_3
end

EnvironmentManager.get_current_sky = function(l_72_0)
	local l_72_1 = l_72_0:get_current_environment_name()
	if l_72_1 then
		local l_72_2 = l_72_0._environments[l_72_1]
	if l_72_2 then
		end
		return l_72_2._sky_name
	end
end

EnvironmentManager.get_current_post_effect = function(l_73_0)
	local l_73_1 = l_73_0:get_current_environment_name()
	if l_73_1 then
		local l_73_2 = l_73_0._environments[l_73_1]
	if l_73_2 then
		end
		return l_73_2._post_effect_name
	end
end

EnvironmentManager.get_current_underlay_effect = function(l_74_0)
	local l_74_1 = l_74_0:get_current_environment_name()
	if l_74_1 then
		local l_74_2 = l_74_0._environments[l_74_1]
	if l_74_2 then
		end
		return l_74_2._underlay_effect_name
	end
end

EnvironmentManager.setup_modifiers = function(l_75_0)
	l_75_0:clear_all_modifiers()
	l_75_0:add_post_processors_modifier("hdr_post_processor", "tone_mapping", "luminance_clamp")
	l_75_0:add_post_processors_modifier("fog_processor", "fog", "start_color")
	l_75_0:add_post_processors_modifier("fog_processor", "fog", "color0")
	l_75_0:add_post_processors_modifier("fog_processor", "fog", "color1")
	l_75_0:add_post_processors_modifier("fog_processor", "fog", "color2")
	l_75_0:add_post_processors_modifier("fog_processor", "fog", "end0", "value * managers.environment._fog_mul")
	l_75_0:add_post_processors_modifier("fog_processor", "fog", "end1", "value * managers.environment._fog_mul")
	l_75_0:add_post_processors_modifier("fog_processor", "fog", "end2", "value * managers.environment._fog_mul")
	l_75_0:add_post_processors_modifier("deferred", "apply_ambient", "environment_map_intensity")
	l_75_0:add_post_processors_modifier("deferred", "apply_ambient", "environment_map_intensity_shadow")
	l_75_0:add_post_processors_modifier("deferred", "apply_ambient", "ambient_color")
	l_75_0:add_post_processors_modifier("deferred", "apply_ambient", "sky_top_color")
	l_75_0:add_post_processors_modifier("deferred", "apply_ambient", "sky_bottom_color")
	l_75_0:add_post_processors_modifier("deferred", "apply_ambient", "sky_reflection_bottom_color")
	l_75_0:add_post_processors_modifier("deferred", "apply_ambient", "sky_reflection_top_color")
	l_75_0:add_post_processors_modifier("deferred", "apply_ambient", "sun_specular_color")
	l_75_0:add_underlay_modifier("sky", "sun_color_scale")
	l_75_0:add_underlay_modifier("sky", "color0_scale")
	l_75_0:add_underlay_modifier("sky", "color1_scale")
	l_75_0:add_underlay_modifier("sky", "color2_scale")
	l_75_0:add_underlay_modifier("cloud_overlay", "color_opposite_sun_scale")
	l_75_0:add_underlay_modifier("cloud_overlay", "color_sun_scale")
	l_75_0:add_underlay_modifier("sky_top", "sky_intensity")
	l_75_0:add_underlay_modifier("sky_bottom", "sky_intensity")
end

EnvironmentManager.create_mod_function = function(l_76_0, l_76_1)
	if not l_76_1 or not assert(loadstring("local _t = {...}; local value = _t[1]; return " .. l_76_1)) then
		return l_76_0.mod_function_mul_intensity
	end
end

EnvironmentManager.mod_function_mul_intensity = function(l_77_0)
	return l_77_0 * LightIntensityDB:platform_intensity_scale()
end

EnvironmentManager.add_post_processors_modifier = function(l_78_0, l_78_1, l_78_2, l_78_3, l_78_4)
	local l_78_5 = table.insert
	local l_78_6 = l_78_0._post_effect_mods
	local l_78_7 = {}
	l_78_7._name = "post_effect_modifier"
	l_78_7._pro = l_78_1
	l_78_7._mod = l_78_2
	l_78_7._param = l_78_3
	l_78_7._code = l_78_0:create_mod_function(l_78_4)
	l_78_5(l_78_6, l_78_7)
end

EnvironmentManager.add_underlay_modifier = function(l_79_0, l_79_1, l_79_2, l_79_3)
	local l_79_4 = table.insert
	local l_79_5 = l_79_0._underlay_mods
	local l_79_6 = {}
	l_79_6._name = "underlay_modifier"
	l_79_6._mat = l_79_1
	l_79_6._param = l_79_2
	l_79_6._code = l_79_0:create_mod_function(l_79_3)
	l_79_4(l_79_5, l_79_6)
end

EnvironmentManager.add_sky_modifier = function(l_80_0, l_80_1, l_80_2)
	local l_80_3 = table.insert
	local l_80_4 = l_80_0._sky_mods
	local l_80_5 = {}
	l_80_5._name = "sky_modifier"
	l_80_5._param = l_80_1
	l_80_5._code = l_80_0:create_mod_function(l_80_2)
	l_80_3(l_80_4, l_80_5)
end

EnvironmentManager.clear_all_modifiers = function(l_81_0)
	l_81_0._post_effect_mods = {}
	l_81_0._underlay_mods = {}
	l_81_0._sky_mods = {}
end

EnvironmentManager.modify_underlayeffect = function(l_82_0, l_82_1, l_82_2, l_82_3)
	local l_82_7, l_82_8, l_82_9, l_82_10, l_82_11, l_82_12, l_82_13, l_82_14 = nil
	for i_0,i_1 in ipairs(l_82_0._underlay_mods) do
		if l_82_1 == i_1._mat and l_82_2 == i_1._param then
			return i_1._code(l_82_3)
		end
	end
	return l_82_3
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

EnvironmentManager.modify_posteffect = function(l_83_0, l_83_1, l_83_2, l_83_3, l_83_4)
	local l_83_8, l_83_9, l_83_10, l_83_11, l_83_12, l_83_13, l_83_14, l_83_15, l_83_16, l_83_17 = nil
	for i_0,i_1 in ipairs(l_83_0._post_effect_mods) do
		if l_83_1 == i_1._pro and l_83_2 == i_1._mod and l_83_3 == i_1._param then
			return i_1._code(l_83_4)
		end
	end
	return l_83_4
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end


