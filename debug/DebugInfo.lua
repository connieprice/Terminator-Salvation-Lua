require("debug/DebugInfoStates")
DebugInfo = DebugInfo or class()
function DebugInfo.init(A0_0)
	A0_0._panel = managers.menu:ingame_gui():full_screen_panel():panel({layer = 9999})
	A0_0._debug_infos = {
		DebugInfoStates:new(A0_0._panel)
	}
	A0_0._is_visible = false
	A0_0:hide()
end
function DebugInfo.update(A0_1, A1_2, A2_3)
	if not A0_1._is_visible then
		return
	end
	for 