require("menu/2D/Menu2DPage")
if not Menu2DPageControllerLost then
	Menu2DPageControllerLost = class(Menu2DPageMessage)
end
Menu2DPageControllerLost.open = function(l_1_0, l_1_1, l_1_2, l_1_3)
	local l_1_4 = (managers.menu:disconnected_controller_index())
	local l_1_5, l_1_6 = nil, nil
	if not l_1_4 then
		l_1_5 = ""
	else
		l_1_4 = l_1_4 + 1
		local l_1_7 = {}
		l_1_7.NR = l_1_4
		l_1_6 = l_1_7
	end
	Menu2DPageMessage.open(l_1_0, l_1_1, l_1_2, l_1_3, l_1_6, l_1_5)
end

Menu2DPageControllerLost.confirm_mode = function(l_2_0)
	local l_2_1 = nil
	 -- DECOMPILER ERROR: Confused about usage of registers!

	return l_2_1
end


