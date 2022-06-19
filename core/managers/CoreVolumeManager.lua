CoreVolumeManager = CoreVolumeManager or class()
CoreVolumeManager.HACK_TIME = 1.0E-7
CoreVolumeManager.DEFAULT_MASTER_VOLUME = 0
function CoreVolumeManager.init(A0_0, A1_1)
	A0_0._config_file_name = A1_1
	A0_0._affected_sounds = {}
	A0_0:read_config()
	A0_0._gain_list = {}
	A0_0._pitch_list = {}
	A0_0._fade_out_gain = {}
	A0_0._fade_out_pitch = {}
	A0_0._fade_out_hf = {}
	A0_0._fade_out_lf = {}
	A0_0._paused_counter = 0
end
function CoreVolumeManager.set_paused(A0_2, A1_3)
	local L2_4, L3_5, L4_6, L5_7, L6_8, L7_9
	L2_4 = A0_2.is_paused
	L2_4 = L2_4(L3_5)
	if A1_3 then
		A0_2._paused_counter = L3_5
	else
		A0_2._paused_counter = L3_5
	end
	if L3_5 then
		if L2_4 ~= L3_5 then
			if A1_3 then
				for L6_8, L7_9 in L3_5(L4_6) do
					Sound:pause(L7_9)
				end
			else
				for L6_8, L7_9 in L3_5(L4_6) do
					Sound:unpause(L7_9)
				end
			end
		end
	end
end
function CoreVolumeManager.is_paused(A0_10)
	local L1_11
	L1_11 = A0_10._paused_counter
	L1_11 = L1_11 or 0
	L1_11 = L1_11 > 0
	return L1_11
end
function CoreVolumeManager.destroy(A0_12)
	local L1_13, L2_14, L3_15, L4_16, L5_17, L6_18, L7_19, L8_20
	for L4_16 in L1_13(L2_14) do
		L5_17 = A0_12._master_vol
		L5_17 = L5_17[L4_16]
		L6_18 = A0_12._master_pitch_map
		L6_18 = L6_18[L4_16]
		L7_19 = A0_12._master_hf_filter_map
		L7_19 = L7_19[L4_16]
		L8_20 = A0_12._master_lf_filter_map
		L8_20 = L8_20[L4_16]
		Sound:set_control_ramp(L4_16, "gain_db", L5_17, L5_17, A0_12.HACK_TIME)
		Sound:set_control_ramp(L4_16, "pitch_abs", L6_18, L6_18, A0_12.HACK_TIME)
		Sound:set_control_ramp(L4_16, "hf_filter_db", L7_19, L7_19, A0_12.HACK_TIME)
		Sound:set_control_ramp(L4_16, "lf_filter_db", L8_20, L8_20, A0_12.HACK_TIME)
		Sound:set_volume(L4_16, L5_17)
		Sound:set_control(L4_16, "pitch_abs", L6_18)
		Sound:set_control(L4_16, "hf_filter_db", L7_19)
		Sound:set_control(L4_16, "lf_filter_db", L8_20)
	end
