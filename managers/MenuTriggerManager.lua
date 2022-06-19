MenuTriggerManager = MenuTriggerManager or class()
function MenuTriggerManager.init(A0_0)
	A0_0._menu_triggers = {}
end
function MenuTriggerManager.add_menu_trigger(A0_1, A1_2)
	A0_1._menu_triggers[A1_2._mode] = A1_2
end
function MenuTriggerManager.remove_menu_trigger(A0_3, A1_4)
	A0_3._menu_triggers[A1_4._mode] = nil
end
function MenuTriggerManager.menu_changed(A0_5, A1_6, A2_7)
	local L3_8
	L3_8 = tostring
	L3_8 = L3_8(A1_6)
	L3_8 = L3_8 .. "_to_" .. tostring(A2_7)
	if not A0_5._menu_triggers[L3_8] then
		return
	end
	A0_5._menu_triggers[L3_8]:menu_changed(L3_8)
end
