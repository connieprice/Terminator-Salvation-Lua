require("local_user/activity_tracker/LocalUserActivityTracker")
if not PcLocalUserActivityTracker then
	PcLocalUserActivityTracker = class(LocalUserActivityTracker)
end
PcLocalUserActivityTracker.init = function(l_1_0, l_1_1, l_1_2)
	LocalUserActivityTracker.init(l_1_0, l_1_1, l_1_2)
end

PcLocalUserActivityTracker._game_mode_changed = function(l_2_0, l_2_1)
end

PcLocalUserActivityTracker._world_changed = function(l_3_0, l_3_1)
end

PcLocalUserActivityTracker._activity_changed = function(l_4_0, l_4_1)
end


