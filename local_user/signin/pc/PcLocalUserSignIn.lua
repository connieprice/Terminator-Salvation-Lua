require("local_user/signin/LocalUserSignIn")
if not PcLocalUserSignIn then
	PcLocalUserSignIn = class(LocalUserSignIn)
end
PcLocalUserSignIn.init = function(l_1_0, l_1_1, l_1_2)
	LocalUserSignIn.init(l_1_0, l_1_1, l_1_2)
	l_1_0._signin_accepted = l_1_1.signin_accepted
	l_1_0._automatic_sign_in = true
end

PcLocalUserSignIn.default_data = function(l_2_0)
	LocalUserSignIn.default_data(l_2_0)
	l_2_0.signin_accepted = nil
end

PcLocalUserSignIn.save = function(l_3_0, l_3_1)
	LocalUserSignIn.save(l_3_0, l_3_1)
	l_3_1.signin_accepted = l_3_0._signin_accepted
end

PcLocalUserSignIn.show_sign_in_ui = function(l_4_0)
	cat_print("debug", "PcLocalUserSignIn:try_to_signin")
	if l_4_0._automatic_sign_in then
		l_4_0:_set_is_signed_in(true)
		l_4_0._user_callback:user_signed_in()
	end
end

PcLocalUserSignIn.sign_in = function(l_5_0)
	cat_print("debug", "sign_in")
	l_5_0._signin_accepted = true
end

PcLocalUserSignIn.sign_out = function(l_6_0)
	cat_print("debug", "sign_out")
	l_6_0._signin_accepted = false
end

PcLocalUserSignIn.signin_ui_active = function(l_7_0)
	return false
end

PcLocalUserSignIn.set_automatic_sign_in = function(l_8_0, l_8_1)
	l_8_0._automatic_sign_in = l_8_1
end

PcLocalUserSignIn.user_signed_in = function(l_9_0)
end

PcLocalUserSignIn.is_in_signed_in_state = function(l_10_0)
	return true
end


