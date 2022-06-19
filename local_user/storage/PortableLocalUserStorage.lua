if SystemInfo:platform() == "X360" then
	require("local_user/storage/xbox360/Xbox360LocalUserStorage")
	PortableLocalUserStorage = Xbox360LocalUserStorage
else
	if SystemInfo:platform() == "WIN32" then
		require("local_user/storage/pc/PcLocalUserStorage")
		PortableLocalUserStorage = PcLocalUserStorage
	end
else
	if SystemInfo:platform() == "PS3" then
		require("local_user/storage/ps3/Ps3LocalUserStorage")
		PortableLocalUserStorage = Ps3LocalUserStorage
	end
end

