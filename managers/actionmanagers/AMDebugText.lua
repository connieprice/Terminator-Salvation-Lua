if not AMDebugText then
	AMDebugText = class(CoreActionElement)
end
AMDebugText.init = function(l_1_0, l_1_1, l_1_2)
	CoreActionElement.init(l_1_0, l_1_1, l_1_2)
end

AMDebugText.activate_now = function(l_2_0)
	local l_2_5, l_2_6, l_2_7, l_2_8, l_2_9, l_2_10 = nil
	if not Application:debug_build() then
		return 
	end
	local l_2_1 = managers.player:human_players()
	for i_0,i_1 in pairs(l_2_1) do
		if i_1:hud() then
			i_1:hud():set_debug_text(tostring(l_2_0.debug_text))
		end
	end
	l_2_0:deactivate_now()
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end


