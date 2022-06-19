if SystemInfo:platform() == "X360" then
	require("local_user/activity_tracker/xbox360/Xbox360LocalUserActivityTracker")
	PortableLocalUserActivityTracker = Xbox360LocalUserActivityTracker
elseif SystemInfo:platform() == "WIN32" then
	require("local_user/activity_tracker/pc/PcLocalUserActivityTracker")
	PortableLocalUserActivityTracker = PcLocalUserActivityTracker
elseif SystemInfo:platform() == "PS3" then
	require("local_user/activity_tracker/ps3/Ps3LocalUserActivityTracker")
	PortableLocalUserActivityTracker = Ps3LocalUserActivityTracker
else
	assert(false, "Unknown platform")
end
