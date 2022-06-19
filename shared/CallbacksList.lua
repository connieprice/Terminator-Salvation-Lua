if not CallbacksList then
	CallbacksList = class()
end
CallbacksList.init = function(l_1_0)
	l_1_0._callbacks = {}
end

CallbacksList.add = function(l_2_0, l_2_1, l_2_2)
	local l_2_3 = assert
	l_2_3(type(l_2_2) ~= "table")
	l_2_3 = assert
	l_2_3(not l_2_0._callbacks[l_2_1], "Callback id already registered!")
	l_2_3 = l_2_0._callbacks
	l_2_3[l_2_1] = l_2_2
end

CallbacksList.remove = function(l_3_0, l_3_1)
	assert(l_3_0._callbacks[l_3_1], "Callback id not registered!")
	l_3_0._callbacks[l_3_1] = nil
end

CallbacksList.call = function(l_4_0, ...)
	local l_4_4, l_4_5, l_4_6, l_4_7 = nil
	for i_0,i_1 in pairs(l_4_0._callbacks) do
		i_1(...)
	end
end

CallbacksList.public_interface = function(l_5_0)
	local l_5_1 = {}
	l_5_1.add = function(...)
		-- upvalues: l_5_0
		l_5_0:add(...)
  end
	l_5_1.remove = function(...)
		-- upvalues: l_5_0
		l_5_0:remove(...)
  end
	return l_5_1
end


