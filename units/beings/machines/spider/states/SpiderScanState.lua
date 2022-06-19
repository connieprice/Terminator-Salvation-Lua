require("units/beings/machines/spider/states/SpiderState")
require("units/beings/machines/spider/states/SpiderNormalState")
SpiderScanState = SpiderScanState or class(SpiderState)
function SpiderScanState.init(A0_0, A1_1)
	SpiderState.init(A0_0, A1_1)
	A0_0._enemy_data = A0_0._unit:enemy_data()
	A0_0._input = A0_0._unit:input()
end
function SpiderScanState.enter(A0_2)
	A0_2._emitter:unit_scan_enter(A0_2._unit)
	A0_2:_set_can_move(false)
	A0_2:_set_can_rotate(false)
	A0_2._scanning_loop = false
	A0_2._left_scan = false
end
function SpiderScanState.leave(A0_3)
	if A0_3._scanning_loop then
		A0_3._emitter:unit_scan_beam_leave(A0_3._unit)
	end
	if not A0_3._left_scan then
		A0_3._emitter:unit_scan_leave(A0_3._unit)
	end
	SpiderState.leave(A0_3)
	A0_3._enemy_data.num_scans = A0_3._enemy_data.num_scans + 1
end
function SpiderScanState.update(A0_4, A1_5)
	local L2_6, L3_7, L4_8, L5_9, L6_10, L7_11
	L2_6 = A0_4._base
	L3_7 = L2_6
	L2_6 = L2_6.check_fully_damaged
	L2_6 = L2_6(L3_7)
	if L2_6 then
		return L2_6
	end
	L3_7 = A0_4._unit
	L4_8 = A0_4._enemy_data
	L5_9 = L4_8.is_stunned
	if L5_9 then
		L5_9 = SpiderStunState
		L6_10 = L5_9
		L5_9 = L5_9.new
		L7_11 = L3_7
		return L5_9(L6_10, L7_11, "normal")
	else
		L5_9 = L4_8.scanning
		if not L5_9 then
			L5_9 = SpiderNormalState
			L6_10 = L5_9
			L5_9 = L5_9.new
			L7_11 = L3_7
			return L5_9(L6_10, L7_11)
		end
	end
	L5_9 = A0_4._input
	L6_10 = L4_8.stun_requested
	if L6_10 then
		L7_11 = A0_4
		L6_10 = A0_4._request_stun
		L6_10(L7_11)
	else
		L7_11 = L5_9
		L6_10 = L5_9.is_scanning
		L6_10 = L6_10(L7_11)
		if not L6_10 then
			L7_11 = L5_9
			L6_10 = L5_9.attack_mode
			L6_10 = L6_10(L7_11)
			if not L6_10 then
				L7_11 = L5_9
				L6_10 = L5_9.track
				L6_10 = L6_10(L7_11)
				if not L6_10 then
					L7_11 = L5_9
					L6_10 = L5_9.fire
					L6_10 = L6_10(L7_11)
					if not L6_10 then
						L7_11 = L5_9
						L6_10 = L5_9.movement
						L6_10 = L6_10(L7_11)
						L7_11 = L6_10
						L6_10 = L6_10.length
						L6_10 = L6_10(L7_11)
						L6_10 = L6_10 > 0
					end
				end
			end
			L7_11 = nil
			if L6_10 then
				L7_11 = "abort_scan"
			else
				L7_11 = "end_scan"
			end
			L3_7:play_redirect(L7_11)
		end
	end
	L6_10 = L4_8.scanning_loop
	if L6_10 then
		L7_11 = A0_4._scanning_loop
		if not L7_11 then
			L7_11 = A0_4._emitter
			L7_11 = L7_11.unit_scan_beam_enter
			L7_11(L7_11, A0_4._unit)
		end
	else
		L7_11 = A0_4._scanning_loop
		if L7_11 then
			L7_11 = A0_4._emitter
			L7_11 = L7_11.unit_scan_beam_leave
			L7_11(L7_11, A0_4._unit)
			L7_11 = A0_4._emitter
			L7_11 = L7_11.unit_scan_leave
			L7_11(L7_11, A0_4._unit)
			A0_4._left_scan = true
		end
	end
	A0_4._scanning_loop = L6_10
end
