require("shared/FiniteStateMachine")
MachineTextIdleState = MachineTextIdleState or class()
function MachineTextIdleState.transition(A0_0)
	if A0_0._machine_text:wants_to_fade_in() then
		return MachineTextFadeInState
	elseif A0_0._machine_text:wants_to_fade_out() then
		return MachineTextFadeOutState
	elseif A0_0._machine_text:wants_to_blink() then
		return MachineTextBlinkState
	end
end
MachineTextFadeInState = MachineTextFadeInState or class()
function MachineTextFadeInState.init(A0_1)
	local L1_2
	A0_1._time = 0
	A0_1._first_delay = 0.2
end
function MachineTextFadeInState.update(A0_3, A1_4)
	if A0_3._machine_text:have_text_buffer() then
		A0_3._machine_text:set_text_alpha(0, A0_3._machine_text:text_length())
		A0_3._machine_text:set_text_buffer()
		A0_3._time = 0
		A0_3._first_delay = 0.2
	end
	A0_3._time = A0_3._time + A1_4
	if A0_3._time < A0_3._first_delay then
		A0_3._machine_text:set_text_alpha(0, A0_3._machine_text:text_length())
		return
	end
	A0_3._visible_characters = math.floor((A0_3._time - A0_3._first_delay) / tweak_data.machine.hud.text.TEXT_SPEED)
	A0_3._visible_characters = math.min(A0_3._visible_characters, A0_3._machine_text:text_length())
	A0_3._machine_text:set_text_alpha(1, A0_3._visible_characters)
	if A0_3._visible_characters == A0_3._machine_text:text_length() then
		A0_3._machine_text:idle()
	end
end
function MachineTextFadeInState.transition(A0_5)
	if A0_5._machine_text:wants_to_idle() then
		return MachineTextIdleState
	end
end
MachineTextFadeOutState = MachineTextFadeOutState or class()
function MachineTextFadeOutState.init(A0_6)
	A0_6._alpha_interpolator = Interpolator:new(1, tweak_data.machine.hud.text.CHARACTER_FADE_OUT_SPEED)
	A0_6._alpha_interpolator:set_target(0)
end
function MachineTextFadeOutState.update(A0_7, A1_8)
	A0_7._alpha_interpolator:update(A1_8)
	A0_7._alpha = A0_7._alpha_interpolator:value()
	A0_7._machine_text:set_text_alpha(A0_7._alpha)
end
function MachineTextFadeOutState.transition(A0_9)
	if A0_9._machine_text:wants_to_fade_in() then
		return MachineTextFadeInState
	end
end
MachineTextBlinkState = MachineTextBlinkState or class()
function MachineTextBlinkState.init(A0_10)
	local L1_11
	L1_11 = tweak_data
	L1_11 = L1_11.machine
	L1_11 = L1_11.hud
	L1_11 = L1_11.text
	L1_11 = L1_11.BLINK_DELAY
	A0_10._first_blink = L1_11
	A0_10._blink_alpha = 0
	A0_10._time = 0
end
function MachineTextBlinkState.update(A0_12, A1_13)
	A0_12._time = A0_12._time + A1_13
	if A0_12._time < A0_12._first_blink then
		return
	end
	if not A0_12.next_blink_time then
		A0_12.next_blink_time = A0_12._time
	end
	if A0_12._time > A0_12.next_blink_time then
		A0_12._machine_text:set_text_alpha(A0_12._blink_alpha)
		if A0_12._blink_alpha == 0 then
			A0_12._blink_alpha = 1
		else
			A0_12._blink_alpha = 0
		end
		A0_12.next_blink_time = A0_12._time + tweak_data.machine.hud.text.BLINK_SPEED
	end
end
function MachineTextBlinkState.transition(A0_14)
	if A0_14._machine_text:wants_to_fade_out() then
		return MachineTextFadeOutState
	elseif A0_14._machine_text:wants_to_fade_in() then
		return MachineTextFadeInState
	end
end
