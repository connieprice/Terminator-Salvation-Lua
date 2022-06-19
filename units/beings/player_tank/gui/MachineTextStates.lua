require("shared/FiniteStateMachine")
if not MachineTextIdleState then
	MachineTextIdleState = class()
end
MachineTextIdleState.transition = function(l_1_0)
	if l_1_0._machine_text:wants_to_fade_in() then
		return MachineTextFadeInState
	else
		if l_1_0._machine_text:wants_to_fade_out() then
			return MachineTextFadeOutState
		end
	else
		if l_1_0._machine_text:wants_to_blink() then
			return MachineTextBlinkState
		end
	end
end

if not MachineTextFadeInState then
	MachineTextFadeInState = class()
end
MachineTextFadeInState.init = function(l_2_0)
	l_2_0._time = 0
	l_2_0._first_delay = 0.2
end

MachineTextFadeInState.update = function(l_3_0, l_3_1)
	if l_3_0._machine_text:have_text_buffer() then
		l_3_0._machine_text:set_text_alpha(0, l_3_0._machine_text:text_length())
		l_3_0._machine_text:set_text_buffer()
		l_3_0._time = 0
		l_3_0._first_delay = 0.2
	end
	l_3_0._time = l_3_0._time + l_3_1
	if l_3_0._time < l_3_0._first_delay then
		l_3_0._machine_text:set_text_alpha(0, l_3_0._machine_text:text_length())
		return 
	end
	l_3_0._visible_characters = math.floor((l_3_0._time - l_3_0._first_delay) / tweak_data.machine.hud.text.TEXT_SPEED)
	l_3_0._visible_characters = math.min(l_3_0._visible_characters, l_3_0._machine_text:text_length())
	l_3_0._machine_text:set_text_alpha(1, l_3_0._visible_characters)
	if l_3_0._visible_characters == l_3_0._machine_text:text_length() then
		l_3_0._machine_text:idle()
	end
end

MachineTextFadeInState.transition = function(l_4_0)
	if l_4_0._machine_text:wants_to_idle() then
		return MachineTextIdleState
	end
end

if not MachineTextFadeOutState then
	MachineTextFadeOutState = class()
end
MachineTextFadeOutState.init = function(l_5_0)
	l_5_0._alpha_interpolator = Interpolator:new(1, tweak_data.machine.hud.text.CHARACTER_FADE_OUT_SPEED)
	l_5_0._alpha_interpolator:set_target(0)
end

MachineTextFadeOutState.update = function(l_6_0, l_6_1)
	l_6_0._alpha_interpolator:update(l_6_1)
	l_6_0._alpha = l_6_0._alpha_interpolator:value()
	l_6_0._machine_text:set_text_alpha(l_6_0._alpha)
end

MachineTextFadeOutState.transition = function(l_7_0)
	if l_7_0._machine_text:wants_to_fade_in() then
		return MachineTextFadeInState
	end
end

if not MachineTextBlinkState then
	MachineTextBlinkState = class()
end
MachineTextBlinkState.init = function(l_8_0)
	l_8_0._first_blink = tweak_data.machine.hud.text.BLINK_DELAY
	l_8_0._blink_alpha = 0
	l_8_0._time = 0
end

MachineTextBlinkState.update = function(l_9_0, l_9_1)
	l_9_0._time = l_9_0._time + l_9_1
	if l_9_0._time < l_9_0._first_blink then
		return 
	end
	if not l_9_0.next_blink_time then
		l_9_0.next_blink_time = l_9_0._time
	end
	if l_9_0.next_blink_time < l_9_0._time then
		l_9_0._machine_text:set_text_alpha(l_9_0._blink_alpha)
		if l_9_0._blink_alpha == 0 then
			l_9_0._blink_alpha = 1
		else
			l_9_0._blink_alpha = 0
		end
		l_9_0.next_blink_time = l_9_0._time + tweak_data.machine.hud.text.BLINK_SPEED
	end
end

MachineTextBlinkState.transition = function(l_10_0)
	if l_10_0._machine_text:wants_to_fade_out() then
		return MachineTextFadeOutState
	else
		if l_10_0._machine_text:wants_to_fade_in() then
			return MachineTextFadeInState
		end
	end
end