end
function CoreVolumeManager.read_config(A0_21)
	local L1_22, L2_23, L3_24, L4_25, L5_26, L6_27, L7_28, L8_29, L9_30, L10_31, L11_32, L12_33, L13_34, L14_35, L15_36, L16_37, L17_38
	L1_22 = {}
	A0_21._master_vol = L1_22
	L1_22 = {}
	A0_21._master_pitch_map = L1_22
	L1_22 = {}
	A0_21._master_hf_filter_map = L1_22
	L1_22 = {}
	A0_21._master_lf_filter_map = L1_22
	L1_22 = {}
	A0_21._volume_set_map = L1_22
	L1_22 = {}
	A0_21._sphere_set_map = L1_22
	L1_22 = {}
	A0_21._active_nodes = L1_22
	L1_22 = {}
	A0_21._active_sphere_nodes = L1_22
	A0_21._id_count = 0
	L1_22 = {}
	A0_21._categories = L1_22
	L1_22 = File
	L1_22 = L1_22.parse_xml
	L1_22 = L1_22(L2_23, L3_24)
	if L1_22 then
		if L2_23 == "volume_manager" then
			for L5_26 in L2_23(L3_24) do
				L7_28 = L5_26
				L6_27 = L5_26.parameter
				L8_29 = "name"
				L6_27 = L6_27(L7_28, L8_29)
				if L6_27 ~= "" then
					L8_29 = L5_26
					L7_28 = L5_26.name
					L7_28 = L7_28(L8_29)
					if L7_28 == "category" then
						L8_29 = A0_21._master_vol
						L9_30 = A0_21.DEFAULT_MASTER_VOLUME
						L8_29[L6_27] = L9_30
						L8_29 = A0_21._master_pitch_map
						L8_29[L6_27] = 1
						L8_29 = A0_21._master_hf_filter_map
						L8_29[L6_27] = 0
						L8_29 = A0_21._master_lf_filter_map
						L8_29[L6_27] = 0
						L8_29 = A0_21._categories
						L8_29[L6_27] = false
					elseif L7_28 == "volume_set" then
						L9_30 = A0_21
						L8_29 = A0_21.log
						L10_31 = "Found set with name: "
						L10_31 = L10_31 .. L11_32
						L8_29(L9_30, L10_31)
						L9_30 = L5_26
						L8_29 = L5_26.parameter
						L10_31 = "name"
						L8_29 = L8_29(L9_30, L10_31)
						L9_30 = A0_21._volume_set_map
						L9_30 = L9_30[L8_29]
						if L9_30 then
							L9_30 = Application
							L10_31 = L9_30
							L9_30 = L9_30.error
							L14_35 = tostring
							L15_36 = A0_21._config_file_name
							L14_35 = L14_35(L15_36)
							L15_36 = "\". Overwriting."
							L9_30(L10_31, L11_32)
						end
						L9_30 = {}
						L10_31 = {}
						L9_30.name = L8_29
						L14_35 = tonumber
						L16_37 = L5_26
						L15_36 = L5_26.parameter
						L17_38 = "priority"
						L17_38 = L15_36(L16_37, L17_38)
						L14_35 = L14_35(L15_36, L16_37, L17_38, L15_36(L16_37, L17_38))
						L9_30.priority = L14_35
						L14_35 = tonumber
						L16_37 = L5_26
						L15_36 = L5_26.parameter
						L17_38 = "time"
						L17_38 = L15_36(L16_37, L17_38)
						L14_35 = L14_35(L15_36, L16_37, L17_38, L15_36(L16_37, L17_38))
						L9_30.time = L14_35
						L14_35 = tonumber
						L16_37 = L5_26
						L15_36 = L5_26.parameter
						L17_38 = "zero_distance"
						L17_38 = L15_36(L16_37, L17_38)
						L14_35 = L14_35(L15_36, L16_37, L17_38, L15_36(L16_37, L17_38))
						L9_30.zero_distance = L14_35
						L14_35 = L9_30.zero_distance
						if L14_35 then
							L14_35 = L9_30.zero_distance
							if L14_35 <= 0 then
								L9_30.zero_distance = nil
							end
						end
						L15_36 = A0_21
						L14_35 = A0_21.parse_volume_controls
						L16_37 = L5_26
						L17_38 = L9_30
						L14_35(L15_36, L16_37, L17_38)
						L14_35 = A0_21._volume_set_map
						L14_35[L8_29] = L9_30
					elseif L7_28 == "sphere_set" then
						L9_30 = A0_21
						L8_29 = A0_21.log
						L10_31 = "Found sphere set with name: "
						L10_31 = L10_31 .. L11_32
						L8_29(L9_30, L10_31)
						L9_30 = L5_26
						L8_29 = L5_26.parameter
						L10_31 = "name"
						L8_29 = L8_29(L9_30, L10_31)
						L9_30 = A0_21._sphere_set_map
						L9_30 = L9_30[L8_29]
						if L9_30 then
							L9_30 = Application
							L10_31 = L9_30
							L9_30 = L9_30.error
							L14_35 = tostring
							L15_36 = A0_21._config_file_name
							L14_35 = L14_35(L15_36)
							L15_36 = "\". Overwriting."
							L9_30(L10_31, L11_32)
						end
						L9_30 = {}
						L9_30.name = L8_29
						L10_31 = tonumber
						L17_38 = L11_32(L12_33, L13_34)
						L10_31 = L10_31(L11_32, L12_33, L13_34, L14_35, L15_36, L16_37, L17_38, L11_32(L12_33, L13_34))
						L9_30.priority = L10_31
						L10_31 = tonumber
						L17_38 = L11_32(L12_33, L13_34)
						L10_31 = L10_31(L11_32, L12_33, L13_34, L14_35, L15_36, L16_37, L17_38, L11_32(L12_33, L13_34))
						L9_30.time = L10_31
						L10_31 = L5_26.parameter
						L10_31 = L10_31(L11_32, L12_33)
						L10_31 = L10_31 == "true"
						L9_30.invert = L10_31
						L10_31 = tonumber
						L17_38 = L11_32(L12_33, L13_34)
						L10_31 = L10_31(L11_32, L12_33, L13_34, L14_35, L15_36, L16_37, L17_38, L11_32(L12_33, L13_34))
						L9_30.listener_inside = L10_31
						L10_31 = tonumber
						L17_38 = L11_32(L12_33, L13_34)
						L10_31 = L10_31(L11_32, L12_33, L13_34, L14_35, L15_36, L16_37, L17_38, L11_32(L12_33, L13_34))
						L9_30.listener_outside = L10_31
						L10_31 = tonumber
						L17_38 = L11_32(L12_33, L13_34)
						L10_31 = L10_31(L11_32, L12_33, L13_34, L14_35, L15_36, L16_37, L17_38, L11_32(L12_33, L13_34))
						L9_30.radius = L10_31
						L10_31 = {}
						for L14_35 in L11_32(L12_33) do
							L16_37 = L14_35
							L15_36 = L14_35.name
							L15_36 = L15_36(L16_37)
							if L15_36 == "gain_control" then
								L16_37 = L9_30.gain
								if L16_37 then
									L16_37 = Application
									L17_38 = L16_37
									L16_37 = L16_37.error
									L16_37(L17_38, "Duplicate gain found on sphere set \"" .. tostring(L8_29) .. "\" in \"" .. tostring(A0_21._config_file_name) .. "\". Overwriting.")
								end
								L16_37 = tonumber
								L17_38 = L5_26.parameter
								L17_38 = L17_38(L5_26, "gain")
								L16_37 = L16_37(L17_38, L17_38(L5_26, "gain"))
								L16_37 = L16_37 or 0
								L9_30.gain = L16_37
								L16_37 = math
								L16_37 = L16_37.max
								L17_38 = tonumber
								L17_38 = L17_38(L5_26:parameter("enter_gain"))
								L17_38 = L17_38 or 0
								L16_37 = L16_37(L17_38, A0_21.HACK_TIME)
								L9_30.enter_gain = L16_37
								L16_37 = math
								L16_37 = L16_37.max
								L17_38 = tonumber
								L17_38 = L17_38(L5_26:parameter("exit_gain"))
								L17_38 = L17_38 or 0
								L16_37 = L16_37(L17_38, A0_21.HACK_TIME)
								L9_30.exit_gain = L16_37
							elseif L15_36 == "pitch_control" then
								L16_37 = L9_30.pitch
								if L16_37 then
									L16_37 = Application
									L17_38 = L16_37
									L16_37 = L16_37.error
									L16_37(L17_38, "Duplicate pitch found on sphere set \"" .. tostring(L8_29) .. "\" in \"" .. tostring(A0_21._config_file_name) .. "\". Overwriting.")
								end
								L16_37 = tonumber
								L17_38 = L5_26.parameter
								L17_38 = L17_38(L5_26, "pitch")
								L16_37 = L16_37(L17_38, L17_38(L5_26, "pitch"))
								L16_37 = L16_37 or 0
								L9_30.pitch = L16_37
								L16_37 = math
								L16_37 = L16_37.max
								L17_38 = tonumber
								L17_38 = L17_38(L5_26:parameter("enter_pitch"))
								L17_38 = L17_38 or 0
								L16_37 = L16_37(L17_38, A0_21.HACK_TIME)
								L9_30.enter_pitch = L16_37
								L16_37 = math
								L16_37 = L16_37.max
								L17_38 = tonumber
								L17_38 = L17_38(L5_26:parameter("exit_pitch"))
								L17_38 = L17_38 or 0
								L16_37 = L16_37(L17_38, A0_21.HACK_TIME)
								L9_30.exit_pitch = L16_37
							elseif L15_36 == "ignore" then
								L17_38 = L14_35
								L16_37 = L14_35.parameter
								L16_37 = L16_37(L17_38, "cue")
								L17_38 = L14_35.parameter
								L17_38 = L17_38(L14_35, "bank")
								if L16_37 == "" or L17_38 == "" then
									Application:error("Invalid cue-attribute \"" .. tostring(L16_37) .. "\" and/or bank-attribute \"" .. tostring(L17_38) .. "\" found on set \"" .. tostring(L9_30.name) .. "\" in \"" .. tostring(A0_21._config_file_name) .. "\". Overwriting.")
								else
									table.insert(L10_31, {cue = L16_37, bank = L17_38})
								end
							end
						end
						L9_30.gain = L11_32
						L9_30.pitch = L11_32
						L9_30.ignore_cue_list = L10_31
						L11_32[L8_29] = L9_30
					end
				else
					L7_28 = Application
					L8_29 = L7_28
					L7_28 = L7_28.error
					L9_30 = "Empty name attribute in \""
					L10_31 = tostring
					L10_31 = L10_31(L11_32)
					L9_30 = L9_30 .. L10_31 .. L11_32
					L7_28(L8_29, L9_30)
				end
			end
		end
	end
