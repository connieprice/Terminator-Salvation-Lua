require("setups/DebugSetup")
if not UnitAnimationRecorder then
	UnitAnimationRecorder = class()
end
UnitAnimationRecorder.init = function(l_1_0, l_1_1)
	local l_1_6, l_1_7, l_1_12 = nil
	l_1_0._unit = l_1_1
	l_1_0._file = nil
	l_1_0._last_pos = {}
	l_1_0._record_timer = 0
	l_1_0._recording = false
	l_1_0._recorded_data = {}
	l_1_0._playback = false
	l_1_0._playing = false
	l_1_0._current_time = 0
	l_1_0._last_time = 0
	l_1_0._last_index = 1
	l_1_0._start_time = 0
	l_1_0._current_index = 1
	l_1_0._playback_speed = 100
	l_1_0._drawn = false
	l_1_0._xml_filename = l_1_0.file_tag .. ".xml"
	l_1_0._last_recorded_time = 0
	l_1_0._last_speed = 1
	l_1_0._rec = {}
	l_1_0._playback_unit = l_1_0._unit
	l_1_0._original_position = {}
	l_1_0._is_active = false
	l_1_0._record_objects = l_1_0.record_objects
	if l_1_0.animation_set == nil then
		l_1_0.animation_set = l_1_0._unit:name()
	end
	do
		local l_1_2 = AnimationManager:animatable_set_bones(l_1_0.animation_set)
		for i_0,i_1 in pairs(l_1_2) do
			for i_0,i_1 in pairs(l_1_0.record_objects) do
				local l_1_10 = false
				if l_1_9 == i_0 then
					l_1_10 = true
			else
				end
			end
			if not l_1_10 and l_1_0._playback_unit:get_object(l_1_9) ~= nil then
				l_1_0._record_objects[l_1_9] = {}
				 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

			end
		end
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

UnitAnimationRecorder.active = function(l_2_0, l_2_1)
	l_2_0._is_active = l_2_1
	local l_2_2 = "inactive"
	if l_2_1 then
		l_2_2 = "active"
	end
	Application:debug(l_2_0._unit:name(), "says: I am", l_2_2)
end

UnitAnimationRecorder.init_recording = function(l_3_0, l_3_1)
	l_3_0._record_timer = 0
	l_3_0._start_time = l_3_1
	l_3_0._recording = true
	l_3_0._rec = {}
	l_3_0._recorded_data = {}
	l_3_0:set_offset_data()
	l_3_0:write_frame(l_3_0._start_time)
	Application:debug("Starting record")
end

UnitAnimationRecorder.set_offset_data = function(l_4_0)
	local l_4_4, l_4_5, l_4_6, l_4_7, l_4_8, l_4_9 = nil
	for i_0,i_1 in pairs(l_4_0._record_objects) do
		l_4_0._original_position[l_4_10] = {position = l_4_0._playback_unit:get_object(l_4_10):position(), rotation = l_4_0._playback_unit:get_object(l_4_10):rotation()}
	end
end

UnitAnimationRecorder.smooth_recorded_data = function(l_5_0, l_5_1)
	local l_5_2 = 20
	Application:debug("Smoothed", l_5_1)
	for l_5_6 = 1, #l_5_0._rec do
		if l_5_2 < l_5_6 and l_5_6 < #l_5_0._rec - l_5_2 then
			local l_5_7 = {}
			local l_5_8 = {}
			for l_5_12 = -l_5_2, l_5_2 do
				table.insert(l_5_7, l_5_0._rec[l_5_6 + l_5_12][l_5_1].position - l_5_0._rec[l_5_6 - l_5_2][l_5_1].position:length())
				table.insert(l_5_8, tonumber(l_5_0._rec[l_5_6 + l_5_12].time) - tonumber(l_5_0._rec[l_5_6 - l_5_2].time))
			end
		if vector_mul(l_5_7, l_5_7) > 0 then
			end
			local l_5_13 = l_5_0._rec[l_5_6 - l_5_2].time + vector_mul(l_5_7, l_5_8) / vector_mul(l_5_7, l_5_7) * l_5_0._rec[l_5_6 - l_5_2][l_5_1].position - l_5_0._rec[l_5_6][l_5_1].position:length()
			l_5_0._rec[l_5_6].time = l_5_13
		end
	end
