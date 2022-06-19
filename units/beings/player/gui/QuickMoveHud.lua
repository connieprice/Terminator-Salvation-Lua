QuickMoveHud = QuickMoveHud or class()
function QuickMoveHud.init(A0_0, A1_1, A2_2, A3_3)
	A0_0._unit = A1_1
	A0_0._panel = A2_2:gui(A3_3, {})
end
function QuickMoveHud.update(A0_4, A1_5)
	if not A1_5 then
		A0_4._panel:script():hide_quick_move()
	else
		A0_4._panel:script():show_quick_move(A1_5)
	end
end
function QuickMoveHud.panel(A0_6)
	local L1_7
	L1_7 = A0_6._panel
	return L1_7
end
