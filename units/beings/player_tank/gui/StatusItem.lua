require("units/beings/player_tank/gui/MachineText")
StatusItem = StatusItem or class()
function StatusItem.init(A0_0, A1_1, A2_2, A3_3, A4_4)
	A0_0._item_text = A1_1
	A0_0._status = A2_2
	A0_0._current_status = A2_2
	A0_0._row = A3_3
	A0_0._page = A4_4
	A0_0._interpolator = Interpolator:new(A0_0._status, tweak_data.machine.hud.STATUS_DECREASE_SPEED)
end
function StatusItem.set_fluctuation(A0_5, A1_6, A2_7, A3_8)
	local L4_9
	L4_9 = {}
	L4_9.min = A1_6
	L4_9.max = A2_7
	L4_9.normal = A3_8
	A0_5._fluctuation = L4_9
end
function StatusItem.remove_fluctuation(A0_10)
	local L1_11
	A0_10._fluctuation = nil
end
function StatusItem.use_status_enums(A0_12, A1_13)
	A0_12._status_enums = A1_13
	A0_12._interpolator = nil
end
function StatusItem.get_item_string(A0_14)
	return A0_14:_pad(A0_14._item_text, 30) .. "\n"
end
function StatusItem.get_status_string(A0_15, A1_16)
	local L2_17, L3_18
	if A0_15._status_enums then
		L3_18 = A0_15._status_enums[A0_15._status]
	else
		if A0_15._current_status < 100 then
			L2_17 = string.format("%." .. 1 .. "f", A0_15._current_status)
		else
			L2_17 = A0_15._current_status
		end
		L3_18 = tostring(L2_17) .. " %"
	end
	if A1_16 then
		L3_18 = A0_15:_front_pad(L3_18, 15) .. "\n"
	else
		L3_18 = A0_15:_front_pad(L3_18, 30) .. "\n"
	end
	return L3_18
end
function StatusItem.get_row(A0_19)
	local L1_20
	L1_20 = A0_19._row
	return L1_20
end
function StatusItem.get_page(A0_21)
	local L1_22
	L1_22 = A0_21._page
	return L1_22
end
function StatusItem.set_status_target(A0_23, A1_24)
	A0_23._status = A1_24
	if A0_23._interpolator then
		A0_23._interpolator:set_target(A1_24)
	end
end
function StatusItem.add_damage(A0_25, A1_26)
	A0_25._status = A0_25._status - A1_26
	A0_25._status = math.max(A0_25._status, 0)
	if A0_25._interpolator then
		A0_25._interpolator:set_target(A0_25._status)
	end
end
function StatusItem.set_damage(A0_27, A1_28)
	A0_27._status = 100 - A1_28 * 100
	A0_27._status = math.max(A0_27._status, 0)
	A0_27._damage = A1_28
	if A0_27._interpolator then
		A0_27._interpolator:set_target(A0_27._status)
	end
end
function StatusItem.update(A0_29, A1_30)
	if A0_29._fluctuation then
		A0_29:_update_fluctuation()
	end
	if A0_29._interpolator then
		A0_29._interpolator:update(A1_30)
		if not A0_29._interpolator:has_reached_target() then
			A0_29._current_status = A0_29._interpolator:value()
		else
			A0_29._current_status = A0_29._status
		end
	else
		A0_29._current_status = A0_29._status
	end
end
function StatusItem._update_fluctuation(A0_31)
	A0_31._status = A0_31._status + math.rand(-A0_31._fluctuation.normal, A0_31._fluctuation.normal)
	A0_31._status = math.min(A0_31._status, A0_31._fluctuation.max)
	A0_31._status = math.max(A0_31._status, A0_31._fluctuation.min)
	A0_31._interpolator:set_target(A0_31._status)
end
function StatusItem._pad(A0_32, A1_33, A2_34)
	local L3_35
	L3_35 = string
	L3_35 = L3_35.rep
	L3_35 = L3_35(" ", A2_34)
	return utf8.sub(A1_33 .. L3_35, 1, A2_34)
end
function StatusItem._front_pad(A0_36, A1_37, A2_38)
	local L3_39, L4_40
	L3_39 = string
	L3_39 = L3_39.rep
	L4_40 = " "
	L3_39 = L3_39(L4_40, A2_38)
	L4_40 = A1_37.len
	L4_40 = L4_40(A1_37)
	return (utf8.sub(L3_39 .. A1_37, L4_40, A2_38 + L4_40))
end
