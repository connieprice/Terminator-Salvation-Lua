core:module("CoreShadowManager")
core:require_module("CoreClass")
core:require_module("CoreCode")
if not ShadowBlock then
	ShadowBlock = CoreClass.class()
end
ShadowBlock.init = function(l_1_0)
	l_1_0._parameters = {}
end

ShadowBlock.map = function(l_2_0)
	return l_2_0._parameters
end

ShadowBlock.set = function(l_3_0, l_3_1, l_3_2)
	l_3_0._parameters[l_3_1] = l_3_2
end

ShadowBlock.get = function(l_4_0, l_4_1)
	return l_4_0._parameters[l_4_1]
end

if not ShadowManager then
	ShadowManager = CoreClass.class()
end
ShadowManager.init = function(l_5_0)
	l_5_0._preloaded_shadow_blocks = {}
	l_5_0._stack = {}
	l_5_0._shadow_mul = 1
	l_5_0._needs_update = false
end

ShadowManager.update = function(l_6_0, l_6_1, l_6_2)
end

ShadowManager.paused_update = function(l_7_0, l_7_1, l_7_2)
	l_7_0:update(l_7_1, l_7_2)
end

ShadowManager.load = function(l_8_0, l_8_1)
	if not l_8_0._preloaded_shadow_blocks[l_8_1] then
		Application:stack_dump_error("[ShadowManager] Shadow block not preloaded: ", l_8_1)
		l_8_0:preload(l_8_1)
	end
	return l_8_0._preloaded_shadow_blocks[l_8_1]
end

ShadowManager.list = function(l_9_0, l_9_1)
	local l_9_7, l_9_8, l_9_9, l_9_10 = nil
	local l_9_2 = {}
	local l_9_3 = Database:all(false, "shadow_setting")
	for i_0,i_1 in ipairs(l_9_3) do
		if not l_9_1 or string.find(i_1:name(), l_9_1) then
			table.insert(l_9_2, i_1:name())
		end
	end
	return l_9_2
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

ShadowManager.get = function(l_10_0)
	return l_10_0._current_shadow_block
end

ShadowManager.stack_size = function(l_11_0)
	return #l_11_0._stack
end

ShadowManager.push = function(l_12_0, l_12_1)
	local l_12_2 = nil
	if type(l_12_1) == "string" then
		l_12_2 = assert(l_12_0._preloaded_shadow_blocks[l_12_1], "Shadow settings are not preloaded!")
	else
		l_12_2 = l_12_1
	end
	if l_12_0._current_shadow_block then
		table.insert(l_12_0._stack, l_12_0._current_shadow_block)
	end
	local l_12_4 = l_12_0:set
	l_12_4(l_12_0, l_12_2)
	local l_12_3 = l_12_0
	return l_12_4(l_12_3)
end

ShadowManager.pop = function(l_13_0)
	local l_13_1 = l_13_0:stack_size()
	if l_13_1 > 0 then
		l_13_0:set(l_13_0._stack[l_13_1])
		table.remove(l_13_0._stack)
		l_13_1 = l_13_1 - 1
	end
	return l_13_1
end

ShadowManager.set = function(l_14_0, l_14_1)
	l_14_0._needs_update = true
	if type(l_14_1) == "string" then
		l_14_0._current_shadow_block = assert(l_14_0._preloaded_shadow_blocks[l_14_1], "Shadow settings are not preloaded!")
	else
		l_14_0._current_shadow_block = l_14_1
	end
	l_14_0:feed_now()
end

ShadowManager.feed_now = function(l_15_0)
	if l_15_0._current_shadow_block then
		local l_15_1 = l_15_0._current_shadow_block
		l_15_0:_set_split_depths(l_15_1:get("d0"), l_15_1:get("d1"), l_15_1:get("d2"), l_15_1:get("d3"), l_15_1:get("o1"), l_15_1:get("o2"), l_15_1:get("o3"), l_15_1:get("f"))
		l_15_0._needs_update = false
	end
end

ShadowManager.set_now = function(l_16_0, l_16_1)
	l_16_0:set(l_16_1)
	l_16_0:feed_now()
end

ShadowManager.set_shadow_mul = function(l_17_0, l_17_1)
	l_17_0._shadow_mul = l_17_1
	l_17_0:feed_now()
