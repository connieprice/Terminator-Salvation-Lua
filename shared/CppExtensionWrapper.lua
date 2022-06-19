cpp_extension_wrapper = function(l_1_0)
	local l_1_1 = {}
	l_1_1.init = function(l_2_0, ...)
		-- upvalues: l_1_0
		l_2_0.cpp_class_instance = l_1_0:new(...)
		local l_2_2 = nil
		setmetatable(l_2_0, {__index = function(l_3_0, l_3_1)
			-- upvalues: l_1_2
			local l_3_2 = l_1_2[l_3_1]
			if l_3_2 then
				return function(l_4_0, ...)
				-- upvalues: l_1_2 , l_1_2
				local l_4_2 = l_1_2
				local l_4_3 = l_1_2
				return l_4_2(l_4_3, ...)
      end
			else
				return nil
			end
    end})
  end
	l_1_1.__index = l_1_1
	return l_1_1
end


