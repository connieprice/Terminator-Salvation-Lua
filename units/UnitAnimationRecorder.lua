require("setups/DebugSetup")
UnitAnimationRecorder = UnitAnimationRecorder or class()
function UnitAnimationRecorder.init(A0_0, A1_1)
	local L2_2, L3_3, L4_4, L5_5, L6_6, L7_7
	A0_0._unit = A1_1
	A0_0._file = nil
	L2_2 = {}
	A0_0._last_pos = L2_2
	A0_0._record_timer = 0
	A0_0._recording = false
	L2_2 = {}
	A0_0._recorded_data = L2_2
	A0_0._playback = false
	A0_0._playing = false
	A0_0._current_time = 0
	A0_0._last_time = 0
	A0_0._last_index = 1
	A0_0._start_time = 0
	A0_0._current_index = 1
	A0_0._playback_speed = 100
	A0_0._drawn = false
	L2_2 = A0_0.file_tag
	L2_2 = L2_2 .. L3_3
	A0_0._xml_filename = L2_2
	A0_0._last_recorded_time = 0
	A0_0._last_speed = 1
	L2_2 = {}
	A0_0._rec = L2_2
	L2_2 = A0_0._unit
	A0_0._playback_unit = L2_2
	L2_2 = {}
	A0_0._original_position = L2_2
	A0_0._is_active = false
	L2_2 = A0_0.record_objects
	A0_0._record_objects = L2_2
	L2_2 = A0_0.animation_set
	if L2_2 == nil then
		L2_2 = A0_0._unit
		L2_2 = L2_2.name
		L2_2 = L2_2(L3_3)
		A0_0.animation_set = L2_2
	end
	L2_2 = AnimationManager
	L2_2 = L2_2.animatable_set_bones
	L2_2 = L2_2(L3_3, L4_4)
	for L6_6, L7_7 in L3_3(L4_4) do
		for 