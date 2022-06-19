if SystemInfo:platform() == "X360" then
	require("local_user/signin/xbox360/Xbox360LocalUserSignIn")
	PortableLocalUserSignIn = Xbox360LocalUserSignIn
elseif SystemInfo:platform() == "WIN32" then
	require("local_user/signin/pc/PcLocalUserSignIn")
	PortableLocalUserSignIn = PcLocalUserSignIn
elseif SystemInfo:platform() == "PS3" then
	require("local_user/signin/ps3/Ps3LocalUserSignIn")
	PortableLocalUserSignIn = Ps3LocalUserSignIn
end
