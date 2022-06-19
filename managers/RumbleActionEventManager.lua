if not RumbleActionEventManager then
	RumbleActionEventManager = class()
end
RumbleActionEventManager.init = function(l_1_0)
	managers.action_event:register_listener(l_1_0)
	l_1_0._action_events = {}
	l_1_0.load_event_effects(l_1_0)
end

RumbleActionEventManager.load_event_effects = function(l_2_0)
	local l_2_5, l_2_6, l_2_7, l_2_8, l_2_13, l_2_14, l_2_15, l_2_16, l_2_17, l_2_18 = nil
	local l_2_1 = File:new_parse_xml("data/effects/global_rumble_action_event.xml")
	for i_0 in l_2_1:children() do
		if i_0:name() == "action_event" and i_0:has_parameter("name") then
			local l_2_10 = l_2_0._action_events
			l_2_10[l_2_9:parameter("name")] = {}
			l_2_10 = l_2_0._action_events
			l_2_10 = l_2_10[l_2_9:parameter("name")]
			for i_0 in l_2_9:children() do
				if i_0:name() == "effect" and i_0:has_parameter("name") and i_0:has_parameter("rumble_preset") then
					l_2_10[i_0:parameter("name")] = i_0:parameter("rumble_preset")
				end
			end
		end
	end
end

RumbleActionEventManager.play_preset = function(l_3_0, l_3_1, l_3_2, l_3_3)
	local l_3_4 = l_3_0._action_events[l_3_1]
	if l_3_4 then
		local l_3_5 = l_3_4[l_3_2]
	if l_3_5 then
		end
		managers.rumble:play_preset(l_3_5, l_3_3)
	end
end

RumbleActionEventManager.unit_explosion = function(l_4_0, l_4_1, l_4_2)
	l_4_0.play_preset(l_4_0, "unit_explosion", l_4_1:name(), l_4_2)
end

RumbleActionEventManager.bullet_hit = function(l_5_0, l_5_1, l_5_2, l_5_3, l_5_4)
	l_5_0.play_preset(l_5_0, "bullet_hit", l_5_1, l_5_2)
end

RumbleActionEventManager.unit_weapon_fire_start = function(l_6_0, l_6_1, l_6_2)
	local l_6_3 = l_6_2:name()
	local l_6_4 = l_6_2:position()
	l_6_1.unit_name = l_6_3
	l_6_1.unit_position = l_6_4
	l_6_0.play_preset(l_6_0, "unit_weapon_fire_start", l_6_3, l_6_4)
end

RumbleActionEventManager.unit_weapon_fire_change = function(l_7_0, l_7_1, l_7_2, l_7_3, l_7_4, l_7_5)
	local l_7_6 = l_7_2:position()
	l_7_1.unit_position = l_7_6
	l_7_0.play_preset(l_7_0, "unit_weapon_fire_change", l_7_1.unit_name, l_7_3)
end

RumbleActionEventManager.unit_weapon_fire_stop = function(l_8_0, l_8_1)
	l_8_0.play_preset(l_8_0, "unit_weapon_fire_stop", l_8_1.unit_name, l_8_1.unit_position)
end


