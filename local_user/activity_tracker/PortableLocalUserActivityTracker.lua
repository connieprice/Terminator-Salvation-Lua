if SystemInfo:platform() == "X360" then
	require("local_user/activity_tracker/xbox360/Xbox360LocalUserActivityTracker")
	PortableLocalUserActivityTracker = Xbox360LocalUserActivityTracker
else
	if SystemInfo:platform() == "WIN32" then
		require("local_user/activity_tracker/pc/PcLocalUserActivityTracker")
		PortableLocalUserActivityTracker = PcLocalUserActivityTracker
	end
else
	if SystemInfo:platform() == "PS3" then
		require("local_user/activity_tracker/ps3/Ps3LocalUserActivityTracker")
		PortableLocalUserActivityTracker = Ps3LocalUserActivityTracker
	end
else
	assert(false, "Unknown platform")
end

