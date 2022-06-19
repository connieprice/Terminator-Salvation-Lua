require("units/beings/machines/spider/states/SpiderState")
require("units/beings/machines/spider/states/SpiderNormalState")
if not SpiderScanState then
	SpiderScanState = class(SpiderState)
end
SpiderScanState.init = function(l_1_0, l_1_1)
	SpiderState.init(l_1_0, l_1_1)
	l_1_0._enemy_data = l_1_0._unit:enemy_data()
	l_1_0._input = l_1_0._unit:input()
end

SpiderScanState.enter = function(l_2_0)
	l_2_0._emitter:unit_scan_enter(l_2_0._unit)
	l_2_0:_set_can_move(false)
	l_2_0:_set_can_rotate(false)
	l_2_0._scanning_loop = false
	l_2_0._left_scan = false
end

SpiderScanState.leave = function(l_3_0)
	if l_3_0._scanning_loop then
		l_3_0._emitter:unit_scan_beam_leave(l_3_0._unit)
	end
	if not l_3_0._left_scan then
		l_3_0._emitter:unit_scan_leave(l_3_0._unit)
	end
	SpiderState.leave(l_3_0)
	l_3_0._enemy_data.num_scans = l_3_0._enemy_data.num_scans + 1
end

SpiderScanState.update = function(l_4_0, l_4_1)
	local l_4_9, l_4_10, l_4_15, l_4_16 = nil
	local l_4_2 = l_4_0._base:check_fully_damaged()
	if l_4_2 then
		return l_4_2
	end
	local l_4_3 = l_4_0._unit
	local l_4_4 = l_4_0._enemy_data
	if l_4_4.is_stunned then
		local l_4_5, l_4_6 = SpiderStunState:new, SpiderStunState
		local l_4_7 = l_4_3
		local l_4_8, l_4_14 = "normal"
		return l_4_5(l_4_6, l_4_7, l_4_8)
	elseif not l_4_4.scanning then
		local l_4_11, l_4_12 = SpiderNormalState:new, SpiderNormalState
		local l_4_13 = l_4_3
		return l_4_11(l_4_12, l_4_13)
	end
	local l_4_17 = l_4_0._input
	if l_4_4.stun_requested then
		l_4_0:_request_stun()
	else
		 -- DECOMPILER ERROR: unhandled construct in 'if'

		if not l_4_17:attack_mode() and not l_4_17:track() and not l_4_17:fire() and l_4_17:movement():length() <= 0 then
			local l_4_21 = l_4_17:is_scanning()
			 -- DECOMPILER ERROR: Overwrote pending register.

			if l_4_21 then
				do return end
			end
			 -- DECOMPILER ERROR: Overwrote pending register.

			l_4_3:play_redirect(nil)
		end
		do
			local l_4_22 = l_4_4.scanning_loop
			if l_4_22 and not l_4_0._scanning_loop then
				l_4_0._emitter:unit_scan_beam_enter(l_4_0._unit)
			end
			do return end
			if l_4_0._scanning_loop then
				l_4_0._emitter:unit_scan_beam_leave(l_4_0._unit)
				l_4_0._emitter:unit_scan_leave(l_4_0._unit)
				l_4_0._left_scan = true
			end
			l_4_0._scanning_loop = l_4_22
		end
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 57 
end


