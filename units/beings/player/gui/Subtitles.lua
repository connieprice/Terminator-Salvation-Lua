require("units/beings/player/gui/SubtitlePanel")
require("units/beings/player/gui/SubtitleQueue")
Subtitles = Subtitles or class()
Subtitles.MINIMUM_WAIT_TIME = 2
function Subtitles.init(A0_0, A1_1)
	A0_0._panel = A1_1
	A0_0._queue = SubtitleQueue:new()
	A0_0._wall_timer = TimerManager:wall()
	managers.action_event:register_listener(A0_0)
end
function Subtitles.destroy(A0_2)
	managers.action_event:unregister_listener(A0_2)
	if A0_2._subtitle_panel then
		A0_2._subtitle_panel:destroy()
	end
end
function Subtitles.panel(A0_3)
	local L1_4
	L1_4 = A0_3._panel
	return L1_4
end
function Subtitles.use_small_font(A0_5)
	local L1_6
	A0_5._use_small_font = true
end
function Subtitles.use_normal_font(A0_7)
	local L1_8
	A0_7._use_small_font = false
end
function Subtitles._check_if_time_to_dismiss(A0_9, A1_10)
	local L2_11, L3_12
	L2_11 = A0_9._subtitle_panel
	if not L2_11 then
		return
	end
	L2_11 = A0_9._item1_displaying
	L3_12 = L2_11
	L2_11 = L2_11.end_time
	L2_11 = L2_11(L3_12)
	L3_12 = L2_11
	if A0_9._item2_displaying and A0_9._item2_displaying:end_time() then
		L3_12 = A0_9._item2_displaying:end_time()
	end
	if L2_11 and L3_12 and A1_10 >= math.max(L2_11, L3_12) then
		A0_9._subtitle_panel:dismiss_lines()
	end
end
function Subtitles.update(A0_13)
	local L1_14, L2_15, L3_16, L4_17
	L1_14 = A0_13._wall_timer
	L2_15 = L1_14
	L1_14 = L1_14.time
	L1_14 = L1_14(L2_15)
	L3_16 = A0_13
	L2_15 = A0_13._check_if_time_to_dismiss
	L4_17 = L1_14
	L2_15(L3_16, L4_17)
	L2_15 = A0_13._queue
	L3_16 = L2_15
	L2_15 = L2_15.has_line_to_show
	L4_17 = L1_14
	L2_15 = L2_15(L3_16, L4_17)
	if L2_15 then
		L2_15 = A0_13._subtitle_panel
		if L2_15 then
			L2_15 = A0_13._subtitle_panel
			L3_16 = L2_15
			L2_15 = L2_15.dismiss_lines
			L2_15(L3_16)
		else
			L2_15 = A0_13._queue
			L3_16 = L2_15
			L2_15 = L2_15.top_two_items
			L4_17 = L1_14
			L3_16 = L2_15(L3_16, L4_17)
			if L2_15 ~= nil then
				L4_17 = nil
				if L3_16 then
					L4_17 = L3_16._localized_text
				end
				if A0_13._show_subtitles then
					A0_13._subtitle_panel = SubtitlePanel:new(A0_13._panel, L2_15._localized_text, L4_17, A0_13._use_small_font)
				end
			end
			A0_13._item1_displaying = L2_15
			A0_13._item2_displaying = L3_16
		end
	end
	L2_15 = A0_13._subtitle_panel
	if L2_15 then
		L2_15 = A0_13._subtitle_panel
		L3_16 = L2_15
		L2_15 = L2_15.update
		L2_15(L3_16)
		L2_15 = A0_13._subtitle_panel
		L3_16 = L2_15
		L2_15 = L2_15.wants_to_destroy
		L2_15 = L2_15(L3_16)
		if L2_15 then
			L2_15 = A0_13._subtitle_panel
			L3_16 = L2_15
			L2_15 = L2_15.destroy
			L2_15(L3_16)
			A0_13._subtitle_panel = nil
		end
	end
end
function Subtitles._add_localized_line(A0_18, A1_19, A2_20)
	local L3_21, L4_22, L5_23, L6_24, L7_25, L8_26, L9_27, L10_28
	L3_21 = {}
	L4_22 = A1_19
	L6_24 = L4_22
	L5_23 = L4_22.find
	L7_25 = "%%"
	L5_23 = L5_23(L6_24, L7_25)
	L6_24 = 0
	while L5_23 do
		L8_26 = L4_22
		L7_25 = L4_22.sub
		L9_27 = 1
		L10_28 = L5_23 - 1
		L7_25 = L7_25(L8_26, L9_27, L10_28)
		L8_26 = A0_18._queue
		L9_27 = L8_26
		L8_26 = L8_26.add_text
		L10_28 = L7_25
		L8_26 = L8_26(L9_27, L10_28, L6_24, A2_20)
		L9_27 = table
		L9_27 = L9_27.insert
		L10_28 = L3_21
		L9_27(L10_28, L8_26)
		L10_28 = L4_22
		L9_27 = L4_22.find
		L9_27 = L9_27(L10_28, ";", L5_23 + 2)
		L10_28 = assert
		L10_28(L9_27, "% must end with ;")
		L10_28 = L4_22.sub
		L10_28 = L10_28(L4_22, L5_23 + 1, L9_27 - 1)
		L6_24 = tonumber(L10_28)
		assert(L6_24, "String ID" .. A2_20 .. " with text " .. A1_19 .. " is broken")
		L4_22 = L4_22:sub(L9_27 + 1)
		L5_23 = L4_22:find("%%")
	end
	if L4_22 then
		L7_25 = assert
		L8_26 = L6_24
		L9_27 = "String ID"
		L10_28 = A2_20
		L9_27 = L9_27 .. L10_28 .. " with text " .. A1_19 .. " is broken"
		L7_25(L8_26, L9_27)
		L7_25 = A0_18._queue
		L8_26 = L7_25
		L7_25 = L7_25.add_text
		L9_27 = L4_22
		L10_28 = L6_24
		L7_25 = L7_25(L8_26, L9_27, L10_28, A2_20)
		L8_26 = table
		L8_26 = L8_26.insert
		L9_27 = L3_21
		L10_28 = L7_25
		L8_26(L9_27, L10_28)
	end
	return L3_21
end
function Subtitles.say_start(A0_29, A1_30, A2_31, A3_32)
	local L4_33
	A1_30.voice_line_id = A3_32
	L4_33 = managers
	L4_33 = L4_33.localization
	L4_33 = L4_33.text
	L4_33 = L4_33(L4_33, A3_32)
	if L4_33 == "" then
		return
	end
	if L4_33:find("ERROR:", 0) ~= nil then
		cat_print("debug", "Could not find Localization string for ID: " .. A3_32)
	end
	A1_30.queue_items = A0_29:_add_localized_line(L4_33, A3_32)
end
function Subtitles.say_stop(A0_34, A1_35, A2_36)
	if A1_35.queue_items == nil then
		return
	end
	for 