require("shared/FiniteStateMachineState")
if not LocalUserSignInIdle then
	LocalUserSignInIdle = class(FiniteStateMachineState)
end
LocalUserSignInIdle.init = function(l_1_0)
	l_1_0.signin._user_callback:clear_user_canceled_sign_in()
end

LocalUserSignInIdle.transition = function(l_2_0)
	if l_2_0.signin:wants_to_show_sign_in_ui() and not l_2_0.signin:should_ignore_sign_in_ui() then
		if l_2_0.signin._user_callback:is_signed_in() then
			return LocalUserShowSignInDone
		end
	else
		return LocalUserShowSignInUiStarted
	end
end

LocalUserSignInIdle.exit = function(l_3_0)
	l_3_0.signin:clear_show_sign_in_ui()
end

if not LocalUserShowSignInDone then
	LocalUserShowSignInDone = class(FiniteStateMachineState)
end
LocalUserShowSignInDone.transition = function(l_4_0)
	return LocalUserSignInIdle
end

if not LocalUserShowSignInUiStarted then
	LocalUserShowSignInUiStarted = class(FiniteStateMachineState)
end
LocalUserShowSignInUiStarted.init = function(l_5_0)
	l_5_0.signin._request_user_to_signin = true
	local l_5_1 = l_5_0.signin._user_callback:wanted_player_slot_id()
	local l_5_2 = assert
	l_5_2(l_5_1 == 1 or l_5_1 == 2, "User does not want to play, why are we showing a sign in ui?")
	l_5_2 = l_5_0.signin
	l_5_2(l_5_2, l_5_1)
end

LocalUserShowSignInUiStarted.transition = function(l_6_0)
	if l_6_0.signin:signin_ui_active() then
		return LocalUserSignInUiActive
	end
end

if not LocalUserSignInUiActive then
	LocalUserSignInUiActive = class(FiniteStateMachineState)
end
LocalUserSignInUiActive.transition = function(l_7_0)
	if l_7_0.signin:signin_ui_active() then
		return 
	end
	if l_7_0.signin:query_is_signed_in() then
		return LocalUserSignInUiAccepted
	else
		return LocalUserSignInUiCanceled
	end
end

LocalUserSignInUiActive.exit = function(l_8_0)
	l_8_0.signin._request_user_to_signin = false
end

if not LocalUserSignInUiAccepted then
	LocalUserSignInUiAccepted = class(FiniteStateMachineState)
end
LocalUserSignInUiAccepted.transition = function(l_9_0)
	return LocalUserSignInIdle
end

if not LocalUserSignInUiCanceled then
	LocalUserSignInUiCanceled = class(FiniteStateMachineState)
end
LocalUserSignInUiCanceled.init = function(l_10_0)
	l_10_0.signin._user_callback:user_canceled_sign_in()
end

LocalUserSignInUiCanceled.transition = function(l_11_0)
	return LocalUserSignInIdle
end


