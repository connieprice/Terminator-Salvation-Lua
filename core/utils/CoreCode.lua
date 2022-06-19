local L0_0, L1_1, L2_2, L3_3, L4_4
L0_0 = core
L0_0 = L0_0.module
L0_0(L1_1, L2_2)
L0_0 = core
L0_0 = L0_0.require_module
L0_0(L1_1, L2_2)
L0_0 = core
L0_0 = L0_0.require_module
L0_0(L1_1, L2_2)
L0_0 = core
L0_0 = L0_0.require_module
L0_0(L1_1, L2_2)
function L0_0(A0_5)
	if A0_5.source == "=[C]" then
		return nil
	end
	if not File:exists(A0_5.source) then
		return A0_5.source
	end
	if not File:open(A0_5.source, "r") then
		return A0_5.source
	end
	for _FORV_5_ = 1, A0_5.linedefined - 1 do
		File:open(A0_5.source, "r"):gets()
	end
	File:open(A0_5.source, "r"):close()
	return (_FOR_(_FOR_))
end
get_prototype = L0_0
function L0_0(A0_6)
	local L1_7, L2_8
	L1_7 = A0_6.source
	if L1_7 == "=[C]" then
		L1_7 = nil
		return L1_7
	end
	L1_7 = File
	L2_8 = L1_7
	L1_7 = L1_7.exists
	L1_7 = L1_7(L2_8, A0_6.source)
	if not L1_7 then
		L1_7 = A0_6.source
		return L1_7
	end
	L1_7 = File
	L2_8 = L1_7
	L1_7 = L1_7.open
	L1_7 = L1_7(L2_8, A0_6.source, "r")
	if not L1_7 then
		L2_8 = A0_6.source
		return L2_8
	end
	L2_8 = {}
	for _FORV_6_ = 1, A0_6.linedefined - 1 do
		if L1_7:gets():match("^%s*%-%-") then
			L2_8[#L2_8 + 1] = L1_7:gets()
		else
			L2_8 = {}
		end
	end
	for _FORV_6_ = A0_6.linedefined, A0_6.lastlinedefined do
		L2_8[#L2_8 + 1] = L1_7:gets()
	end
	return _FOR_.concat(L2_8, "\n")
end
get_source = L0_0
function L0_0(A0_9)
	local L1_10
	A0_9 = A0_9 or 2
	L1_10 = 2
	while true do
		if not debug.getinfo(L1_10, "Sl") or L1_10 >= A0_9 + 2 then
			break
		end
		if debug.getinfo(L1_10, "Sl").what == "C" then
			CoreDebug.cat_print("debug", L1_10, "C function")
		else
			CoreDebug.cat_print("debug", string.format("[%s]:%d", debug.getinfo(L1_10, "Sl").source, debug.getinfo(L1_10, "Sl").currentline))
		end
		L1_10 = L1_10 + 1
	end
end
traceback = L0_0
function L0_0(A0_11)
	if A0_11 and A0_11:alive() then
		return true
	end
	return false
end
alive = L0_0
function L0_0(A0_12, A1_13)
	local L2_14
	L2_14 = {}
	for 