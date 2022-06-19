core:module("CoreMusicManager")
core:require_module("CoreMusicPlayer")
core:require_module("CoreClass")
core:require_module("CoreSong")
MusicManager = MusicManager or CoreClass.class()
MusicManager.USER_MUSIC_OVERRIDE_WAIT_FRAMES = 2
function MusicManager.init(A0_0)
	A0_0._database = Database
	A0_0._loadedsongs = {}
	A0_0._defaultplayer = CoreMusicPlayer.MusicPlayer:new(A0_0._database, A0_0._loadedsongs)
	A0_0._players = {
		[A0_0._defaultplayer] = A0_0._defaultplayer
	}
	setmetatable(A0_0._players, {__mode = "kv"})
end
function MusicManager.update(A0_1, A1_2, A2_3)
	A0_1:_apply_user_music_override(A1_2, A2_3)
	for 