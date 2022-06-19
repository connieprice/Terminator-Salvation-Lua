MoviePlayedTrigger = MoviePlayedTrigger or class(CoreTriggerBase)
function MoviePlayedTrigger.init(A0_0, A1_1, A2_2, A3_3)
	CoreTriggerBase.init(A0_0, A1_1, A2_2, A3_3)
	managers.cutscene:add_callback_object(A0_0)
end
function MoviePlayedTrigger.destroy(A0_4)
	managers.cutscene:remove_callback_object(A0_4)
end
function MoviePlayedTrigger.movie_played(A0_5)
	A0_5._user:trigger_activated(A0_5._id, 1)
end
