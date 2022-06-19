core:module("CoreMusicTimeControl")
core:require_module("CoreClass")
MAX_STREAMING = 3
MusicTimeControl = MusicTimeControl or CoreClass.class()
function MusicTimeControl.init(A0_0)
	A0_0._wall_clock = TimerManager:wall()
	A0_0._last = A0_0._wall_clock:time()
	A0_0._pitch = 1
	A0_0._offset = 0
	A0_0._soundobjects = {}
	setmetatable(A0_0._soundobjects, {__mode = "kv"})
end
function MusicTimeControl.time(A0_1)
	A0_1._last, A0_1._offset = A0_1._wall_clock:time(), A0_1._offset + (A0_1._wall_clock:time() - A0_1._last) * (1 - A0_1._pitch)
	return A0_1._pause_time or A0_1._wall_clock:time() - A0_1._offset
end
function MusicTimeControl.set_pitch(A0_2, A1_3)
	A0_2:time()
	A0_2._pitch = math.max(math.min(A1_3, 2), 0)
	if A0_2._pause_time == nil then
		for 