if not QuickMoveHud then
	QuickMoveHud = class()
end
QuickMoveHud.init = function(l_1_0, l_1_1, l_1_2, l_1_3)
	l_1_0._unit = l_1_1
	l_1_0._panel = l_1_2:gui(l_1_3, {})
end

QuickMoveHud.update = function(l_2_0, l_2_1)
	if not l_2_1 then
		l_2_0._panel:script():hide_quick_move()
	else
		l_2_0._panel:script():show_quick_move(l_2_1)
	end
end

QuickMoveHud.panel = function(l_3_0)
	return l_3_0._panel
end


