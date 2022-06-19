if not InstantFeedbackBullet then
	InstantFeedbackBullet = class(InstantBullet)
end
InstantFeedbackBullet.init = function(l_1_0, l_1_1, l_1_2, l_1_3, l_1_4, l_1_5, l_1_6, l_1_7, l_1_8, l_1_9, l_1_10, l_1_11, l_1_12, l_1_13)
	InstantBullet.init(l_1_0, l_1_1, l_1_2, l_1_3, l_1_4, l_1_5, l_1_6, l_1_7, l_1_8, l_1_9, l_1_10, l_1_11, l_1_12, l_1_13)
end

InstantFeedbackBullet.destroy = function(l_2_0)
	InstantBullet.destroy(l_2_0)
	if l_2_0._feedback_emitter then
		l_2_0._feedback_emitter:destroy()
	end
end

InstantFeedbackBullet.hit = function(l_3_0, l_3_1)
	local l_3_2 = l_3_1.unit
	if alive(l_3_2) then
		local l_3_3 = l_3_2:slot()
		l_3_0._feedback_emitter = managers.action_event:create_emitter(nil)
		l_3_0._feedback_emitter:feedback_bullet_hit(l_3_0._spawning_unit, l_3_1, l_3_3)
	end
	local l_3_4 = l_3_0._spawning_unit:base()
	local l_3_5 = l_3_4.show_bullet_hit
	if l_3_5 then
		l_3_0._disable_hit_effect = not l_3_5(l_3_4)
	end
	InstantBullet.hit(l_3_0, l_3_1)
end


