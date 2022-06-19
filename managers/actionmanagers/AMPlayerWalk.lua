if not AMPlayerWalk then
	AMPlayerWalk = class(CoreActionElement)
end
AMPlayerWalk.init = function(l_1_0, l_1_1, l_1_2)
	CoreActionElement.init(l_1_0, l_1_1, l_1_2)
end

AMPlayerWalk.activate_now = function(l_2_0)
	local l_2_5, l_2_6, l_2_7, l_2_8, l_2_9, l_2_10, l_2_11, l_2_12, l_2_13, l_2_14 = nil
	local l_2_1 = managers.player:players()
	for i_0,i_1 in pairs(l_2_1) do
		if alive(i_1) then
			if l_2_0._mode == "limitations_on" then
				i_1:player_data().limited_to_walk = l_2_0.limited_to_walk
			end
		elseif l_2_0._mode == "limitations_off" then
			i_1:player_data().limited_to_walk = false
		end
	end
	l_2_0:deactivate_now()
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end


