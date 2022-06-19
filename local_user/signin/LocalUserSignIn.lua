require("shared/FiniteStateMachine")
require("local_user/signin/LocalUserSignInStates")
LocalUserSignIn = LocalUserSignIn or class()
function LocalUserSignIn.init(A0_0, A1_1, A2_2)
	local L3_3
	L3_3 = A2_2.user_index
	L3_3 = L3_3(A2_2)
	A0_0._user_index = L3_3
	A0_0._user_callback = A2_2
	A0_0._signin_triggered = false
	L3_3 = _G
	L3_3 = L3_3[A1_1.start_state]
	A0_0._state = FiniteStateMachine:new(A0_0, "signin", L3_3)
	A0_0._state:set_debug(true)
	A0_0._is_signed_in = A1_1.is_signed_in
end
function LocalUserSignIn.default_data(A0_4)
	local L1_5
	A0_4.start_state = "LocalUserSignInIdle"
end
function LocalUserSignIn.save(A0_6, A1_7)
	A1_7.start_state = A0_6._state:_debug_state_name()
	A1_7.is_signed_in = A0_6._is_signed_in
end
function LocalUserSignIn.update(A0_8, A1_9)
	A0_8._state:update(A1_9)
end
function LocalUserSignIn.wants_to_show_sign_in_ui(A0_10)
	local L1_11
	L1_11 = A0_10._wants_to_show_sign_in_ui
	return L1_11
end
function LocalUserSignIn.show_sign_in_ui(A0_12)
	cat_print("debug", "show_sign_in_ui")
	A0_12._wants_to_show_sign_in_ui = true
end
function LocalUserSignIn.clear_show_sign_in_ui(A0_13)
	cat_print("debug", "~show_sign_in_ui")
	A0_13._wants_to_show_sign_in_ui = nil
end
function LocalUserSignIn.release(A0_14)
	local L1_15
	A0_14._signin_triggered = false
end
function LocalUserSignIn.is_signed_in(A0_16)
	local L1_17
	L1_17 = A0_16._is_signed_in
	return L1_17
end
function LocalUserSignIn.has_signed_out(A0_18)
	local L1_19
	L1_19 = A0_18._has_signed_out
	return L1_19
end
function LocalUserSignIn._set_has_signed_out(A0_20)
	local L1_21
	A0_20._has_signed_out = true
end
function LocalUserSignIn._clear_has_signed_out(A0_22)
	local L1_23
	A0_22._has_signed_out = nil
end
function LocalUserSignIn._set_is_signed_in(A0_24, A1_25)
	A0_24._is_signed_in = A1_25
end
function LocalUserSignIn.query_is_signed_in(A0_26)
	local L1_27
	L1_27 = A0_26._is_signed_in
	return L1_27
end
function LocalUserSignIn.set_ignore_sign_in_ui(A0_28)
	local L1_29
	A0_28._ignore_sign_in_ui = true
end
function LocalUserSignIn.should_ignore_sign_in_ui(A0_30)
	local L1_31
	L1_31 = A0_30._ignore_sign_in_ui
	return L1_31
end
