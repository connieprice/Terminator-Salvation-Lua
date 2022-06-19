if not PortalManager then
	PortalManager = class(CorePortalManager)
end
PortalManager.init = function(l_1_0)
	CorePortalManager.init(l_1_0)
end

PortalManager.use_position = function(l_2_0)
	local l_2_4, l_2_5, l_2_6, l_2_7, l_2_8, l_2_9, l_2_10, l_2_11 = nil
	if script_debug._freeflight then
		local l_2_1, l_2_12 = script_debug._freeflight:in_focus()
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	if l_2_1 then
		local l_2_2 = nil
		local l_2_3 = CorePortalManager.use_position
		return l_2_3(l_2_0)
	else
		local l_2_16, l_2_17 = , ipairs
		l_2_17 = l_2_17(managers.player_slot:slots())
		for i_0,i_1 in l_2_17 do
			if i_1:user() and managers.user_viewport then
				local l_2_19 = nil
			if managers.user_viewport:viewport(i_1:user()) then
				end
				local l_2_20 = nil
				local l_2_21, l_2_22 = , managers.user_viewport:viewport(i_1:user()):engine_camera():position
				return l_2_22(managers.user_viewport:viewport(i_1:user()):engine_camera())
			end
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end


