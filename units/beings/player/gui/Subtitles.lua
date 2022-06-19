require("units/beings/player/gui/SubtitlePanel")
require("units/beings/player/gui/SubtitleQueue")
if not Subtitles then
	Subtitles = class()
end
Subtitles.MINIMUM_WAIT_TIME = 2
Subtitles.init = function(l_1_0, l_1_1)
	l_1_0._panel = l_1_1
	l_1_0._queue = SubtitleQueue:new()
	l_1_0._wall_timer = TimerManager:wall()
	managers.action_event:register_listener(l_1_0)
end

Subtitles.destroy = function(l_2_0)
	managers.action_event:unregister_listener(l_2_0)
	if l_2_0._subtitle_panel then
		l_2_0._subtitle_panel:destroy()
	end
end

Subtitles.panel = function(l_3_0)
	return l_3_0._panel
end

Subtitles.use_small_font = function(l_4_0)
	l_4_0._use_small_font = true
end

Subtitles.use_normal_font = function(l_5_0)
	l_5_0._use_small_font = false
end

Subtitles._check_if_time_to_dismiss = function(l_6_0, l_6_1)
	if not l_6_0._subtitle_panel then
		return 
	end
	local l_6_2 = l_6_0._item1_displaying:end_time()
	local l_6_3 = l_6_2
	if l_6_0._item2_displaying and l_6_0._item2_displaying:end_time() then
		l_6_3 = l_6_0._item2_displaying:end_time()
	end
	if l_6_2 and l_6_3 then
		local l_6_4 = math.max(l_6_2, l_6_3)
	if l_6_4 <= l_6_1 then
		end
		l_6_0._subtitle_panel:dismiss_lines()
	end
end

Subtitles.update = function(l_7_0)
	local l_7_1 = l_7_0._wall_timer:time()
	l_7_0:_check_if_time_to_dismiss(l_7_1)
	if l_7_0._queue:has_line_to_show(l_7_1) then
		if l_7_0._subtitle_panel then
			l_7_0._subtitle_panel:dismiss_lines()
		end
	else
		local l_7_2, l_7_3 = l_7_0._queue:top_two_items(l_7_1)
		if l_7_2 ~= nil then
			local l_7_4 = nil
			if l_7_3 then
				l_7_4 = l_7_3._localized_text
			end
		if l_7_0._show_subtitles then
			end
			l_7_0._subtitle_panel = SubtitlePanel:new(l_7_0._panel, l_7_2._localized_text, l_7_4, l_7_0._use_small_font)
		end
		l_7_0._item1_displaying = l_7_2
		l_7_0._item2_displaying = l_7_3
	end
	if l_7_0._subtitle_panel then
		l_7_0._subtitle_panel:update()
	if l_7_0._subtitle_panel:wants_to_destroy() then
		end
		l_7_0._subtitle_panel:destroy()
		l_7_0._subtitle_panel = nil
	end
end

Subtitles._add_localized_line = function(l_8_0, l_8_1, l_8_2)
	local l_8_3 = {}
	local l_8_4 = l_8_1
	local l_8_5 = l_8_4:find("%%")
	do
		while 1 do
			local l_8_6 = 0
			while l_8_5 do
				local l_8_7 = l_8_4:sub(1, l_8_5 - 1)
				local l_8_8 = l_8_0._queue:add_text(l_8_7, l_8_6, l_8_2)
				table.insert(l_8_3, l_8_8)
				local l_8_9 = l_8_4:find(";", l_8_5 + 2)
				assert(l_8_9, "% must end with ;")
				local l_8_10 = l_8_4:sub(l_8_5 + 1, l_8_9 - 1)
				l_8_6 = tonumber(l_8_10)
				assert(l_8_6, "String ID" .. l_8_2 .. " with text " .. l_8_1 .. " is broken")
				l_8_4 = l_8_4:sub(l_8_9 + 1)
				l_8_5 = l_8_4:find("%%")
			end
			if l_8_4 then
				assert(l_8_6, "String ID" .. l_8_2 .. " with text " .. l_8_1 .. " is broken")
				local l_8_11 = l_8_0._queue:add_text(l_8_4, l_8_6, l_8_2)
				table.insert(l_8_3, l_8_11)
			end
			return l_8_3
		end
		 -- WARNING: missing end command somewhere! Added here
	end
end

Subtitles.say_start = function(l_9_0, l_9_1, l_9_2, l_9_3)
	l_9_1.voice_line_id = l_9_3
	local l_9_4 = managers.localization:text(l_9_3)
	if l_9_4 == "" then
		return 
	end
	if l_9_4:find("ERROR:", 0) ~= nil then
		cat_print("debug", "Could not find Localization string for ID: " .. l_9_3)
	end
	l_9_1.queue_items = l_9_0:_add_localized_line(l_9_4, l_9_3)
end

Subtitles.say_stop = function(l_10_0, l_10_1, l_10_2)
	local l_10_6, l_10_7, l_10_8, l_10_9 = nil
	if l_10_1.queue_items == nil then
		return 
	end
	for i_0,i_1 in pairs(l_10_1.queue_items) do
		i_1:mark_as_done()
	end
end

Subtitles.enable_subtitles = function(l_11_0, l_11_1)
	l_11_0._show_subtitles = l_11_1
	if not l_11_1 and l_11_0._subtitle_panel then
		l_11_0._subtitle_panel:dismiss_lines()
	end
end


