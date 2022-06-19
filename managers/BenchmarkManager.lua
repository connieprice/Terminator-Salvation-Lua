if not BenchmarkManager then
	BenchmarkManager = class(CoreBenchmarkManager)
end
BenchmarkManager.init = function(l_1_0)
	CoreBenchmarkManager.init(l_1_0, 1500)
	l_1_0._t = 0
	l_1_0._fps = 0
	l_1_0._ticks = 0
	l_1_0:set_callbacks(nil, callback(l_1_0, l_1_0, "benchmark_values"))
end

BenchmarkManager.paused_update = function(l_2_0, l_2_1, l_2_2)
	l_2_0:update(l_2_1, l_2_2)
end

BenchmarkManager.update = function(l_3_0, l_3_1, l_3_2)
	CoreBenchmarkManager.update(l_3_0, l_3_1, l_3_2)
	l_3_0._ticks = l_3_0._ticks + 1
	l_3_0._t = l_3_0._t + l_3_2
	if l_3_0._t >= 1 then
		l_3_0._t = l_3_0._t - 1
		l_3_0._fps = l_3_0._ticks
		l_3_0._ticks = 0
	end
end

BenchmarkManager.benchmark_values = function(l_4_0)
	local l_4_1 = {}
	l_4_1.fps = l_4_0._fps
	return l_4_1
end


