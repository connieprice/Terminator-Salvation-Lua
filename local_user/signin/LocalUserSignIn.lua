require("shared/FiniteStateMachine")
require("local_user/signin/LocalUserSignInStates")
if not LocalUserSignIn then
	LocalUserSignIn = class()
end
LocalUserSignIn.init = function(l_1_0, l_1_1, l_1_2)
	l_1_0._user_index = l_1_2:user_index()
	l_1_0._user_callback = l_1_2
	l_1_0._signin_triggered = false
	local l_1_3 = _G[l_1_1.start_state]
	l_1_0._state = FiniteStateMachine:new(l_1_0, "signin", l_1_3)
	l_1_0._state:set_debug(true)
	l_1_0._is_signed_in = l_1_1.is_signed_in
end

LocalUserSignIn.default_data = function(l_2_0)
	l_2_0.start_state = "LocalUserSignInIdle"
end

LocalUserSignIn.save = function(l_3_0, l_3_1)
	l_3_1.start_state = l_3_0._state:_debug_state_name()
	l_3_1.is_signed_in = l_3_0._is_signed_in
end

LocalUserSignIn.update = function(l_4_0, l_4_1)
	l_4_0._state:update(l_4_1)
end

LocalUserSignIn.wants_to_show_sign_in_ui = function(l_5_0)
	return l_5_0._wants_to_show_sign_in_ui
end

LocalUserSignIn.show_sign_in_ui = function(l_6_0)
	cat_print("debug", "show_sign_in_ui")
	l_6_0._wants_to_show_sign_in_ui = true
end

LocalUserSignIn.clear_show_sign_in_ui = function(l_7_0)
	cat_print("debug", "~show_sign_in_ui")
	l_7_0._wants_to_show_sign_in_ui = nil
end

LocalUserSignIn.release = function(l_8_0)
	l_8_0._signin_triggered = false
end

LocalUserSignIn.is_signed_in = function(l_9_0)
	return l_9_0._is_signed_in
end

LocalUserSignIn.has_signed_out = function(l_10_0)
	return l_10_0._has_signed_out
end

LocalUserSignIn._set_has_signed_out = function(l_11_0)
	l_11_0._has_signed_out = true
end

LocalUserSignIn._clear_has_signed_out = function(l_12_0)
	l_12_0._has_signed_out = nil
end

LocalUserSignIn._set_is_signed_in = function(l_13_0, l_13_1)
	l_13_0._is_signed_in = l_13_1
end

LocalUserSignIn.query_is_signed_in = function(l_14_0)
	return l_14_0._is_signed_in
end

LocalUserSignIn.set_ignore_sign_in_ui = function(l_15_0)
	l_15_0._ignore_sign_in_ui = true
end

LocalUserSignIn.should_ignore_sign_in_ui = function(l_16_0)
	return l_16_0._ignore_sign_in_ui
end


