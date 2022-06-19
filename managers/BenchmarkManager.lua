BenchmarkManager = BenchmarkManager or class(CoreBenchmarkManager)
function BenchmarkManager.init(A0_0)
	CoreBenchmarkManager.init(A0_0, 1500)
	A0_0._t = 0
	A0_0._fps = 0
	A0_0._ticks = 0
	A0_0:set_callbacks(nil, callback(A0_0, A0_0, "benchmark_values"))
end
function BenchmarkManager.paused_update(A0_1, A1_2, A2_3)
	A0_1:update(A1_2, A2_3)
end
function BenchmarkManager.update(A0_4, A1_5, A2_6)
	CoreBenchmarkManager.update(A0_4, A1_5, A2_6)
	A0_4._ticks = A0_4._ticks + 1
	A0_4._t = A0_4._t + A2_6
	if 1 <= A0_4._t then
		A0_4._t = A0_4._t - 1
		A0_4._fps = A0_4._ticks
		A0_4._ticks = 0
	end
end
function BenchmarkManager.benchmark_values(A0_7)
	({}).fps = A0_7._fps
	return {}
end
