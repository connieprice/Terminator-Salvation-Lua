if not CoreGTextureManager then
	CoreGTextureManager = class()
end
CoreGTextureManager.init = function(l_1_0)
	l_1_0._preloaded = {}
	l_1_0._global_texture = nil
	l_1_0._texture_name = nil
	l_1_0._texture_type = nil
	l_1_0._texture = nil
	l_1_0._delay = nil
end

CoreGTextureManager.set_texture = function(l_2_0, l_2_1, l_2_2, l_2_3)
	if SystemInfo:platform() ~= "PS3" then
		local l_2_4 = l_2_3
	else
		l_2_0._delay = false
	end
	l_2_0._texture_name = l_2_1
	l_2_0._texture_type = l_2_2
	if l_2_3 then
		TextureCache:request(l_2_1, l_2_2, function()
  end)
	else
		l_2_0:_retrieve()
	end
end

CoreGTextureManager.preload = function(l_3_0, l_3_1, l_3_2)
	if type(l_3_1) == "string" and not l_3_0._preloaded[l_3_1] then
		local l_3_6, l_3_8, l_3_10, l_3_12, l_3_14 = l_3_0._preloaded, TextureCache:retrieve, TextureCache, l_3_1
		l_3_14 = l_3_2
		local l_3_7, l_3_9, l_3_11, l_3_13, l_3_15 = nil
		l_3_8 = l_3_8(l_3_10, l_3_12, l_3_14)
		l_3_6[l_3_1] = l_3_8
	end
	do return end
	for i_0,i_1 in ipairs(l_3_1) do
		if not l_3_0._preloaded[i_1.name] then
			l_3_0._preloaded[i_1.name] = TextureCache:retrieve(l_3_17.name, l_3_17.type)
		end
	end
end

CoreGTextureManager.current_texture_name = function(l_4_0)
	return l_4_0._texture_name
end

CoreGTextureManager.prepare_full_load = function(l_5_0, l_5_1)
	l_5_0:_unretrieve()
	l_5_1._preloaded = l_5_0._preloaded
end

CoreGTextureManager.is_streaming = function(l_6_0)
	return l_6_0._delay ~= nil
end

CoreGTextureManager.reload = function(l_7_0)
	if l_7_0._texture then
		l_7_0:_retrieve()
	end
end

CoreGTextureManager.update = function(l_8_0, l_8_1, l_8_2)
	if l_8_0._delay then
		l_8_0._delay = l_8_0._delay - l_8_2
	if l_8_0._delay <= 0 then
		end
		l_8_0:_retrieve()
		l_8_0._delay = nil
	end
end

CoreGTextureManager.paused_update = function(l_9_0, l_9_1, l_9_2)
	l_9_0:update(l_9_1, l_9_2)
end

CoreGTextureManager.destroy = function(l_10_0)
	l_10_0:_unretrieve()
	l_10_0:_unref_preloaded()
end

CoreGTextureManager._unref_preloaded = function(l_11_0)
	local l_11_4, l_11_5, l_11_6, l_11_7 = nil
	for i_0,i_1 in pairs(l_11_0._preloaded) do
		TextureCache:unretrieve(i_1)
	end
end

CoreGTextureManager._unretrieve = function(l_12_0)
	if l_12_0._texture then
		GlobalTextureManager:set_texture("current_global_texture", nil)
		TextureCache:unretrieve(l_12_0._texture)
		l_12_0._texture = nil
	end
end

CoreGTextureManager._retrieve = function(l_13_0)
	l_13_0:_unretrieve()
	l_13_0._texture = TextureCache:retrieve(l_13_0._texture_name, l_13_0._texture_type)
	GlobalTextureManager:set_texture("current_global_texture", l_13_0._texture)
end


