require("shared/FiniteStateMachineState")
LocalUserSignInIdle = LocalUserSignInIdle or class(FiniteStateMachineState)
function LocalUserSignInIdle.init(A0_0)
	A0_0.signin._user_callback:clear_user_canceled_sign_in()
end
function LocalUserSignInIdle.transition(A0_1)
	if A0_1.signin:wants_to_show_sign_in_ui() and not A0_1.signin:should_ignore_sign_in_ui() then
		if A0_1.signin._user_callback:is_signed_in() then
			return LocalUserShowSignInDone
		else
			return LocalUserShowSignInUiStarted
		end
	end
end
function LocalUserSignInIdle.exit(A0_2)
	A0_2.signin:clear_show_sign_in_ui()
end
LocalUserShowSignInDone = LocalUserShowSignInDone or class(FiniteStateMachineState)
function LocalUserShowSignInDone.transition(A0_3)
	local L1_4
	L1_4 = LocalUserSignInIdle
	return L1_4
end
LocalUserShowSignInUiStarted = LocalUserShowSignInUiStarted or class(FiniteStateMachineState)
function LocalUserShowSignInUiStarted.init(A0_5)
	local L1_6
	L1_6 = A0_5.signin
	L1_6._request_user_to_signin = true
	L1_6 = A0_5.signin
	L1_6 = L1_6._user_callback
	L1_6 = L1_6.wanted_player_slot_id
	L1_6 = L1_6(L1_6)
	assert(L1_6 == 1 or L1_6 == 2, "User does not want to play, why are we showing a sign in ui?")
	A0_5.signin:show_signin_ui(L1_6)
end
function LocalUserShowSignInUiStarted.transition(A0_7)
	if A0_7.signin:signin_ui_active() then
		return LocalUserSignInUiActive
	end
end
LocalUserSignInUiActive = LocalUserSignInUiActive or class(FiniteStateMachineState)
function LocalUserSignInUiActive.transition(A0_8)
	if A0_8.signin:signin_ui_active() then
		return
	end
	if A0_8.signin:query_is_signed_in() then
		return LocalUserSignInUiAccepted
	else
		return LocalUserSignInUiCanceled
	end
end
function LocalUserSignInUiActive.exit(A0_9)
	A0_9.signin._request_user_to_signin = false
end
LocalUserSignInUiAccepted = LocalUserSignInUiAccepted or class(FiniteStateMachineState)
function LocalUserSignInUiAccepted.transition(A0_10)
	local L1_11
	L1_11 = LocalUserSignInIdle
	return L1_11
end
LocalUserSignInUiCanceled = LocalUserSignInUiCanceled or class(FiniteStateMachineState)
function LocalUserSignInUiCanceled.init(A0_12)
	A0_12.signin._user_callback:user_canceled_sign_in()
end
function LocalUserSignInUiCanceled.transition(A0_13)
	local L1_14
	L1_14 = LocalUserSignInIdle
	return L1_14
end