end
function CoreVolumeManager.parse_volume_controls(A0_39, A1_40, A2_41)
	local L3_42, L4_43, L5_44, L6_45, L7_46, L8_47, L9_48, L10_49, L11_50, L12_51
	L3_42 = {}
	L4_43 = {}
	L5_44 = {}
	L6_45 = {}
	for L10_49 in L7_46(L8_47) do
		L12_51 = L10_49
		L11_50 = L10_49.name
		L11_50 = L11_50(L12_51)
		L12_51 = L10_49.parameter
		L12_51 = L12_51(L10_49, "category")
		if L11_50 == "gain_control" then
			if L3_42[L12_51] then
				Application:error("Duplicate gain_control category \"" .. tostring(L12_51) .. "\" found on volume set \"" .. tostring(A2_41.name) .. "\" in \"" .. tostring(A0_39._config_file_name) .. "\". Overwriting.")
			end
			L3_42[L12_51] = {
				gain = tonumber(L10_49:parameter("gain")) or 0,
				fade_in = tonumber(L10_49:parameter("fade_in")),
				fade_out = tonumber(L10_49:parameter("fade_out"))
			}
		elseif L11_50 == "pitch_control" then
			if L4_43[L12_51] then
				Application:error("Duplicate pitch_control category \"" .. tostring(L12_51) .. "\" found on volume set \"" .. tostring(A2_41.name) .. "\" in \"" .. tostring(A0_39._config_file_name) .. "\". Overwriting.")
			end
			L4_43[L12_51] = {
				pitch = tonumber(L10_49:parameter("pitch")) or 0,
				fade_in = tonumber(L10_49:parameter("fade_in")),
				fade_out = tonumber(L10_49:parameter("fade_out"))
			}
		elseif L11_50 == "hf_control" then
			if L5_44[L12_51] then
				Application:error("Duplicate hf_control category \"" .. tostring(L12_51) .. "\" found on volume set \"" .. tostring(A2_41.name) .. "\" in \"" .. tostring(A0_39._config_file_name) .. "\". Overwriting.")
			end
			L5_44[L12_51] = {
				gain = tonumber(L10_49:parameter("gain")) or 0,
				fade_in = tonumber(L10_49:parameter("fade_in")),
				fade_out = tonumber(L10_49:parameter("fade_out"))
			}
		elseif L11_50 == "lf_control" then
			if L6_45[L12_51] then
				Application:error("Duplicate lf_control category \"" .. tostring(L12_51) .. "\" found on volume set \"" .. tostring(A2_41.name) .. "\" in \"" .. tostring(A0_39._config_file_name) .. "\". Overwriting.")
			end
			L6_45[L12_51] = {
				gain = tonumber(L10_49:parameter("gain")) or 0,
				fade_in = tonumber(L10_49:parameter("fade_in")),
				fade_out = tonumber(L10_49:parameter("fade_out"))
			}
		end
	end
	A2_41.gain_map = L3_42
	A2_41.pitch_map = L4_43
	A2_41.hf_filter_map = L5_44
	A2_41.lf_filter_map = L6_45
end
function CoreVolumeManager.log(A0_52, A1_53, A2_54)
	if A2_54 then
		cat_print("debug", "[CoreVolumeManager] " .. A1_53)
	else
		cat_print("volume_manager", "[CoreVolumeManager] " .. A1_53)
	end
	if A0_52._editor then
		A0_52._editor:log(A1_53)
	end
end
function CoreVolumeManager.is_active(A0_55, A1_56)
	if type(A1_56) == "number" then
		for 