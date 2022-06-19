require("local_user/signin/LocalUserSignIn")
PcLocalUserSignIn = PcLocalUserSignIn or class(LocalUserSignIn)
function PcLocalUserSignIn.init(A0_0, A1_1, A2_2)
	LocalUserSignIn.init(A0_0, A1_1, A2_2)
	A0_0._signin_accepted = A1_1.signin_accepted
	A0_0._automatic_sign_in = true
end
function PcLocalUserSignIn.default_data(A0_3)
	LocalUserSignIn.default_data(A0_3)
	A0_3.signin_accepted = nil
end
function PcLocalUserSignIn.save(A0_4, A1_5)
	LocalUserSignIn.save(A0_4, A1_5)
	A1_5.signin_accepted = A0_4._signin_accepted
end
function PcLocalUserSignIn.show_sign_in_ui(A0_6)
	cat_print("debug", "PcLocalUserSignIn:try_to_signin")
	if A0_6._automatic_sign_in then
		A0_6:_set_is_signed_in(true)
		A0_6._user_callback:user_signed_in()
	end
end
function PcLocalUserSignIn.sign_in(A0_7)
	cat_print("debug", "sign_in")
	A0_7._signin_accepted = true
end
function PcLocalUserSignIn.sign_out(A0_8)
	cat_print("debug", "sign_out")
	A0_8._signin_accepted = false
end
function PcLocalUserSignIn.signin_ui_active(A0_9)
	local L1_10
	L1_10 = false
	return L1_10
end
function PcLocalUserSignIn.set_automatic_sign_in(A0_11, A1_12)
	A0_11._automatic_sign_in = A1_12
end
function PcLocalUserSignIn.user_signed_in(A0_13)
	local L1_14
end
function PcLocalUserSignIn.is_in_signed_in_state(A0_15)
	local L1_16
	L1_16 = true
	return L1_16
end
