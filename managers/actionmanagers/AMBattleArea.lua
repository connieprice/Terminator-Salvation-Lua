if not AMBattleArea then
	AMBattleArea = class(CoreActionElement)
end
AMBattleArea.init = function(l_1_0, l_1_1, l_1_2)
	CoreActionElement.init(l_1_0, l_1_1, l_1_2)
end

AMBattleArea.activate_now = function(l_2_0)
	local l_2_1, l_2_2, l_2_5, l_2_6, l_2_7, l_2_8, l_2_9, l_2_10, l_2_12, l_2_13, l_2_14, l_2_15, l_2_16, l_2_17 = nil, nil
	for i_0,i_1 in pairs(managers.player:human_players()) do
		local l_2_3 = nil
		if (i_1:name() == "john_connor" and l_2_0._mode == "john_connor_activate") or i_1:name() == "blair" and (l_2_0._mode == "blair_activate" or l_2_0._mode == "blair_deactivate") then
			l_2_1 = i_1
		end
	end
	if l_2_1 and not l_2_1:damage_data():is_fully_damaged() then
		if l_2_0._mode == "john_connor_activate" or l_2_0._mode == "blair_activate" then
			l_2_1:player_data().has_left_battle_area_timer = tweak_data.player.battle_area.MAX_TIME_OUTSIDE
		end
	elseif l_2_0._mode == "john_connor_deactivate" or l_2_0._mode == "blair_deactivate" then
		l_2_1:player_data().has_left_battle_area_timer = -1
	end
	if Application:debug_build() and (l_2_0._mode == "activate" or l_2_0._mode == "deactivate") then
		for i_0,i_1 in pairs(l_2_3) do
			if i_1:hud() then
				i_1:hud():set_debug_text(tostring("Check this battle_area!"))
			end
		end
	end
	l_2_0:deactivate_now()
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end


