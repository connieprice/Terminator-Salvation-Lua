require("local_user/activity_tracker/LocalUserActivityTracker")
PcLocalUserActivityTracker = PcLocalUserActivityTracker or class(LocalUserActivityTracker)
function PcLocalUserActivityTracker.init(A0_0, A1_1, A2_2)
	LocalUserActivityTracker.init(A0_0, A1_1, A2_2)
end
function PcLocalUserActivityTracker._game_mode_changed(A0_3, A1_4)
end
function PcLocalUserActivityTracker._world_changed(A0_5, A1_6)
end
function PcLocalUserActivityTracker._activity_changed(A0_7, A1_8)
end
