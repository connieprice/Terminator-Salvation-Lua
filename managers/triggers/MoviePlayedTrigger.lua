if not MoviePlayedTrigger then
	MoviePlayedTrigger = class(CoreTriggerBase)
end
MoviePlayedTrigger.init = function(l_1_0, l_1_1, l_1_2, l_1_3)
	CoreTriggerBase.init(l_1_0, l_1_1, l_1_2, l_1_3)
	managers.cutscene:add_callback_object(l_1_0)
end

MoviePlayedTrigger.destroy = function(l_2_0)
	managers.cutscene:remove_callback_object(l_2_0)
end

MoviePlayedTrigger.movie_played = function(l_3_0)
	l_3_0._user:trigger_activated(l_3_0._id, 1)
end