end

UnitAnimationRecorder.end_recording = function(l_6_0)
	Application:debug("Saving recording")
	l_6_0._recording = false
	l_6_0:write_max_format()
	l_6_0:write_editor_format()
	Application:debug("Wrote to: ", l_6_0.file_tag, ".xml, .xaf")
end

UnitAnimationRecorder.write_max_format = function(l_7_0)
	l_7_0._file = File:open(l_7_0.file_tag .. ".xaf", "w")
	if l_7_0._file ~= nil and l_7_0._rec ~= {} then
		local l_7_1 = string.format("%d", math.round(l_7_0._rec[#l_7_0._rec].time * 30 * 160))
		l_7_0._file:printf("<MaxAnimation version=\"1.00\" date=\"Fri Aug 29 09:25:08 2008\">\n")
		local l_7_5 = l_7_0._file:printf
		local l_7_6 = l_7_0._file
		l_7_5(l_7_6, "\t<SceneInfo fileName=\"%s\" startTick=\"0\" endTick=\"%s\" frameRate=\"30\" ticksPerFrame=\"160\"/>\n", l_7_0.file_tag .. ".xaf", l_7_1)
		l_7_5 = pairs
		l_7_6 = l_7_0._record_objects
		l_7_5 = l_7_5(l_7_6)
		for i_0,i_1 in l_7_5 do
			local l_7_7 = Vector3(0, 0, 0)
			if l_7_4.is_root then
				l_7_7 = l_7_0._original_position[l_7_3].position
			end
			local l_7_8 = Vector3(1, 1, 1)
			local l_7_9 = Vector3(1, 1, 1)
			if l_7_4.position_mask ~= nil then
				l_7_8 = math.string_to_vector(string.sub(l_7_4.position_mask, 2, string.len(l_7_4.position_mask) - 1))
			end
			if l_7_4.rotation_mask ~= nil then
				local l_7_16, l_7_17, l_7_18, l_7_19, l_7_29, l_7_30 = math.string_to_vector, string.sub(l_7_4.rotation_mask, 2, string.len(l_7_4.rotation_mask) - 1), .end
				l_7_16 = l_7_16(l_7_17, l_7_18, l_7_19, l_7_29, l_7_30)
				l_7_9 = l_7_16
			end
			l_7_0._last_string = ""
			local l_7_10 = ""
			local l_7_11 = 0
			local l_7_12 = 0
			for i_0,i_1 in ipairs(l_7_0._rec) do
				 -- DECOMPILER ERROR: Confused about usage of registers!

				if i_1[l_7_3].position == nil then
					i_1[l_7_3].position = Vector3(0, 0, 0)
				end
				 -- DECOMPILER ERROR: Confused about usage of registers!

				 -- DECOMPILER ERROR: Confused about usage of registers!

				if i_1[l_7_3].rotation == nil then
					i_1[l_7_3].rotation = Rotation(0, 0, 0)
				end
				 -- DECOMPILER ERROR: Confused about usage of registers!

				 -- DECOMPILER ERROR: Confused about usage of registers!

				 -- DECOMPILER ERROR: Confused about usage of registers!

				 -- DECOMPILER ERROR: Confused about usage of registers!

				 -- DECOMPILER ERROR: Confused about usage of registers!

				 -- DECOMPILER ERROR: Confused about usage of registers!

				local l_7_22 = nil
				local l_7_23 = Vector3(i_1[l_7_3].position.x * l_7_8.x, i_1[l_7_3].position.y * l_7_8.y, i_1[l_7_3].position.z * l_7_8.z) - l_7_7
				local l_7_24 = nil
				local l_7_25 = string.format("%2.4f %2.4f %2.4f", Rotation(i_1[l_7_3].rotation:yaw() * l_7_9.x, i_1[l_7_3].rotation:pitch() * l_7_9.y, i_1[l_7_3].rotation:roll() * l_7_9.z):x().x, Rotation(i_1[l_7_3].rotation:yaw() * l_7_9.x, i_1[l_7_3].rotation:pitch() * l_7_9.y, i_1[l_7_3].rotation:roll() * l_7_9.z):x().y, Rotation(i_1[l_7_3].rotation:yaw() * l_7_9.x, i_1[l_7_3].rotation:pitch() * l_7_9.y, i_1[l_7_3].rotation:roll() * l_7_9.z):x().z)
				local l_7_26 = string.format("%2.4f %2.4f %2.4f", Rotation(i_1[l_7_3].rotation:yaw() * l_7_9.x, i_1[l_7_3].rotation:pitch() * l_7_9.y, i_1[l_7_3].rotation:roll() * l_7_9.z):y().x, Rotation(i_1[l_7_3].rotation:yaw() * l_7_9.x, i_1[l_7_3].rotation:pitch() * l_7_9.y, i_1[l_7_3].rotation:roll() * l_7_9.z):y().y, Rotation(i_1[l_7_3].rotation:yaw() * l_7_9.x, i_1[l_7_3].rotation:pitch() * l_7_9.y, i_1[l_7_3].rotation:roll() * l_7_9.z):y().z)
				local l_7_27 = nil
				if string.format("%s %s %s %s", l_7_25, l_7_26, string.format("%2.4f %2.4f %2.4f", l_7_24:z().x, l_7_24:z().y, l_7_24:z().z), string.format("%2.4f %2.4f %2.4f", l_7_23.x, l_7_23.y, l_7_23.z)) ~= l_7_0._last_string then
					l_7_11 = l_7_11 + 1
				end
				l_7_0._last_string = string.format("%s %s %s %s", l_7_25, l_7_26, string.format("%2.4f %2.4f %2.4f", l_7_24:z().x, l_7_24:z().y, l_7_24:z().z), string.format("%2.4f %2.4f %2.4f", l_7_23.x, l_7_23.y, l_7_23.z))
			end
			l_7_0._file:printf("\t<Node name=\"%s\" parentNode=\"SceneRoot\" parentNodeIndex=\"0\" numChildren=\"0\">\n", l_7_3)
			local l_7_28 = l_7_11
			l_7_0._file:printf("\t\t<Samples count=\"%d\">\n", l_7_28)
			l_7_0._last_string = ""
			for l_7_28,i_1 in ipairs(l_7_0._rec) do
				 -- DECOMPILER ERROR: Confused about usage of registers!

				 -- DECOMPILER ERROR: Confused about usage of registers!

				local l_7_32 = nil
				local l_7_33 = Vector3(i_1[l_7_3].position.x * l_7_8.x, i_1[l_7_3].position.y * l_7_8.y, i_1[l_7_3].position.z * l_7_8.z) - l_7_7
				local l_7_34 = Rotation(l_7_32.rotation:yaw() * l_7_9.x, l_7_32.rotation:pitch() * l_7_9.y, l_7_32.rotation:roll() * l_7_9.z)
				local l_7_35 = string.format("%d", math.round(l_7_31.time * 30 * 160))
				local l_7_36 = string.format("%2.4f %2.4f %2.4f", l_7_34:x().x, l_7_34:x().y, l_7_34:x().z)
				local l_7_37 = string.format("%2.4f %2.4f %2.4f", l_7_34:y().x, l_7_34:y().y, l_7_34:y().z)
				local l_7_38 = string.format("%2.4f %2.4f %2.4f", l_7_34:z().x, l_7_34:z().y, l_7_34:z().z)
				local l_7_39 = nil
				if string.format("%s %s %s %s", l_7_36, l_7_37, l_7_38, string.format("%2.4f %2.4f %2.4f", l_7_33.x, l_7_33.y, l_7_33.z)) ~= l_7_0._last_string then
					l_7_0._file:printf("\t\t\t<S t=\"%s\" v=\"%s\" />\n", l_7_35, string.format("%s %s %s %s", l_7_36, l_7_37, l_7_38, string.format("%2.4f %2.4f %2.4f", l_7_33.x, l_7_33.y, l_7_33.z)))
				end
				l_7_0._last_string = string.format("%s %s %s %s", l_7_36, l_7_37, l_7_38, string.format("%2.4f %2.4f %2.4f", l_7_33.x, l_7_33.y, l_7_33.z))
			end
			l_7_0._file:printf("\t\t</Samples>\n")
			l_7_0._file:printf("\t</Node>\n")
			 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		end
		l_7_0._file:printf("</MaxAnimation>\n")
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
	l_7_1 = Application
	l_7_1(l_7_1, "Wrote_max_data")
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_7_1(l_7_1)
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

UnitAnimationRecorder.write_editor_format = function(l_8_0)
	local l_8_6, l_8_7, l_8_8, l_8_9, l_8_10, l_8_11, l_8_12, l_8_13, l_8_14, l_8_15, l_8_16, l_8_17, l_8_18, l_8_19, l_8_20, l_8_21, l_8_22, l_8_23, l_8_24, l_8_34, l_8_35 = nil
	l_8_0._file = File:open(l_8_0.file_tag .. ".xml", "w")
	local l_8_1 = nil
	if l_8_0._playback_unit == nil then
		l_8_1 = "Unknown"
	else
		l_8_1 = l_8_0._playback_unit:name()
	end
	local l_8_5 = l_8_0._file:printf
	l_8_5(l_8_0._file, "<animdata name=\"%s\">\n", l_8_1)
	l_8_5 = l_8_0._file
	if l_8_5 ~= nil then
		l_8_5 = l_8_0._rec
	if l_8_5 ~= {} then
		end
		l_8_5 = ipairs
		l_8_5 = l_8_5(l_8_0._rec)
		for i_0,i_1 in l_8_5 do
			if l_8_0.frame_skip == nil then
				l_8_0.frame_skip = 1
			end
			if l_8_4 % l_8_0.frame_skip == 0 then
				l_8_0._file:printf("\t<time value=\"%s\">\n", i_1.time)
				if i_1.unit_position ~= nil or i_1.unit_rotation ~= nil then
					l_8_0._file:printf("\t\t<unit ")
					if i_1.unit_position ~= nil then
						l_8_0._file:printf("position=\"%s\" ", math.vector_to_string(i_1.unit_position))
						i_1.unit_position = nil
					end
					if i_1.unit_rotation ~= nil then
						local l_8_29, l_8_30, l_8_31, l_8_32, l_8_33, l_8_39, l_8_40, l_8_41, l_8_42, l_8_43, l_8_44, l_8_45, l_8_46, l_8_47, l_8_48, l_8_49, l_8_50, l_8_51, l_8_52, l_8_53, l_8_54, l_8_55, l_8_56, l_8_57, l_8_58, l_8_59, l_8_60, l_8_61, l_8_62, l_8_63, l_8_64, l_8_65, l_8_66, l_8_67 = l_8_0._file:printf, l_8_0._file, "rotation=\"%s\"", math.vector_to_string(Vector3(i_1.unit_rotation:yaw(), i_1.unit_rotation:pitch(), i_1.unit_rotation:roll())), .end
						l_8_29(l_8_30, l_8_31, l_8_32, l_8_33, l_8_39, l_8_40, l_8_41, l_8_42, l_8_43, l_8_44, l_8_45, l_8_46, l_8_47, l_8_48, l_8_49, l_8_50, l_8_51, l_8_52, l_8_53, l_8_54, l_8_55, l_8_56, l_8_57, l_8_58, l_8_59, l_8_60, l_8_61, l_8_62, l_8_63, l_8_64, l_8_65, l_8_66, l_8_67)
						l_8_28.unit_rotation = nil
					end
					l_8_0._file:printf("/>\n")
				end
				 -- DECOMPILER ERROR: Confused about usage of registers!

				 -- DECOMPILER ERROR: Confused about usage of registers!

				if l_8_28.keys ~= nil then
					for i_0,i_1 in pairs(l_8_28.keys) do
						local l_8_25 = nil
						l_8_0._file:printf("\t\t<button name=\"%s\" value=\"%d\"/>\n", i_1[1], i_1[2])
					end
				end
				 -- DECOMPILER ERROR: Confused about usage of registers!

				for i_0,i_1 in pairs(l_8_25) do
					local l_8_36 = nil
					if i_0 ~= "time" and i_0 ~= "keys" then
						l_8_0._file:printf("\t\t<object name=\"%s\" ", i_0)
						if i_1.position ~= nil then
							l_8_0._file:printf("position=\"%s\" ", math.vector_to_string(i_1.position))
						end
						if i_1.rotation ~= nil then
							l_8_0._file:printf("rotation=\"%s\" ", math.vector_to_string(Vector3(i_1.rotation:yaw(), i_1.rotation:pitch(), i_1.rotation:roll())))
						end
						l_8_0._file:printf("local_pos=\"%s\" local_rot=\"%s\"", tostring(i_1.local_pos), tostring(i_1.local_rot))
						l_8_0._file:printf("/>\n")
					end
				end
				l_8_0._file:printf("\t</time>\n")
				 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

			end
		end
	end
	l_8_0._file:printf("</animdata>\n")
	l_8_0._recording = false
	l_8_0._file:close()
	l_8_0._file = nil
	l_8_0._rec = {}
	l_8_0._recorded_data = {}
	l_8_0:load_xml_data()
	Application:debug("Ended recording")
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

UnitAnimationRecorder.write_frame = function(l_9_0, l_9_1)
	local l_9_7, l_9_8, l_9_9, l_9_10, l_9_11, l_9_15, l_9_16, l_9_17, l_9_18, l_9_25, l_9_26, l_9_27, l_9_28, l_9_29, l_9_30 = nil
	if l_9_0._recording then
		l_9_0._record_timer = l_9_1 - l_9_0._start_time
		local l_9_2 = {}
		l_9_2.time = l_9_0._record_timer
		if l_9_0.record_unit_position then
			l_9_2.unit_position = l_9_0._unit:position()
		end
		if l_9_0.record_unit_rotation then
			l_9_2.unit_rotation = l_9_0._unit:rotation()
		end
		local l_9_3 = {}
		if l_9_0.special_events ~= nil then
			for i_0,i_1 in pairs(l_9_0.special_events) do
				if i_0 == "button" then
					for i_0,i_1 in pairs(i_1) do
						table.insert(l_9_3, {l_9_21, Input:controller(2):button(l_9_21)})
					end
				end
			end
		end
		for i_0,i_1 in pairs(l_9_0._record_objects) do
			if i_1.record_pos_in_local ~= false or i_1.record_pos_in_local ~= false then
				do return end
			end
			if i_1.record_rot_in_local ~= false or i_1.record_rot_in_local ~= false then
				do return end
			end
			l_9_2[l_9_31] = {local_pos = i_1.record_position == false, position = l_9_0._unit:get_object(l_9_31):local_position(), position = l_9_0._unit:get_object(l_9_31):position(), local_rot = i_1.record_rotation == false, rotation = l_9_0._unit:get_object(l_9_31):local_rotation(), rotation = l_9_0._unit:get_object(l_9_31):rotation()}
			if l_9_3 ~= {} then
				l_9_2.keys = l_9_3
			end
		end
		table.insert(l_9_0._rec, l_9_2)
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

UnitAnimationRecorder.start_playback = function(l_10_0, l_10_1)
	local l_10_5, l_10_6, l_10_7, l_10_8, l_10_9, l_10_10 = nil
	l_10_0._playback_unit:set_animations_enabled(false)
	if alive(l_10_0._playback_unit) then
		if l_10_0.disable_extensions_at_start then
			for i_0,i_1 in pairs(l_10_0.disable_extensions) do
				Application:debug("Disabling extension: ", i_0)
				l_10_0._playback_unit:set_extension_update_enabled(i_0, false)
			end
		end
		l_10_0._current_time = 0
		l_10_0._start_time = l_10_1
		l_10_0._last_time = 0
		l_10_0._last_index = 1
		l_10_0._current_index = 1
		l_10_0._playback = true
		l_10_0._playing = true
		Application:debug("Started playback")
	else
		Application:debug("Playback unit is dead")
	end
end

UnitAnimationRecorder.stop_playback = function(l_11_0)
	local l_11_4, l_11_5, l_11_6, l_11_7, l_11_8, l_11_9 = nil
	l_11_0._current_time = 0
	l_11_0._last_time = 0
	l_11_0._current_index = 1
	l_11_0._playback = false
	l_11_0._playing = false
	if not l_11_0.disable_extensions_at_end and l_11_0.disable_extensions ~= nil then
		for i_0,i_1 in pairs(l_11_0.disable_extensions) do
			Application:debug("Enabling extension: ", i_0)
			l_11_0._playback_unit:set_extension_update_enabled(i_0, true)
		end
	end
	Application:debug("Ended playback")
end

UnitAnimationRecorder.load_xml_data = function(l_12_0)
	local l_12_5, l_12_6, l_12_7, l_12_8, l_12_9, l_12_14, l_12_15, l_12_16, l_12_17, l_12_18 = nil
	Application:debug("Loading xml data", l_12_0._xml_filename)
	if File:exists(l_12_0._xml_filename) then
		l_12_0._recorded_data = {}
		local l_12_1 = File:new_parse_xml(l_12_0._xml_filename)
		for i_0 in l_12_1:children() do
			if i_0 ~= nil then
				for i_0 in l_12_10:children() do
					local l_12_11 = {time = l_12_10:parameters().value}
					do
						if not l_12_20:has_parameter("position") or (l_12_20:parameters().local_pos == "true" or l_12_20:has_parameter("rotation")) then
							if l_12_20:parameters().local_rot ~= "true" then
								l_12_11[l_12_20:parameters().name] = {position = math.string_to_vector(l_12_20:parameters().position), local_pos = i_0 == nil, rotation = math.string_to_rotation(l_12_20:parameters().rotation), local_rot = i_0:name() ~= "object"}
							end
							for i_0 in l_12_12 do
								if i_0:name() == "unit" then
									if not l_12_25:has_parameter("position") or l_12_25:has_parameter("rotation") then
										l_12_11.unit = {position = math.string_to_vector(l_12_25:parameters().position), rotation = math.string_to_rotation(l_12_25:parameters().rotation)}
								else
									end
									 -- DECOMPILER ERROR: Confused about usage of registers!

								end
								if l_12_25:name() == "button" then
									local l_12_26 = nil
									local l_12_27 = {}
									table.insert(l_12_27, {[l_12_26:parameters().name] = l_12_26:parameters().value})
								end
							end
							table.insert(l_12_0._recorded_data, l_12_11)
							 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

						end
					end
					l_12_2 = true
					return l_12_2
					 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

				else
					l_12_1 = false
					return l_12_1
				end
				 -- WARNING: missing end command somewhere! Added here
			end
			 -- WARNING: missing end command somewhere! Added here
		end
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 77 79 
end

UnitAnimationRecorder.update = function(l_13_0, l_13_1, l_13_2, l_13_3)
	local l_13_24, l_13_25, l_13_26, l_13_27, l_13_28, l_13_29, l_13_30, l_13_31, l_13_32, l_13_33, l_13_34, l_13_35, l_13_36 = nil
	if l_13_0._is_active == true then
		if Input:keyboard():down("right shift") and Input:keyboard():down("right ctrl") then
			if Input:keyboard():down("o") and l_13_0._recording == false then
				l_13_0:init_recording(l_13_2)
			end
		else
			if Input:keyboard():down("p") and l_13_0._recording == true then
				l_13_0:end_recording()
			end
		else
			 -- DECOMPILER ERROR: unhandled construct in 'if'

			 -- DECOMPILER ERROR: unhandled construct in 'if'

			if Input:keyboard():down("k") and l_13_0._recording == false and l_13_0._playback == false and l_13_0._playing == false and l_13_0._recorded_data ~= nil then
				l_13_0:start_playback(l_13_2)
				l_13_0._playing = true
			end
		end
		do return end
		if l_13_0._playback == true and l_13_0._playing == false then
			l_13_0._playing = true
		end
		do return end
		if Input:keyboard():down("l") and l_13_0._recording == false then
			l_13_0:stop_playback()
		else
			if Input:keyboard():down("m") then
				l_13_0:load_xml_data()
			end
		end
		local l_13_4, l_13_5, l_13_6, l_13_7 = nil, nil, nil, nil
		if l_13_0._recording then
			l_13_0:write_frame(l_13_2)
		end
	elseif l_13_0._playing and alive(l_13_0._playback_unit) and l_13_0._playback_unit ~= nil and l_13_0._recorded_data ~= {} then
		l_13_0._current_time = l_13_2 - l_13_0._start_time
		local l_13_8 = true
		for l_13_12 = l_13_0._current_index, #l_13_0._recorded_data do
			local l_13_16, l_13_17, l_13_19, l_13_40, l_13_41, l_13_43, l_13_45, l_13_47, l_13_49, l_13_50, l_13_51, l_13_58, l_13_59, l_13_61, l_13_62, l_13_63, l_13_64, l_13_65, l_13_67, l_13_68, l_13_70, l_13_71, l_13_72, l_13_73, l_13_75, l_13_76, l_13_78, l_13_79, l_13_80, l_13_81, l_13_83, l_13_85 = nil
			if l_13_12 > 1 then
				l_13_16 = tonumber
				l_13_17 = l_13_0._recorded_data
				l_13_19 = l_13_12 - 1
				l_13_17 = l_13_17[l_13_19]
				l_13_17 = l_13_17.time
				l_13_16 = l_13_16(l_13_17)
				l_13_17 = l_13_0._current_time
			if l_13_16 < l_13_17 then
				end
				l_13_16 = tonumber
				l_13_17 = l_13_0._recorded_data
				l_13_17 = l_13_17[l_13_12]
				l_13_17 = l_13_17.time
				l_13_16 = l_13_16(l_13_17)
				do
					local l_13_18, l_13_20, l_13_42, l_13_44, l_13_46, l_13_48, l_13_52, l_13_60, l_13_66, l_13_69, l_13_74, l_13_77, l_13_82, l_13_84, l_13_86 = nil
					l_13_17 = l_13_0._current_time
				if l_13_17 < l_13_16 then
					end
					l_13_0._current_index = l_13_12
				end
				do break end
			end
		end
		if l_13_0._current_index <= #l_13_0._recorded_data and l_13_0._current_index > 1 then
			l_13_8 = true
			if l_13_0.special_events ~= nil then
				for i_0,i_1 in pairs(l_13_0.special_events) do
					if i_0 == "button" then
						for i_0,i_1 in pairs(i_1) do
							if Input:controller(2):button(i_0) == 1 then
								rawset(_G, "record_unit", l_13_0._playback_unit)
								loadstring("local playback_unit = _G['record_unit'] if playback_unit ~= nil then " .. i_1.up .. " end")()
							else
								rawset(_G, "record_unit", l_13_0._playback_unit)
								loadstring("local playback_unit = _G['record_unit'] if playback_unit ~= nil then " .. i_1.down .. " end")()
							end
						end
					end
				end
			end
			for i_0,i_1 in pairs(l_13_0._recorded_data[l_13_0._current_index]) do
				if i_0 ~= "time" then
					if l_13_0._current_index <= 1 then
						if i_1.position ~= nil then
							l_13_6 = i_1.position
						else
							l_13_6 = nil
						end
						if i_1.rotation ~= nil then
							l_13_7 = i_1.rotation
						else
							l_13_7 = nil
						end
					else
						local l_13_55 = 0
						local l_13_56 = l_13_0._recorded_data[l_13_0._last_index][l_13_53]
						local l_13_57 = nil
						if tonumber(l_13_0._recorded_data[l_13_0._current_index][l_13_53].time) ~= tonumber(l_13_56.time) then
							l_13_55 = (l_13_0._current_time - tonumber(l_13_56.time)) / (tonumber(l_13_0._recorded_data[l_13_0._current_index][l_13_53].time) - tonumber(l_13_56.time))
						else
							l_13_55 = 1
						end
						if l_13_56.position ~= nil and l_13_57.position ~= nil then
							l_13_6 = math.lerp(l_13_56.position, l_13_57.position, l_13_55)
						else
							l_13_6 = nil
						end
						if l_13_56.rotation ~= nil and l_13_57.rotation ~= nil then
							l_13_7 = l_13_56.rotation:slerp(l_13_57.rotation, l_13_55)
						end
					else
						l_13_7 = nil
					end
					 -- DECOMPILER ERROR: Confused about usage of registers!

					if l_13_53 == "unit" then
						l_13_0._playback_unit:warp_to(l_13_7, l_13_6)
					 -- DECOMPILER ERROR: Confused about usage of registers!

					 -- DECOMPILER ERROR: Confused about usage of registers!

					 -- DECOMPILER ERROR: Confused about usage of registers!

					 -- DECOMPILER ERROR: Confused about usage of registers!

					elseif l_13_53 ~= "unit" and l_13_0._playback_unit:get_object(l_13_53) ~= nil then
						if l_13_6 ~= nil then
							if l_13_0._recorded_data[l_13_0._current_index][l_13_53].local_pos then
								l_13_0._playback_unit:get_object(l_13_53):set_local_position(l_13_6)
							 -- DECOMPILER ERROR: Confused about usage of registers!

							else
								l_13_0._playback_unit:get_object(l_13_53):set_position(l_13_6)
							end
						 -- DECOMPILER ERROR: Confused about usage of registers!

						else
							l_13_6 = l_13_0._playback_unit:get_object(l_13_53):position()
						end
						 -- DECOMPILER ERROR: Confused about usage of registers!

						 -- DECOMPILER ERROR: Confused about usage of registers!

						if l_13_7 ~= nil then
							if l_13_0._recorded_data[l_13_0._current_index][l_13_53].local_rot then
								l_13_0._playback_unit:get_object(l_13_53):new_set_local_rotation(l_13_7)
							end
						 -- DECOMPILER ERROR: Confused about usage of registers!

						else
							l_13_0._playback_unit:get_object(l_13_53):new_set_rotation(l_13_7)
						end
					 -- DECOMPILER ERROR: Confused about usage of registers!

					else
						l_13_7 = l_13_0._playback_unit:get_object(l_13_53):rotation()
					end
					 -- DECOMPILER ERROR: Confused about usage of registers!

					 -- DECOMPILER ERROR: Confused about usage of registers!

					 -- DECOMPILER ERROR: Confused about usage of registers!

					if l_13_53 ~= nil and l_13_53 ~= "unit" then
						l_13_0._last_pos[l_13_53] = Vector3(0, 0, 0)
						l_13_0._last_time = l_13_0._current_time
						l_13_0._last_index = l_13_0._current_index
					if #l_13_0._recorded_data - 1 <= l_13_0._current_index then
						end
						l_13_8 = false
					end
				end
			end
			l_13_0._playback_unit:set_moving()
		if not l_13_8 then
			end
			l_13_0:stop_playback()
		end
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 381 
end

_print_table = function(l_14_0, l_14_1)
	if l_14_1 == nil then
		l_14_1 = 1
	end
	local l_14_2 = ""
	if l_14_1 > 1 then
		for l_14_6 = 1, l_14_1 - 1 do
			local l_14_10, l_14_11, l_14_13, l_14_15, l_14_17, l_14_19 = nil
			l_14_10 = l_14_2
			local l_14_12, l_14_14, l_14_16, l_14_18, l_14_20 = nil
			l_14_11 = "\t"
			l_14_2 = l_14_10 .. l_14_11
		end
	else
		Application:debug(" ")
	end
	for i_0,i_1 in pairs(l_14_0) do
		Application:debug(l_14_2, i_0, " = ", i_1)
		if type(i_1) == "table" then
			_print_table(i_1, l_14_1 + 1)
		end
	end
end

_draw_object = function(l_15_0, l_15_1, l_15_2, l_15_3)
	local l_15_4 = Draw:brush(Color(1, 0, 0))
	l_15_4:set_persistance(0)
	l_15_4:cylinder(l_15_0, l_15_0 + l_15_1:x() * l_15_2, l_15_3)
	l_15_4:set_color(Color(0, 1, 0))
	l_15_4:cylinder(l_15_0, l_15_0 + l_15_1:y() * l_15_2, l_15_3)
	l_15_4:set_color(Color(0, 0, 1))
	l_15_4:cylinder(l_15_0, l_15_0 + l_15_1:z() * l_15_2, l_15_3)
end

vector_mul = function(l_16_0, l_16_1)
	local l_16_2 = 0
	if #l_16_0 ~= #l_16_1 then
		return nil
	else
		for l_16_6 = 1, #l_16_0 do
			l_16_2 = l_16_2 + l_16_0[l_16_6] * l_16_1[l_16_6]
		end
		return l_16_2
	end
end

print_vec = function(l_17_0, l_17_1)
	local l_17_2 = ""
	for l_17_6 = 1, #l_17_1 do
		l_17_2 = l_17_2 .. tostring(l_17_1[l_17_6])
		if l_17_6 ~= #l_17_1 then
			l_17_2 = l_17_2 .. ", "
		end
	end
	Application:debug("\t", l_17_0, ": (", l_17_2, ")")
end

obj_to_string = function(l_18_0)
	if type(l_18_0) == "vector" then
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 6 
end


