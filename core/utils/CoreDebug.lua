core:module("CoreDebug")
core:require_module("CoreCode")
core:require_module("CoreEvent")
core:require_module("CoreClass")
function only_in_debug(A0_0)
	if not getmetatable(Application)["old_" .. A0_0] then
		getmetatable(Application)["old_" .. A0_0] = getmetatable(Application)[A0_0]
		getmetatable(Application)[A0_0] = function(...)
			local L1_2
			L1_2 = script_debug
			L1_2 = L1_2.draw_enabled
			if L1_2 then
				L1_2 = _UPVALUE0_
				L1_2 = L1_2[_UPVALUE1_]
				L1_2(...)
			end
		end
	end
end
only_in_debug("draw")
only_in_debug("draw_sphere")
only_in_debug("draw_line")
only_in_debug("draw_cone")
only_in_debug("draw_circle")
only_in_debug("draw_rotation")
only_in_debug("draw_cylinder")
only_in_debug("draw_line_unpaused")
only_in_debug("draw_sphere_unpaused")
red = {
	1,
	0,
	0
}
green = {
	0,
	1,
	0
}
blue = {
	0,
	0,
	1
}
function watch(A0_3, A1_4)
	debug.sethook(function()
		if _UPVALUE0_() then
			if _UPVALUE1_ then
				cat_print("debug", string.format("[CoreVarTrace] %s", rawget(_G, "__watch_previnfo") or "? : -1"))
			else
				cat_print("debug", "[CoreVarTrace] Probably file: " .. (debug.getinfo(2, "Sl") and debug.getinfo(2, "Sl").source or "?"))
				cat_print("debug", "[CoreVarTrace] Might be line: " .. (debug.getinfo(2, "Sl") and debug.getinfo(2, "Sl").currentline or -1))
			end
			cat_print("debug", debug.traceback())
			debug.sethook()
		end
		if _UPVALUE1_ and debug.getinfo(2, "Sl") then
			rawset(_G, "__watch_previnfo", string.format("%s : %i", debug.getinfo(2, "Sl").source or "?", debug.getinfo(2, "Sl").currentline or -1))
		end
	end, "l", 1)
end
function trace_ref(A0_5, A1_6, A2_7)
	local L3_8
	L3_8 = type
	L3_8 = L3_8(A0_5)
	if L3_8 == "string" then
		L3_8 = getmetatable
		L3_8 = L3_8(assert(rawget(_G, A0_5)))
	else
		L3_8 = L3_8 or A0_5
	end
	if not rawget(L3_8, "_" .. A1_6) then
		rawset(L3_8, "_" .. A1_6, assert(rawget(L3_8, A1_6)))
		rawset(L3_8, A1_6, function(...)
			local L1_10
			L1_10 = _UPVALUE0_
			L1_10()
			L1_10 = rawget
			L1_10 = L1_10(_UPVALUE1_, "_" .. _UPVALUE2_)
			L1_10 = L1_10(...)
			print("[CoreTraceRef] New ref:", L1_10)
			rawget(_G, "_trace_ref_table")[L1_10] = _UPVALUE3_()
			return L1_10
		end)
	end
	if not rawget(L3_8, "_" .. A2_7) then
		rawset(L3_8, "_" .. A2_7, assert(rawget(L3_8, A2_7)))
		rawset(L3_8, A2_7, function(...)
			local L1_12, L2_13
			L1_12 = _UPVALUE0_
			L1_12()
			L1_12 = {
				[2] = ...
			}
			L2_13 = ...
			;({
				[2] = ...
			})[1] = L2_13
			L2_13 = L1_12[2]
			if not L2_13 or L2_13.alive and not L2_13:alive() then
				print("[CoreTraceRef] WARNING! Deleting NULL ref: ", L2_13, _UPVALUE1_())
			else
				print("[CoreTraceRef] Delete ref:", L2_13)
			end
			rawget(_G, "_trace_ref_table")[L2_13] = nil
			return (rawget(_UPVALUE2_, "_" .. _UPVALUE3_)(...))
		end)
	end
	if not rawget(_G, "_destroy") then
		rawset(_G, "_destroy", rawget(_G, "destroy"))
		rawset(_G, "destroy", function(...)
			local L1_15, L2_16, L3_17, L4_18, L5_19, L6_20, L7_21, L8_22
			L1_15 = _UPVALUE0_
			L1_15()
			L1_15 = rawget
			L2_16 = _G
			L3_17 = "_destroy"
			L1_15 = L1_15(L2_16, L3_17)
			if L1_15 then
				L2_16 = L1_15
				L8_22 = ...
				L2_16(L3_17, L4_18, L5_19, L6_20, L7_21, L8_22, ...)
			end
			L2_16 = 0
			L3_17 = assert
			L8_22 = L4_18(L5_19, L6_20)
			L3_17 = L3_17(L4_18, L5_19, L6_20, L7_21, L8_22, L4_18(L5_19, L6_20))
			for L7_21, L8_22 in L4_18(L5_19) do
				L2_16 = L2_16 + 1
			end
			L7_21 = L2_16
			L8_22 = L5_19(L6_20, L7_21)
			L4_18(L5_19, L6_20, L7_21, L8_22, L5_19(L6_20, L7_21))
			for L7_21, L8_22 in L4_18(L5_19) do
				print("[CoreTraceRef]", L7_21, L8_22)
			end
		end)
	end
end
function trace_ref_add_destroy_all(A0_23, A1_24)
	local L2_25
	L2_25 = type
	L2_25 = L2_25(A0_23)
	if L2_25 == "string" then
		L2_25 = getmetatable
		L2_25 = L2_25(assert(rawget(_G, A0_23)))
	else
		L2_25 = L2_25 or A0_23
	end
	rawset(L2_25, "_" .. A1_24, assert(rawget(L2_25, A1_24)))
	if not rawget(L2_25, "_" .. A1_24) then
		rawset(L2_25, A1_24, function(...)
			print("[CoreTraceRef] WARNING! Called destroy all function:", _UPVALUE1_)
			return (rawget(_UPVALUE0_, "_" .. _UPVALUE1_)(...))
		end)
	end
end
function out(...)
	local L1_28, L2_29, L3_30, L4_31, L5_32, L6_33
	L1_28 = "debug"
	L2_29 = "Spam"
	L3_30 = {
		[4] = ...
	}
	L6_33 = ...
	;({
		[4] = ...
	})[1] = L4_31
	;({
		[4] = ...
	})[2] = L5_32
	;({
		[4] = ...
	})[3] = L6_33
	function L4_31(...)
		local L1_35, L2_36
		L1_35 = {
			[2] = ...
		}
		L2_36 = ...
		;({
			[2] = ...
		})[1] = L2_36
		L2_36 = {
			select(2, ...)
		}
		L2_36[1] = L1_35[1] .. " " .. tostring(L2_36[1])
		return unpack(L2_36)
	end
	function L5_32(A0_37, ...)
		local L2_39, L3_40
		L2_39 = _UPVALUE0_
		L3_40 = {
			...
		}
		for 