AMScene = AMScene or class(CoreActionElement)
function AMScene.init(A0_0, A1_1, A2_2)
	CoreActionElement.init(A0_0, A1_1, A2_2)
end
function AMScene.activate_now(A0_3)
	managers.drama_scene:play_conversation(A0_3.scene_id, A0_3.options)
	A0_3:deactivate_now()
end
