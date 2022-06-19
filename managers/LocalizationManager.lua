core:require_module("CoreLocalizationManager")
if not LocalizationManager then
	LocalizationManager = {}
end
LocalizationManager.add_default_macros = function()
	local l_1_0 = utf8.char(57344)
	local l_1_1 = utf8.char(57345)
	local l_1_2 = utf8.char(57346)
	local l_1_3 = utf8.char(57347)
	local l_1_4 = utf8.char(57348)
	local l_1_5 = utf8.char(57349)
	local l_1_6 = utf8.char(57350)
	local l_1_7 = utf8.char(57351)
	local l_1_8 = utf8.char(57352)
	local l_1_9 = utf8.char(57353)
	local l_1_10 = utf8.char(57354)
	local l_1_11 = utf8.char(57355)
	local l_1_12 = utf8.char(57356)
	local l_1_13 = utf8.char(57357)
	if SystemInfo:platform() == "WIN32" then
		local l_1_14 = "[YOUR BUTTON HERE]"
		l_1_0 = l_1_14
		l_1_1 = l_1_14
		l_1_2 = l_1_14
		l_1_3 = l_1_14
		l_1_4 = l_1_14
		l_1_5 = l_1_14
		l_1_6 = l_1_14
		l_1_7 = l_1_14
		l_1_8 = l_1_14
		l_1_9 = l_1_14
		l_1_10 = l_1_14
		l_1_11 = l_1_14
		l_1_12 = l_1_14
		l_1_13 = l_1_14
	end
	local l_1_15 = l_1_0
	local l_1_16 = l_1_1
	local l_1_17 = false
	if SystemInfo:platform() == "PS3" and PS3:pad_cross_circle_inverted() then
		l_1_17 = true
	end
	if l_1_17 then
		l_1_15 = l_1_1
		l_1_16 = l_1_0
	end
	if SystemInfo:platform() ~= "PS3" then
		l_1_13 = l_1_7
		l_1_12 = l_1_6
		managers.localization.btn_zoom = l_1_13
		managers.localization.btn_center_camera = l_1_12
	end
	local l_1_18 = {}
	local l_1_19 = {}
	 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

	local l_1_20 = {}
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

	local l_1_21 = {}
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

	local l_1_22 = {}
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

	local l_1_23 = {}
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

	local l_1_24 = {}
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

	local l_1_25 = {}
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

	local l_1_26 = {}
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

	local l_1_27 = {}
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

	local l_1_28 = {}
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

	local l_1_29 = {}
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

	local l_1_30 = {}
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

	local l_1_31 = {}
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

	local l_1_32 = {}
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

	local l_1_33 = {}
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

	do
		local l_1_34 = {}
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

		 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

		 -- DECOMPILER ERROR: Overwrote pending register.

		for l_1_22,l_1_23 in l_1_19 do
			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			l_1_24(l_1_25, l_1_26, l_1_27)
		end
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	 -- WARNING: undefined locals caused missing assignments!
end


