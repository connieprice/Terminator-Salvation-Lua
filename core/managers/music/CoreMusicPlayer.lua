local L0_0
L0_0 = core
L0_0 = L0_0.module
L0_0(L0_0, "CoreMusicPlayer")
L0_0 = core
L0_0 = L0_0.require_module
L0_0(L0_0, "CoreSong")
L0_0 = core
L0_0 = L0_0.require_module
L0_0(L0_0, "CoreModePlayHead")
L0_0 = core
L0_0 = L0_0.require_module
L0_0(L0_0, "CoreMusicTimeControl")
L0_0 = core
L0_0 = L0_0.require_module
L0_0(L0_0, "CoreClass")
L0_0 = core
L0_0 = L0_0.require_module
L0_0(L0_0, "CoreEvent")
L0_0 = core
L0_0 = L0_0.require_module
L0_0(L0_0, "CoreDebug")
L0_0 = 1
PRIORITY_GAMEPLAY_NORMAL = L0_0
L0_0 = 2
PRIORITY_LVLDESIGN_NORMAL = L0_0
L0_0 = 3
PRIORITY_GAMEPLAY_HIGH = L0_0
L0_0 = 4
PRIORITY_LVLDESIGN_HIGH = L0_0
L0_0 = 1
MusicPlayer = MusicPlayer or CoreClass.class()
function MusicPlayer.init(A0_1, A1_2, A2_3)
	A0_1._state = _UPVALUE0_
	A0_1._song = nil
	A0_1._next_song_name = nil
	A0_1._mode_change_queue = {}
	A0_1._next_song_mode = ""
	A0_1._current_playhead = nil
	A0_1._stopping_playheads = {}
	A0_1._sub_mode_playheads = {}
	A0_1._sub_mode_mixer_cbs = {}
	A0_1._database = A1_2
	A0_1._loadedsongs = A2_3
	A0_1._time_ctrl = CoreMusicTimeControl.MusicTimeControl:new()
	A0_1._stopped_cb = CoreEvent.callback(A0_1, A0_1, "_playhead_stopped_cb")
	A0_1._debugnum = _UPVALUE1_
	_UPVALUE1_ = _UPVALUE1_ + 1
end
function MusicPlayer.update(A0_4, A1_5, A2_6)
	if A0_4._state == _UPVALUE0_ and table.maxn(A0_4._mode_change_queue) > 0 and A0_4._current_playhead:get_mode() == A0_4._mode_change_queue[table.maxn(A0_4._mode_change_queue)] then
		A0_4._next_song_mode = A0_4._mode_change_queue[table.maxn(A0_4._mode_change_queue)]
		A0_4._mode_change_queue[table.maxn(A0_4._mode_change_queue)] = nil
		if table.maxn(A0_4._mode_change_queue) > 0 then
			A0_4:_request_mode_change(A0_4._mode_change_queue[table.maxn(A0_4._mode_change_queue)])
		end
	end
	if A0_4._current_playhead ~= nil then
		A0_4._current_playhead:update(A1_5, A2_6)
	end
	if A0_4._state == _UPVALUE0_ then
		A0_4:_update_sub_mode_mixing()
	end
	for 