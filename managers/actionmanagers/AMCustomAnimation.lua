if not AMCustomAnimation then
	AMCustomAnimation = class(CoreActionElement)
end
AMCustomAnimation.init = function(l_1_0, l_1_1, l_1_2)
	CoreActionElement.init(l_1_0, l_1_1, l_1_2)
end

AMCustomAnimation.activate_now = function(l_2_0)
	local l_2_4, l_2_5, l_2_6, l_2_7, l_2_8, l_2_9 = nil
	do
	end
	for i_0,i_1 in pairs(l_2_0.units) do
		managers.unit_scripting:get_unit_by_name_callback(i_1.script_name, function(l_3_0)
			-- upvalues: l_2_6
			if alive(l_3_0) then
				l_3_0:base():play_custom_animation(l_2_6)
			end
    end)
	end
	l_2_0:deactivate_now()
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	 -- WARNING: undefined locals caused missing assignments!
end


