local L0_0
L0_0 = core
L0_0 = L0_0.module
L0_0(L0_0, "CoreSongExporter")
L0_0 = core
L0_0 = L0_0.require_module
L0_0(L0_0, "CoreSong")
L0_0 = core
L0_0 = L0_0.require_module
L0_0(L0_0, "CoreKeywordArguments")
L0_0 = core
L0_0 = L0_0.require_module
L0_0(L0_0, "CoreClass")
L0_0 = core
L0_0 = L0_0.require_module
L0_0(L0_0, "CoreEvent")
L0_0 = CoreKeywordArguments
L0_0 = L0_0.parse_kwargs
parse_kwargs = L0_0
L0_0 = SongExporter
if not L0_0 then
	L0_0 = CoreClass
	L0_0 = L0_0.class
	L0_0 = L0_0()
end
SongExporter = L0_0
L0_0 = "3.0"
function SongExporter.init(A0_1, A1_2, A2_3)
	A0_1._song_project = A1_2
	A0_1._database = A2_3
	A0_1._jump_nodes = {}
	A0_1._target_nodes = {}
	A0_1._start_nodes = {}
	A0_1._target_nodes.END_SONG = TargetNode:new({
		marker_name = "END_SONG",
		sample = 0,
		clip = {name = ""},
		mode = ""
	})
end
function SongExporter.export(A0_4, A1_5)
	local L2_6, L3_7, L4_8, L5_9, L6_10, L7_11
	L3_7 = A0_4
	L2_6 = A0_4._check_sounds
	L2_6 = L2_6(L3_7)
	L3_7 = #L2_6
	if L3_7 > 0 then
		return L2_6
	end
	L4_8 = A0_4
	L3_7 = A0_4._create_target_nodes
	L3_7 = L3_7(L4_8)
	L4_8 = #L3_7
	if L4_8 > 0 then
		return L3_7
	end
	L5_9 = A0_4
	L4_8 = A0_4._create_mode_default_start_nodes
	L4_8(L5_9)
	L5_9 = A0_4
	L4_8 = A0_4._create_marker_based_start_nodes
	L4_8(L5_9)
	L5_9 = A0_4
	L4_8 = A0_4._create_jump_nodes
	L4_8 = L4_8(L5_9)
	L5_9 = #L4_8
	if L5_9 > 0 then
		return L4_8
	end
	L6_10 = A0_4
	L5_9 = A0_4._remove_unused_nodes
	L5_9 = L5_9(L6_10)
	L6_10 = #L5_9
	if L6_10 > 0 then
		return L5_9
	end
	L7_11 = A0_4
	L6_10 = A0_4._create_core_song
	L7_11 = L6_10(L7_11, A1_5)
	if #L6_10 > 0 then
		return L6_10
	end
	A0_4:_save_core_song(A1_5, L7_11)
end
function SongExporter._check_sounds(A0_12)
	local L1_13, L2_14, L3_15, L4_16, L5_17, L6_18, L7_19
	L1_13 = {}
	for L5_17 in L2_14(L3_15) do
		L6_18 = Sound
		L7_19 = L6_18
		L6_18 = L6_18.make_bank
		L6_18 = L6_18(L7_19, L5_17.soundbank, L5_17.sound)
		if L6_18 == nil then
			L7_19 = string
			L7_19 = L7_19.format
			L7_19 = L7_19("unable to create sound for '%s'/'%s', is it correctly defined in DB?", L5_17.soundbank, L5_17.sound)
			table.insert(L1_13, L7_19)
		end
	end
	return L1_13
end
function SongExporter._create_target_nodes(A0_20)
	local L1_21, L2_22, L3_23, L4_24, L5_25, L6_26, L7_27, L8_28
	L1_21 = {}
	for L5_25 in L2_22(L3_23) do
		L6_26 = A0_20._song_project
		L7_27 = L6_26
		L6_26 = L6_26.find_clip_calc_baroffset
		L8_28 = {}
		L8_28.clip_name = L5_25.clip
		L8_28.mode_name = L5_25.mode
		L7_27 = L6_26(L7_27, L8_28)
		L8_28 = table
		L8_28 = L8_28.insert
		L8_28(L1_21, L6_26)
		L8_28 = TargetNode
		L8_28 = L8_28.new
		L8_28 = L8_28(L8_28, {
			marker_name = L5_25.name,
			sample = tonumber(L5_25.sample),
			clip = L7_27,
			mode = L5_25.mode
		})
		A0_20._target_nodes[L5_25.name] = L8_28
		table.insert(L1_21, A0_20:_check_target_node_position(L8_28))
	end
	return L1_21
end
function SongExporter._check_target_node_position(A0_29, A1_30)
	local L2_31, L3_32
	L2_31 = A0_29._song_project
	L3_32 = L2_31
	L2_31 = L2_31.find_clip
	L2_31 = L2_31(L3_32, {
		name = A1_30.clip.name
	})
	L3_32 = tonumber
	L3_32 = L3_32(L2_31.stop)
	L3_32 = L3_32 - tonumber(L2_31.start)
	if L3_32 < A1_30.sample then
		return (string.format("Marker outside of Clip: Mode='%s', Clip='%s', Marker='%s' ( %d > %d )", A1_30.mode, A1_30.clip.name, A1_30.marker_name, A1_30.sample, L3_32))
	end
	return nil
end
function SongExporter._create_mode_default_start_nodes(A0_33)
	for 