end

ShadowManager.preload = function(l_18_0, l_18_1, l_18_2)
	if l_18_2 or not l_18_0._preloaded_shadow_blocks[l_18_1] then
		local l_18_3 = ShadowBlock:new()
		l_18_0._preloaded_shadow_blocks[l_18_1] = l_18_3
		local l_18_4 = Database:lookup("shadow_setting", l_18_1)
		assert(l_18_4:valid())
		local l_18_9 = assert
		l_18_9 = l_18_9(Database:load_node(l_18_4))
		local l_18_5 = nil
		 -- DECOMPILER ERROR: Overwrote pending register.

		for i_0 in l_18_5 do
			local l_18_10 = l_18_8:parameter("type")
			if l_18_10 == "Vector3" then
				l_18_3:set(l_18_8:name(), math.string_to_vector(l_18_8:parameter("value")))
			elseif l_18_10 == "number" then
				l_18_3:set(l_18_8:name(), tonumber(l_18_8:parameter("value")))
			else
				l_18_3:set(l_18_8:name(), l_18_8:parameter("value"))
			end
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

ShadowManager._set_split_depths = function(l_19_0, l_19_1, l_19_2, l_19_3, l_19_4, l_19_5, l_19_6, l_19_7, l_19_8)
	local l_19_12, l_19_13 = ipairs, managers.viewport:active_viewports()
	l_19_12 = l_19_12(l_19_13)
	for i_0,i_1 in l_19_12 do
		if not CoreCode.alive(l_19_11.__shadow_material) then
			l_19_11.__shadow_material = l_19_11._vp:get_post_processor_effect(l_19_11._render_params[1], "shadow_processor"):modifier("shadow_modifier"):material()
		end
		l_19_0._shadow_material = l_19_11.__shadow_material
		if RenderSettings.split_screen then
			local l_19_14 = Vector3(0, 0, 0)
			local l_19_15 = Vector3(0, 0, 0)
			local l_19_16 = Vector3(0, 1600, 0)
			local l_19_17 = Vector3(1300, 5000, 0)
			local l_19_18 = Vector3(0, 0, 1600)
			local l_19_19 = Vector3(0, 0, 300)
			l_19_0._shadow_material:set_variable("slice0", l_19_14)
			l_19_0._shadow_material:set_variable("slice1", l_19_15)
			l_19_0._shadow_material:set_variable("slice2", l_19_16)
			l_19_0._shadow_material:set_variable("slice3", l_19_17)
			l_19_0._shadow_material:set_variable("shadow_slice_depths", l_19_18)
			l_19_0._shadow_material:set_variable("shadow_slice_overlap", l_19_19)
			l_19_0._shadow_material:set_variable("shadow_fadeout", Vector3(4500, 5000, 0))
		else
			local l_19_20 = Vector3(0, l_19_1, 0)
			local l_19_21 = Vector3(l_19_1 - l_19_5, l_19_2, 0)
			local l_19_22 = Vector3(l_19_2 - l_19_6, l_19_3, 0)
			local l_19_23 = Vector3(l_19_3 - l_19_7, l_19_4, 0)
			local l_19_24 = Vector3(l_19_1, l_19_2, l_19_3)
			local l_19_25 = Vector3(l_19_5, l_19_6, l_19_7)
			l_19_0._shadow_material:set_variable("slice0", l_19_20 * l_19_0._shadow_mul)
			l_19_0._shadow_material:set_variable("slice1", l_19_21 * l_19_0._shadow_mul)
			l_19_0._shadow_material:set_variable("slice2", l_19_22 * l_19_0._shadow_mul)
			l_19_0._shadow_material:set_variable("slice3", l_19_23 * l_19_0._shadow_mul)
			l_19_0._shadow_material:set_variable("shadow_slice_depths", l_19_24 * l_19_0._shadow_mul)
			l_19_0._shadow_material:set_variable("shadow_slice_overlap", l_19_25 * l_19_0._shadow_mul)
			l_19_0._shadow_material:set_variable("shadow_fadeout", Vector3(l_19_4 - l_19_8, l_19_4, 0) * l_19_0._shadow_mul)
		end
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end


