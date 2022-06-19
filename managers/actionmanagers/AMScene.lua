if not AMScene then
	AMScene = class(CoreActionElement)
end
AMScene.init = function(l_1_0, l_1_1, l_1_2)
	CoreActionElement.init(l_1_0, l_1_1, l_1_2)
end

AMScene.activate_now = function(l_2_0)
	managers.drama_scene:play_conversation(l_2_0.scene_id, l_2_0.options)
	l_2_0:deactivate_now()
end


